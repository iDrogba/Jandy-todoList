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
    
    mutating func update(boardName: String, workspaceTodo : [WorkspaceTodoModel]) {
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
    
    static let workspaceBoardModelManager = WorkspaceBoardModelManager()
    
    static var workspaceBoardModelLastId: Int = 0
    
    var workspaceBoardModelArray : [WorkspaceBoardModel] = []
    
    func createWorkspaceBoard (boardName : String) -> WorkspaceBoardModel {
        let nextId = Self.workspaceBoardModelLastId + 1
        Self.workspaceBoardModelLastId = nextId
        return WorkspaceBoardModel(id: nextId, boardName: boardName)
    }
    
    func addWorkspaceBoard (input: WorkspaceBoardModel, identifier : HomeModel) {
        
        workspaceBoardModelArray.append(input)
        saveWorkspaceBoard(identifier: identifier)
        
    }
    
    func countWorkspaceBoard(identifier : HomeModel) -> Int {
        guard let index = homeModelShared.HomeModelArray.firstIndex(of: identifier) else { return 0 }
            return homeModelShared.HomeModelArray[index].workspaceBoard.count
    }
  
    func saveWorkspaceBoard(identifier : HomeModel) {
        if let index = homeModelShared.HomeModelArray.firstIndex(of: identifier) {
            homeModelShared.HomeModelArray[index].workspaceBoard = workspaceBoardModelArray
        }
        homeModelShared.saveHomeModel()
    }
  
    // 특정 HomeModel의 workspaceBoard 배열을 현재 객체의 배열한테 끼워줌
    func retrieveWorkspaceBoard(identifier : HomeModel) {
        if let index = homeModelShared.HomeModelArray.firstIndex(of: identifier) {
           workspaceBoardModelArray = homeModelShared.HomeModelArray[index].workspaceBoard
        }
        let lastid = workspaceBoardModelArray.last?.id ?? 0
        WorkspaceBoardModelManager.workspaceBoardModelLastId = lastid
    }

    
}
class WorkspaceTodoModelManager {
    
    let workspaceBoardModelShared = WorkspaceBoardModelManager.workspaceBoardModelManager
    
    static var workspaceTodoModelManager = WorkspaceTodoModelManager()
    
    var workspaceTodoModelArray : [WorkspaceTodoModel] = []
    
    static var workspaceTodoModelLastId: Int = 0
    
    
    // 정확히는 workspaceboardmanager class에있는 workspaceboardmodelarray 배열을 저장하는 메서드
    func saveWorkspaceTodo(identifier1 : WorkspaceBoardModel, identifier2 : HomeModel) {
        if let index = workspaceBoardModelShared.workspaceBoardModelArray.firstIndex(of: identifier1) {
            workspaceBoardModelShared.workspaceBoardModelArray[index].workspaceTodo = workspaceTodoModelArray
        }
        workspaceBoardModelShared.saveWorkspaceBoard(identifier: identifier2)
    }
    
    func createWorkspaceTodo (input: String) -> WorkspaceTodoModel{
        let nextId = Self.workspaceTodoModelLastId + 1
        Self.workspaceTodoModelLastId = nextId
        return WorkspaceTodoModel(id: nextId, todo: input)
    }
    
    func retrieveWorkspaceTodo(identifier : WorkspaceBoardModel) {
        if let index = workspaceBoardModelShared.workspaceBoardModelArray.firstIndex(of: identifier) {
            workspaceTodoModelArray = workspaceBoardModelShared.workspaceBoardModelArray[index].workspaceTodo
        }
        let lastid = workspaceTodoModelArray.last?.id ?? 0
        WorkspaceTodoModelManager.workspaceTodoModelLastId = lastid
    }
    
    func addWorkspaceTodo (input : WorkspaceTodoModel, identifier1 : WorkspaceBoardModel, identifier2 : HomeModel) {
        workspaceTodoModelArray.append(input)
        saveWorkspaceTodo(identifier1: identifier1, identifier2: identifier2)
    }
}
