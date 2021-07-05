//
//  HomeModel.swift
//  todoList
//
//  Created by 김상현 on 2021/03/22.
//


struct HomeModel : Equatable, Codable{
    var id : Int
    var projectName : String
    var projectDescription : String?
    var content : String?
    
    mutating func update(projectName: String, projectDescription: String?) {
        // TODO: update 로직 추가
        self.projectName = projectName
        self.projectDescription = projectDescription
    }
    
    // Equatable 로 '==' 연산자 임의로 정의.
    static func == (lhs: Self, rhs: Self) -> Bool {
        // Todo동등 조건 추가
        return lhs.id == rhs.id
    }
    
}

// 여러개 존재하는 HomeModel 객체를 관리

class HomeModelManager {
    // 싱글톤~!
    static let HomeModelShared = HomeModelManager()
    
    static var HomeModelLastId: Int = 0
    
    var HomeModelArray : [HomeModel] = []
    
    func createHomeModel (projectName : String, projectDescription : String?) -> HomeModel {
        let nextId = Self.HomeModelLastId + 1
        Self.HomeModelLastId = nextId
        return HomeModel(id: nextId, projectName: projectName, projectDescription: projectDescription)
    }
    
    func addHomeModel (input: HomeModel) {
        HomeModelArray.append(input)
        saveHomeModel()
    }
    
    func addHomeModelAt (at:Int, input: HomeModel) {
        HomeModelArray.insert(input, at: at)
        saveHomeModel()
    }
    
    func deleteHomeModel( HomeModel : HomeModel) {
        if let index = HomeModelArray.firstIndex(of: HomeModel){
        HomeModelArray.remove(at: index)
        }
        saveHomeModel()
    }
    
    func updateHomeModelContent(ID : Int, content : String?) {
        if let index = HomeModelArray.firstIndex(where: {$0.id == ID}){
            HomeModelArray[index].content = content
        }
        saveHomeModel()
    }
    
//    func updateTodo ( HomeModel : HomeModel) {
//        guard let index = HomeModelArray.firstIndex(of: HomeModel) else {return}
//        HomeModelArray[index].update(projectName: HomeModel.projectName, projectDescription: HomeModel.projectDescription)
//        saveHomeModel()
//    }
//
//    func swapTodo (from :Int,to : Int) {
//        HomeModelArray.swapAt(from, to)
//        saveHomeModel()
//    }
    
    func saveHomeModel(){
        Storage.store(HomeModelArray, to: .documents, as: "HomeModel.json")
    }
    
    func retrieveTodo() {
        HomeModelManager.HomeModelShared.HomeModelArray = Storage.retrive("HomeModel.json", from: .documents, as: [HomeModel].self) ?? []

        let lastId = HomeModelArray.last?.id ?? 0
        HomeModelManager.HomeModelLastId = lastId
    }

    func searchHomeModel(ID: Int)-> HomeModel? {
        if let firstIndex = HomeModelArray.firstIndex(where: {$0.id == ID}){
            return HomeModelArray[firstIndex]
        }
        return nil
    }

//    func addWorkspaceBoardModel(input: WorkspaceBoardModel, identifier : HomeModel) {
//        if let index = HomeModelArray.firstIndex(of: identifier) {
//            HomeModelArray[index].workspaceBoard.append(input)
//        }
//        saveHomeModel()
//    }
    
    // 부가기능
    func countHomeModel ()-> Int {
        return HomeModelArray.count
    }
    
}


