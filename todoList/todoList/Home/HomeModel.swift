//
//  HomeModel.swift
//  todoList
//
//  Created by 김상현 on 2021/03/22.
//


struct HomeModel {
    var projectName : String
    var projectDescription : String
}



class HomeModelManager {
    var HomeModelArray : [HomeModel] = []
    
    func addHomeModel (input: HomeModel) {
        HomeModelArray.append(input)
    }
    
    func numOfHomeModel ()-> Int {
        return HomeModelArray.count
    }
    
    func projectNameOfNum (input : Int) -> String {
        return HomeModelArray[input].projectName
    }
}
