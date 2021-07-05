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
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HM = HomeModelManager.HomeModelShared.searchHomeModel(ID: currentMemoID)
        textField.text = HM?.content
        
        // textfield 변경감지
        self.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
        HomeModelManager.HomeModelShared.updateHomeModelContent(ID: currentMemoID, content: textField.text)
      }
    
    @IBAction func backwardButtonTapped(_ sender: Any) {
        
        dismiss(animated: false, completion: nil)
    }
    
}

extension MemoViewController : UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
}
