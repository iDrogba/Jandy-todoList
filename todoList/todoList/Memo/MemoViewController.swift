//
//  MemoViewController.swift
//  todoList
//
//  Created by 김상현 on 2021/07/04.
//

import Foundation
import UIKit

class MemoViewController : UIViewController {
    
    var HM : HomeModel?
    var currentMemoID = 0
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        HM = HomeModelManager.HomeModelShared.searchHomeModel(ID: currentMemoID)
        textView.text = HM?.content
        
        // 키보드 사용 감시
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
  
    
    @IBAction func backwardButtonTapped(_ sender: Any) {
        HomeModelManager.HomeModelShared.updateHomeModelContent(ID: currentMemoID, content: textView.text)
        dismiss(animated: false, completion: nil)
    }
    
}

extension MemoViewController : UITextViewDelegate {
  
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
      
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        
        if noti.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height + 10 - view.safeAreaInsets.bottom
            textViewBottomConstraint.constant = adjustmentHeight
        } else {
            textViewBottomConstraint.constant = 10
        }
    }
}
