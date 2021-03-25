//
//  homeViewController.swift
//  todoList
//
//  Created by 김상현 on 2021/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var HomeTableView: UITableView!
    
    let homeModelManager = HomeModelManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터 불러오기
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HomeTableView.reloadData()
    }
    
}

// 테이블 터치될때
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

// 다시구현 , 데이터베이스 loadTask 로 시작할때 싱글톤 객체이 배열로 정보 가져오기 , 
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // table view cell 개수
        return 3
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
