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
        
        workspaceBoardModelShared.addWorkspaceBoard(input: workspaceBoardModelShared.createWorkspaceBoard(boardName: "ㅎㅇ"), identifier: WorkspaceViewController.HM)
        workspaceTodoModelShared.addWorkspaceTodo(input: workspaceTodoModelShared.createWorkspaceTodo(input: "tlqkf"), identifier1: workspaceBoardModelShared.workspaceBoardModelArray[0], identifier2: WorkspaceViewController.HM)
        
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
        
        cell.doneButtonTapHandler = { isDone in
            todo.isDone = isDone
            self.todoListViewModel.updateTodo(todo)
            self.collectionView.reloadData()
        }
        
        cell.deleteButtonTapHandler = {
            self.todoListViewModel.deleteTodo(todo)
            self.collectionView.reloadData()
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
            return footer
        default:
            return UICollectionReusableView()
        }
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
    
    @IBOutlet weak var viewConstraintHeight: NSLayoutConstraint!
    
    func update(input : WorkspaceBoardModel, section : Int){
        CellContent.text = input.workspaceTodo[section].todo
    }
    
    private func showStrikeThrough(_ show: Bool) {
        if show {
            viewConstraintHeight.constant = 1
        } else {
            viewConstraintHeight.constant = 0
        }
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
    
}
