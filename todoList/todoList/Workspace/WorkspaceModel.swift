//
//  WorkspaceModel.swift
//  todoList
//
//  Created by 김상현 on 2021/03/31.
//

import Foundation

struct WorkspaceBoardModel : Equatable, Codable {
    var id : Int
    var boardName : String
    var workspaceTodo : [WorkspaceTodoModel] = []
    
    mutating func update(boardName: String) {
        // TODO: update 로직 추가
        self.boardName = boardName
    }
    
    // Equatable 로 '==' 연산자 임의로 정의.
    static func == (lhs: Self, rhs: Self) -> Bool {
        // Todo동등 조건 추가
        return lhs.id == rhs.id
    }
    
}

struct WorkspaceTodoModel : Equatable, Codable {
    var id : Int
    var todo : String
    
    mutating func update(todo: String) {
        self.todo = todo
    }
    
    // Equatable 로 '==' 연산자 임의로 정의.
    static func == (lhs: Self, rhs: Self) -> Bool {
        // Todo동등 조건 추가
        return lhs.id == rhs.id
    }
}

class WorkspaceBoardModelManager {
    
    let homeModelShared = HomeModelManager.HomeModelShared
    
    static let workspaceModelManager = WorkspaceBoardModelManager()
    
    static var workspaceBoardModelLastId: Int = 0
    static var workspaceTodoModelLastId: Int = 0
    
    var workspaceBoardModelArray : [WorkspaceBoardModel] = []
    
    func createWorkspaceBoardModel (boardName : String) -> WorkspaceBoardModel {
        let nextId = Self.workspaceBoardModelLastId + 1
        Self.workspaceBoardModelLastId = nextId
        return WorkspaceBoardModel(id: nextId, boardName: boardName)
    }
    
    func addWorkspaceBoardModel (input: WorkspaceBoardModel , identifier : HomeModel) {
        
        if let index = homeModelShared.HomeModelArray.firstIndex(of: identifier) {
            homeModelShared.HomeModelArray[index].workspaceBoard.append(input)
            homeModelShared.saveHomeModel()
        }
        
//        HomeModelManager.HomeModelShared.addWorkspaceBoardModel(input: input, identifier: identifier)
    }
    
    
}
