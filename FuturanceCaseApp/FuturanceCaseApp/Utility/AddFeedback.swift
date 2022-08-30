//
//  AddFeedback.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 26.08.2022.
//

import UIKit

final class ShowFeedBack {
    let feedBack: Feedback
    let controller: UIAlertController
    let logic: Bool
    let actionHandler: ((UIAlertAction) -> Void)?
    
    init(feedback: Feedback, logic: Bool = false, _ actionHandler: @escaping (UIAlertAction) -> Void) {
        self.feedBack = feedback
        self.logic = logic
        self.actionHandler = actionHandler
        self.controller = UIAlertController(title: feedback.title, message: feedback.returnContainer, preferredStyle: .alert)
        let action = UIAlertAction(title: "Kapat", style: .cancel)
        if logic {
            let action2 = UIAlertAction(title: "Tamam", style: .default, handler: actionHandler)
            controller.addAction(action2)
        }
         controller.addAction(action)
    }
}
