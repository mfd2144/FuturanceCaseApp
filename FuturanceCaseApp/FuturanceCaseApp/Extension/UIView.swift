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
    
    public func showLoadingIndicator() {
        let indicator = UIActivityIndicatorView(frame: self.frame)
        let transpranView = UIImageView()
        transpranView.tag = 144
        indicator.tag = 244
        transpranView.frame = self.bounds
        transpranView.backgroundColor = UIColor.black
        transpranView.isUserInteractionEnabled = true
        transpranView.alpha = 0.5
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = transpranView.center
        indicator.startAnimating()
        indicator.color = .systemTeal
        DispatchQueue.main.async {
            self.addSubview(transpranView)
            self.addSubview(indicator)
            self.bringSubviewToFront(transpranView)
            self.bringSubviewToFront(indicator)
        }
    }
    public func hideLoadingIndıcator() {
        DispatchQueue.main.async { [self] in
            viewWithTag(144)?.removeFromSuperview()
            viewWithTag(244)?.removeFromSuperview()
        }
    }
    
}
