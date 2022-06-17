//
//  DetailViewController.swift
//  Brastlewark
//
//  Created by Cano Rudkin, Elliot Joseph on 16/6/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var gnome = Gnome()
    
    var name: String = ""
    var age: String = ""
    var height: String = ""
    var weight: String = ""
    var professions: [String] = [""]
    var friends: [String] = [""]
    var hairColor: String = ""
    private var dataTask: URLSessionDataTask?
    
    @IBOutlet weak var friendsView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var professionsTableView: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.professions = gnome.professions
        self.friends = gnome.friends
        professionsTableView.dataSource = self
        friendsTableView.dataSource = self
        downloadImage(from: gnome.thumbnail!)
        setup()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

        
    }
    
    
    // MARK: - functions
    
    
    private func setup() {
        setupFriendsUI()
        setupImageUI()
        setupLabels()
    }
    private func setupFriendsUI() {
        if friends.isEmpty{
            friendsView.isHidden = true
            friendsTableView.isHidden = true
        }
    }
    private func setupLabels(){
        nameLabel.text = gnome.name
        weightLabel.text = "Weight: " + String(format: "%.0f", gnome.weight)
        heightLabel.text = "Height: " + String(format: "%.0f", gnome.height)
        ageLabel.text = "Age: " + String(gnome.age)
    }
    private func setupImageUI() {
        profileImage.layer.cornerRadius = 25
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = Constants.getHairColor(with: gnome.hair_color)
    }
    
    private func downloadImage(from url: URL) {
        dataTask = URLSession.cachedTask.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { [weak self] in
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                    self?.profileImage.image = UIImage(named: "ProfileImage")
                }
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.profileImage.image = UIImage(data: data)
            }
        }
        dataTask?.resume()
    }
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == professionsTableView {
            return self.professions.count
        } else {
            return self.friends.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailViewCell", for: indexPath) as! DetailViewCell
        if tableView == professionsTableView {
            
            cell.nameLabel.text = professions[indexPath.row]
        } else {
            cell.nameLabel.text = friends[indexPath.row]
        }
        cell.setup()
        
        return cell
        
    }
    
    
}
