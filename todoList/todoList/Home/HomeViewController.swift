//
//  homeViewController.swift
//  todoList
//
//  Created by 김상현 on 2021/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeModelManager = HomeModelManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
}

// 테이블 터치될때
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // table view cell 개수
        return homeModelManager.countHomeModel()
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
