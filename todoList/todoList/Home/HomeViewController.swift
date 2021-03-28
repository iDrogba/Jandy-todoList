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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeModelManager.HomeModelShared.retrieveTodo()
        // 데이터 불러오기
        print(HomeModelManager.HomeModelShared.HomeModelArray.count)

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
}

extension Notification.Name {
    static let didCompleteAdd = Notification.Name("didCompleteAdd")
}

// 테이블 터치될때
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

// 다시구현
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // table view cell 개수
        return HomeModelManager.HomeModelShared.HomeModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as? HomeTableCell else { return UITableViewCell()}
        
        cell.updateUI(HomeModel: HomeModelManager.HomeModelShared.HomeModelArray[indexPath.row])
        
        //deletebutton Handler, doneButton Handler
        
        return cell
        
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
