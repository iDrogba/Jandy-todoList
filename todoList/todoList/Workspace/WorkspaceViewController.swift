//
//  WorkspaceViewController.swift
//  todoList
//
//  Created by 김상현 on 2021/03/30.
//

import UIKit

class WorkspaceViewController: UIViewController {
        
    static var HM : HomeModel = HomeModelManager.HomeModelShared.HomeModelArray[0]
    
    @IBOutlet weak var WorkspaceCollectionView: UICollectionView!
    @IBOutlet weak var WorkspaceProjectName: UINavigationItem!
    
    let workspaceBoardModelShared = WorkspaceBoardModelManager.workspaceBoardModelManager
    
    let workspaceTodoModelShared = WorkspaceTodoModelManager.workspaceTodoModelManager
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        // 불러오기 해야함!
        
        workspaceBoardModelShared.addWorkspaceBoard(input: workspaceBoardModelShared.createWorkspaceBoard(boardName: "1차 product backlog"), identifier: WorkspaceViewController.HM)
        workspaceTodoModelShared.addWorkspaceTodo(input: workspaceTodoModelShared.createWorkspaceTodo(input: "관리자 메뉴 화면 구현."), identifier1: workspaceBoardModelShared.workspaceBoardModelArray[0], identifier2: WorkspaceViewController.HM)

        workspaceBoardModelShared.retrieveWorkspaceBoard(identifier: WorkspaceViewController.HM)
        
        
        // Do any additional setup after loading the view.
    }
    

}


extension WorkspaceViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workspaceBoardModelShared.workspaceBoardModelArray[section].workspaceTodo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? collectionViewCell else {return UICollectionViewCell()}
        
   
        cell.doneButtonTapHandler = {
            self.workspaceTodoModelShared.toggleWorkspaceTodoisDone(index1: indexPath.section, index2: indexPath.item, homeModel: WorkspaceViewController.HM )
            
            self.WorkspaceCollectionView.reloadData()
        }
        
        cell.deleteButtonTapHandler = {
            self.workspaceTodoModelShared.deleteWorkspaceTodo(index1: indexPath.section, index2: indexPath.item, homeModel: WorkspaceViewController.HM)
            self.WorkspaceCollectionView.reloadData()
        }
        
       
        cell.update(input: workspaceBoardModelShared.workspaceBoardModelArray[indexPath.section], section: indexPath.item)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader :
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHeader", for: indexPath) as? collectionViewHeader else {
                return UICollectionReusableView()
            }
            if ( workspaceBoardModelShared.workspaceBoardModelArray.count != 0) {
            header.update(input: workspaceBoardModelShared.workspaceBoardModelArray[indexPath.row])
            }
            return header
            
        case UICollectionView.elementKindSectionFooter :
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewFooter", for: indexPath) as? collectionViewFooter else {
                return UICollectionReusableView()
            }
            
            footer.addButtonTapHandler = {
                let alert = UIAlertController(title: nil, message: "새 작업을 추가하세요.", preferredStyle: .alert)
                alert.addTextField(configurationHandler: nil)
                        let cancel = UIAlertAction(title: "취소", style: .default) { (cancel) in
                             //code
                        }
                        let ok = UIAlertAction(title: "확인", style: .cancel) { (ok) in
                            
                            if let text = alert.textFields?[0].text {
                                let todo = self.workspaceTodoModelShared.createWorkspaceTodo(input: text)
                                self.workspaceTodoModelShared.addWorkspaceTodo(input: todo, identifier1: self.workspaceBoardModelShared.workspaceBoardModelArray[indexPath.section], identifier2: WorkspaceViewController.HM)
                                self.WorkspaceCollectionView.reloadData()
                            }
                            
                        }
                        alert.addAction(cancel)
                        alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)

            }
            return footer
        default:
            return UICollectionReusableView()
        }
    }

    @IBAction func addColumn(_ sender: Any) {
        
    }
}

extension WorkspaceViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = WorkspaceCollectionView.bounds.width
        let height: CGFloat = 50
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = WorkspaceCollectionView.frame.width
        let height: CGFloat = 50
        let itemSize = CGSize(width: width, height: height)
        
        return itemSize
    }
    
}

class collectionViewCell :UICollectionViewCell {
    
    @IBOutlet weak var CellCheckBtn: UIButton!
    @IBOutlet weak var CellContent: UILabel!
    @IBOutlet weak var CellDeleteBtn: UIButton!
    
    var doneButtonTapHandler: (() -> Void)?
    var deleteButtonTapHandler: (() -> Void)?
    
    @IBOutlet weak var viewConstraintHeight: NSLayoutConstraint!
    
    func update(input : WorkspaceBoardModel, section : Int){
        CellContent.text = input.workspaceTodo[section].todo
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    func reset() {
        // [x] TODO: reset로직 구현
        CellContent.alpha = 1
        CellDeleteBtn.isHidden = true
        showStrikeThrough(false)
    }
    
    private func showStrikeThrough(_ show: Bool) {
        if show {
            viewConstraintHeight.constant = 1
        } else {
            viewConstraintHeight.constant = 0
        }
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        // [x] TODO: checkButton 처리
        CellCheckBtn.isSelected = !CellCheckBtn.isSelected
        let isDone = CellCheckBtn.isSelected
        showStrikeThrough(isDone)
        CellContent.alpha = isDone ? 0.2 : 1
        CellDeleteBtn.isHidden = !isDone
        
        doneButtonTapHandler?()
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        // [x] TODO: deleteButton 처리
        deleteButtonTapHandler?()
    }
    
    
}

class collectionViewHeader : UICollectionReusableView {

    @IBOutlet weak var HeaderTitle: UILabel!
    
    
    func update(input : WorkspaceBoardModel) {
        HeaderTitle.text = input.boardName
    }
}

class collectionViewFooter : UICollectionReusableView {
    
    @IBOutlet weak var FooterAddBtn: UIButton!
    var addButtonTapHandler: (() -> Void)?

    
    
    @IBAction func addTodo(_ sender: Any) {
        addButtonTapHandler?()
    }
    
    
}
