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

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("----->\(indexPath.item)")
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // table view cell 개수
        return homeModelManager.numOfHomeModel()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as? HomeTableCell else { return UITableViewCell()}
        
        cell.update(projectName: homeModelManager.projectNameOfNum(input : indexPath.row))
        return cell
        
    }
}

class HomeTableCell : UITableViewCell {
    
    @IBOutlet weak var homeTableCellLabel: UILabel!
    
    func update(projectName : String) {
        homeTableCellLabel.text = projectName
    }
    
}
