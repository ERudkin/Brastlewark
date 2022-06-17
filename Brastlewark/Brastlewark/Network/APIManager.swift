//
//  APIManager.swift
//  Brastlewark
//
//  Created by Cano Rudkin, Elliot Joseph on 15/6/22.
//

import Foundation

protocol APIManagerDelegate {
    func didRetrieveDataSuccessfully(results: [Gnome])
    func didRetrieveDataWithError(error: Error)
}

class APIManager {
    let urlString = "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json"
    
    var delegate: APIManagerDelegate?
    
    
    
    func fetchData() {
        guard let url = URL(string: urlString) else {return}
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("error retrieving data")
                self.delegate?.didRetrieveDataWithError(error: error!)
                return

            }
            
            if let data = data {
                
                let decoder = JSONDecoder()
                
                if let results = try? decoder.decode(Brastlewark.self, from: data){
                    self.delegate?.didRetrieveDataSuccessfully(results: results.brastlewark)
                }
            }
        }.resume()
    }
    
    

}
