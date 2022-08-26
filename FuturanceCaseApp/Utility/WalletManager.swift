//
//  WalletManager.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 26.08.2022.
//

import Foundation
import Combine

final class WalletManager {
    static let shared = WalletManager()
    var myWallet = CurrentValueSubject<MyWallet, Never>(MyWallet(entities: [.init(name: "TRY", amount: 2000)]))
    
    var subscriptions = Set<AnyCancellable>()
    private var url: URL? {
        let fileManager = FileManager.default
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("MyWallet.plist")
    }
    
    private init() {}
    
    func checkEntitiesInMyWallet() {
        guard let url = url else {
            return
        }
        let decoder = PropertyListDecoder()
        
        do {
            // if data exist
            let data = try Data(contentsOf: url)
            let actualWallet = try decoder.decode(MyWallet.self, from: data)
            print(actualWallet)
            myWallet.send(actualWallet)
        } catch {
            // if not
            let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(myWallet.value)
                try data.write(to: url)
            } catch {
                fatalError("Fetch wallet data error")
            }
        }
    }
    
    // MARK: - Buy coin
    func buyEntity(entity: Entity, rate: Double, completion: (Result<String>) -> Void) {
        guard let url = url else {
            completion(.error(FuturanceError.emptyURL))
            return }
        let encoder = PropertyListEncoder()
        
        do {
            // 1.TAKE ALL ENTITIES IN WALLET
            var oldEntities = myWallet.value.entities
            // 2.calculate user have enough money
            let (calculatedAmount, calculatedRemaningTry) = sellingCalculator(rate: rate, for: entity.amount)
            // 3.check calculated amount is greater than 0
            guard tradeIsPossible(for: calculatedRemaningTry) else {
                completion(.error(FuturanceError.doesntHaveEnoughAmountMoney))
                return
            }
            // 4.CHECK SAME KIND ENTITY EXISTS IN WALLET
            if let index = oldEntities.firstIndex(where: { $0.name == entity.name }) {
                print(index)
                // it exists in entites already
                oldEntities[index].amount += entity.amount
            } else {
                // first purchase
                oldEntities.append(entity)
            }
            // 5.Reduce TRY in Wallet
            dropInTryAccount(calculatedAmount, from: &oldEntities)
            
            // 6. create new wallet
            let newWallet = MyWallet(entities: oldEntities)
            print(newWallet.entities)
            
            // 7. write wallet information and send to subscribers
            myWallet.send(newWallet)
            let data = try encoder.encode(newWallet)
            try data.write(to: url)
            completion(.success("Başarıyla \(entity.amount) tane \(entity.name) coinden alış yapıldı."))
        } catch {
            fatalError("Fetch wallet data error")
        }
    }
    private func sellingCalculator(rate entityRate: Double, for amount: Double) -> (calculatedAmmount: Double, calculatedRemaningTRY: Double) {
        // first app find how much try user have
        guard let tryAmount = myWallet
            .value
            .entities
            .first(where: { $0.name.lowercased() == "try" })?
            .amount else { return (0, -1) }
        let calculatedAmount = amount * entityRate
        let remaningTRY = tryAmount - calculatedAmount
        return (calculatedAmount, remaningTRY)
    }
    private func tradeIsPossible(for calculatedValue: Double ) -> Bool {
        return !calculatedValue.isLess(than: 0)
    }
    private func dropInTryAccount(_ amount: Double, from entities: inout [Entity] ) {
        guard let index = entities.firstIndex(where: { $0.name.lowercased() == "try" }) else { fatalError("önceden check edildiği için sadece optinal kurtulmak için kullanıldı") }
        let remaing = entities[index].amount - amount
        print(remaing)
        entities[index].amount = remaing
    }
    
    // MARK: - Sell coin
    func sellEntity(entity: Entity, rate: Double, completion: (Result<String>) -> Void) {
        // 1. calculate and check entity and new try balance
        let (calculatedNewTRYBalance, calculatedRemaningEntity) = buyingCalculator(rate: rate, for: entity)
        // 2. check enough entity for selling process
        guard tradeIsPossible(for: calculatedRemaningEntity) else {
            completion(.error(FuturanceError.doesntHaveEnoughAmountMoney))
            return
        }
        // 3. create necessasry object and check url
        guard let url = url else {
            completion(.error(FuturanceError.emptyURL))
            return }
        let encoder = PropertyListEncoder()
        // 4. fetch wallet and entity index
        var oldEntities = myWallet.value.entities
        guard let tryIndex = oldEntities.firstIndex(where: { $0.name.lowercased() == "try" }),
             let  entityIndex = oldEntities.firstIndex(where: { $0.name.lowercased() == entity.name.lowercased() })
        else { fatalError("user must have TRY entity in his account") }
        
        // 5. adjust new wallet
        oldEntities[tryIndex].amount += calculatedNewTRYBalance
        oldEntities[entityIndex].amount = calculatedRemaningEntity
        let newWallet = MyWallet(entities: oldEntities)
        
        // 6. write wallet information and send to subscribers
        do {
        myWallet.send(newWallet)
        let data = try encoder.encode(newWallet)
        try data.write(to: url)
        completion(.success("Başarıyla \(entity.amount) tane \(entity.name) coinden alış yapıldı."))
    } catch {
        fatalError("Fetch wallet data error")
    }
        
    }
    private func buyingCalculator(rate entityRate: Double, for willSellEntity: Entity) -> (calculatedNewTRYBalance: Double, calculatedRemaningEntity: Double) {
        // 1. app find entity exists
        guard let entity = myWallet
            .value
            .entities
            .first(where: { $0.name.lowercased() == willSellEntity.name.lowercased() })
             else { return (0, -1) }
        // 2. have check actual amount entity is enough for user demand
        guard  entity.amount >= willSellEntity.amount else {
            return (0, -1)
        }
        let calculatedRemaningEntity = entity.amount - willSellEntity.amount
        let calculatedNewTRYBalance = entityRate * willSellEntity.amount
        return (calculatedNewTRYBalance, calculatedRemaningEntity)
       
        
    }
}
