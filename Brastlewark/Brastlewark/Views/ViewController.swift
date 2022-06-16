//
//  ViewController.swift
//  Brastlewark
//
//  Created by Cano Rudkin, Elliot Joseph on 14/6/22.
//

import UIKit

class SearchTableViewController: UIViewController {
    var viewModel = SearchVCViewModel()
    var isSearching = false
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel.apiManager.delegate = self
        searchBar.delegate = self
        viewModel.fetchData()
        searchBar.layer.cornerRadius = 25
    }

    
}


extension SearchTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching == true ? viewModel.searchedGnomes.count : viewModel.gnomes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! SearchViewCell
        
        var gnome: Gnome {
            isSearching == true ? viewModel.searchedGnomes[indexPath.row] : viewModel.gnomes[indexPath.row]
        }
        cell.setup(gnome)
        return cell
    }
}

extension SearchTableViewController: APIManagerDelegate {
    func didRetrieveDataSuccessfully(results: [Gnome]) {
        self.viewModel.gnomes = results
        DispatchQueue.main.async { [weak self] in
            self?.tableView.delegate = self
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
        
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchedText = searchBar.text ?? ""
        viewModel.filterGnomes()
        isSearching = true
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
