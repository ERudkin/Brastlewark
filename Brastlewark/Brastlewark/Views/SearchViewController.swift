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
    
    @IBOutlet weak var activtyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activtyIndicator.startAnimating()
        self.viewModel.apiManager.delegate = self
        searchBar.delegate = self
        viewModel.fetchData()
        setupSearchBar()
    }
    
    
    private func setupSearchBar(){
        searchBar.layer.cornerRadius = 25
        searchBar.backgroundImage = UIImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueID {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.gnome = viewModel.selectedGnome
        }
    }
    
}


extension SearchTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var gnome: Gnome {
            isSearching == true ? viewModel.searchedGnomes[indexPath.row] : viewModel.gnomes[indexPath.row]
        }
        
        viewModel.selectedGnome = gnome
        performSegue(withIdentifier: Constants.segueID, sender: self)
    }
    
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
    func didRetrieveDataWithError(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.errorView.isHidden = false
            self?.activtyIndicator.stopAnimating()
        }
    }
    
    func didRetrieveDataSuccessfully(results: [Gnome]) {
        self.viewModel.gnomes = results
        DispatchQueue.main.async { [weak self] in
            self?.tableView.delegate = self
            self?.tableView.dataSource = self
            self?.activtyIndicator.stopAnimating()
            self?.tableView.reloadData()
        }
        
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != "" {
            viewModel.searchedText = searchBar.text ?? ""
            viewModel.filterGnomes()
            isSearching = true
        }
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
