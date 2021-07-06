//
//  homeViewController.swift
//  todoList
//
//  Created by 김상현 on 2021/03/22.
//

import UIKit
import NotificationCenter

class HomeViewController: UIViewController {
            
    @IBOutlet weak var HomeTableView: UITableView!
    @IBOutlet weak var HomeEditBtn: UIBarButtonItem!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeModelManager.HomeModelShared.retrieveTodo()
        
        // notificationcenter -> modal 끝날때 호출
        NotificationCenter.default.addObserver(
            self, // observer가 될 object
            selector: #selector(viewWillAppear(_:)), // noti가 오면 실행할 함수
            name: .didCompleteAdd, // Noti의 이름
            object: nil // noti받을 대상. 지정하면 특정 sender에게만 notif를 받음 (optional)
        )
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HomeTableView.reloadData()
    }
    
    @IBAction func swipeGestureRecognize(_ sender: Any) {
        
    }
    
}

extension Notification.Name {
    static let didCompleteAdd = Notification.Name("didCompleteAdd")
}

// 테이블 터치될때
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Memo", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "MemoViewController") as! MemoViewController
        vc.currentMemoID = HomeModelManager.HomeModelShared.HomeModelArray[indexPath.row].id
        self.present(vc, animated: false, completion: nil)
    }
    
}


extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // table view cell 개수
        return HomeModelManager.HomeModelShared.HomeModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as? HomeTableCell else { return UITableViewCell()}
        
        cell.updateUI(HomeModel: HomeModelManager.HomeModelShared.HomeModelArray[indexPath.row])
        
        
        return cell
        
    }
    @IBAction func editMode(_ sender: Any) {
        if  self.HomeTableView.isEditing {
            self.HomeEditBtn.title = "편집"
            self.HomeTableView.setEditing(false, animated: true)
            }
        else {
            self.HomeEditBtn.title = "완료"
            self.HomeTableView.setEditing(true, animated: true)
            }
    }
}

extension HomeViewController {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            HomeModelManager.HomeModelShared.deleteHomeModel(HomeModel: HomeModelManager.HomeModelShared.HomeModelArray[indexPath.row])
            HomeTableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {

        }
    }
    
    // edit mode가아니라면 스와이프 삭제 못하게함
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if HomeTableView.isEditing {
            return true
        }
        else {
            return false
        }
    }
    
     // 삭제시 "삭제" 글자 넣는 메서드
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
 
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let HM = HomeModelManager.HomeModelShared.HomeModelArray[fromIndexPath.row]
        HomeModelManager.HomeModelShared.deleteHomeModel(HomeModel: HomeModelManager.HomeModelShared.HomeModelArray[fromIndexPath.row])
        HomeModelManager.HomeModelShared.addHomeModelAt(at: to.row, input: HM)
        HomeTableView.reloadData()
    }
    
}

class HomeTableCell : UITableViewCell {
    
    @IBOutlet weak var homeTableCellProjectName: UILabel!
    @IBOutlet weak var homeTableCellProjectDescription: UILabel!
    
    

    func updateUI(HomeModel : HomeModel) {
        homeTableCellProjectName.text = HomeModel.projectName
        homeTableCellProjectDescription.text = HomeModel.projectDescription
    }

}
