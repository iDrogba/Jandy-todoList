//
//  HomeDetailViewController.swift
//  todoList
//
//  Created by 김상현 on 2021/03/22.
//

import UIKit

class HomeDetailViewController: UIViewController {
    
    let VC = HomeViewController()
    
    @IBOutlet weak var HomeDetailTextField: UITextField!
    
    @IBOutlet weak var HomeDetailTextView: UITextView!
    
    @IBOutlet weak var HomeDetailTextViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: 키보드 디텍션
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        keyboardSettings()
    }
    
    @IBAction func homeDetailAdd(_ sender: Any) {
        // 입력한거로 HomeModel 생성 및 저장
        let projectName = HomeDetailTextField.text
        if  projectName != "" {
            if HomeDetailTextView.text == "프로젝트 설명을 입력하세요." {
                HomeDetailTextView.text = nil
            }
            let HomeModelInstance = HomeModelManager.HomeModelShared.createHomeModel(projectName: projectName! , projectDescription: HomeDetailTextView.text)
            HomeModelManager.HomeModelShared.addHomeModel(input: HomeModelInstance)
            HomeModelManager.HomeModelShared.retrieveTodo()
            VC.viewReloader()
            dismiss(animated: true, completion: nil)
            }
        else {
        // 제목입력안했을 시 알림창
        let dialog = UIAlertController(title: "제목", message: "내용", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
        dialog.addAction(action)
        self.present(dialog, animated: true, completion: nil)
        }
    }
}


// UI 설정
extension HomeDetailViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        homeDetailTextViewSetPlaceholder()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        homeDetailTextViewSetPlaceholder()
    }
    
    // textview 테두리 설정
    func keyboardSettings () {
        HomeDetailTextView.layer.borderWidth = 1.0
        HomeDetailTextView.layer.borderColor = UIColor.lightGray.cgColor
        HomeDetailTextView.layer.cornerRadius = 10
    }
    
    // 화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
    // 키보드 높이에 따른 인풋뷰 위치 변경
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
      
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        
        if noti.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height + 10 - view.safeAreaInsets.bottom
            HomeDetailTextViewBottomConstraint.constant = adjustmentHeight
        } else {
            HomeDetailTextViewBottomConstraint.constant = 20
        }
    }
    
    // textview placeholder 설정
    func homeDetailTextViewSetPlaceholder() {
        if HomeDetailTextView.text == "" {
            HomeDetailTextView.text = "프로젝트 설명을 입력하세요."
            HomeDetailTextView.textColor = UIColor.lightGray
        }else if HomeDetailTextView.text == "프로젝트 설명을 입력하세요." {
            HomeDetailTextView.text = ""
            HomeDetailTextView.textColor = UIColor.black
        }
    }
    
}
