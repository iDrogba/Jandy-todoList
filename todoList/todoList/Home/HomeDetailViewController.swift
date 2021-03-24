//
//  HomeDetailViewController.swift
//  todoList
//
//  Created by 김상현 on 2021/03/22.
//

import UIKit

class HomeDetailViewController: UIViewController {

    @IBOutlet weak var HomeDetailTextField: UITextField!
    
    @IBOutlet weak var HomeDetailTextView: UITextView!
    
    @IBOutlet weak var HomeDetailTextViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: 키보드 디텍션
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        UISettings()
    }
    
    @IBAction func HomeDetailAdd(_ sender: Any) {
        // 입력한거로 HomeModel 생성 및 저장
    }

    
}

extension HomeDetailViewController {
    
    // textview 테두리 설정
    func UISettings () {
        HomeDetailTextView.layer.borderWidth = 1.0
        HomeDetailTextView.layer.borderColor = UIColor.lightGray.cgColor
        HomeDetailTextView.layer.cornerRadius = 10
    }
    
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
      
        // TODO: 키보드 높이에 따른 인풋뷰 위치 변경
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        
        if noti.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height + 10 - view.safeAreaInsets.bottom
            HomeDetailTextViewBottomConstraint.constant = adjustmentHeight
        } else {
            HomeDetailTextViewBottomConstraint.constant = 20
        }
    }
    
}


// place holder 구현!!!!
// 화면 터치시 키보드 내려가기
