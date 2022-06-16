//
//  SearchViewCell.swift
//  Brastlewark
//
//  Created by Cano Rudkin, Elliot Joseph on 15/6/22.
//

import UIKit

class SearchViewCell: UITableViewCell {
    
//    var gnome: Gnome = Gnome()
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var height: UILabel!

    @IBOutlet weak var hair: UIView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var dataTask: URLSessionDataTask?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setup(_ gnome: Gnome) {
        containerView.layer.cornerRadius = 25
        activityIndicator.startAnimating()
        downloadImage(from: gnome.thumbnail!)
        setupImageUI()
        self.name.text = gnome.name
        self.age.text = "Age: " + String(gnome.age)
        self.height.text = "Height: " + String(format: "%.0f", gnome.height)
        hair.layer.cornerRadius = hair.frame.size.width/2
        hair.layer.backgroundColor = getHairColor(with: gnome.hair_color)
    }
    
    func setupImageUI() {
        profileImage.layer.cornerRadius = 25
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderWidth = 1.5
        profileImage.layer.borderColor = UIColor.white.cgColor
    }
    
    
    func getHairColor(with string: String) -> CGColor {
        switch string {
        case "Red":
            return UIColor.red.cgColor
        case "Gray":
            return UIColor.gray.cgColor
        case "Pink":
            return UIColor.systemPink.cgColor
        case "Green":
            return UIColor.green.cgColor
        default:
            return UIColor.black.cgColor
        }
    }
    
    func downloadImage(from url: URL) {
        dataTask = URLSession.cachedTask.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.profileImage.image = UIImage(data: data)
            }
        }
        dataTask?.resume()
    }
}
