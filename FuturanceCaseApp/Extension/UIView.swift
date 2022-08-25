//
//  UIView.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 25.08.2022.
//

import UIKit

extension UIView {
    
func keyboardSwipeView() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear(_ :)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    func killTheKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc
    private func keyboardAppear(_ notification: NSNotification) {
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        guard  let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        guard let firstPosition = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        guard let endPosition = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let difference = endPosition.origin.y - firstPosition.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {
            self.frame.size.height += difference
        }, completion: nil)
    }
}
