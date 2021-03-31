//
//  WorkspaceViewController.swift
//  todoList
//
//  Created by 김상현 on 2021/03/30.
//

import UIKit

class WorkspaceViewController: UIViewController {
    
    
    @IBOutlet weak var WorkspaceCollectionView: UICollectionView!
    @IBOutlet weak var WorkspaceProjectName: UINavigationItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension WorkspaceViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }

    
}

extension WorkspaceViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // [x] TODO: 사이즈 계산하기
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 50
        return CGSize(width: width, height: height)
    }
    
}

class collectionViewCell :UICollectionViewCell {
    
    @IBOutlet weak var CellCheckBtn: UIButton!
    @IBOutlet weak var CellContent: UILabel!
    @IBOutlet weak var CellDeleteBtn: UIButton!
    
}

class collectionViewHeader : UICollectionReusableView {

    @IBOutlet weak var HeaderTitle: UILabel!
    
}

class collectionViewFooter : UICollectionReusableView {
    
    @IBOutlet weak var FooterTextField: UITextField!
    @IBOutlet weak var FooterAddBtn: UIButton!
    
}
