//
//  SearchVCViewModel.swift
//  Brastlewark
//
//  Created by Cano Rudkin, Elliot Joseph on 15/6/22.
//

import Foundation


class SearchVCViewModel {
    let apiManager = APIManager()
    var gnomes: [Gnome] = []
    var searchedGnomes: [Gnome] = []
    var searchedText = ""
//    init() {
//        apiManager.delegate = self
//    }
    
    func filterGnomes() {
        searchedGnomes = gnomes.filter( {
            $0.name.lowercased().prefix(searchedText.count) == searchedText.lowercased() || $0.professions.contains(where: {
                $0.lowercased().prefix(searchedText.count) == searchedText.lowercased()
            })
            
        })
    }
    
    func fetchData() {
        apiManager.fetchData()
    }
}



