//
//  ViewController.swift
//  ImageGram
//
//  Created by Георгий Матросов on 01.07.2023.
//

import UIKit

class ImagesListViewController: UIViewController, UITableViewDataSource{

    
    @IBOutlet private var tableView: UITableView!
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    private let photosName: [String] = Array(0..<20).map{"\($0)"}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    
    private func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        guard let image = UIImage(named: "\(photosName[indexPath.row])") else {
            return
        }
        cell.cellImage.image = image
        cell.dateLabel.text = dateFormatter.string(from: Date())
        
        let likeButtonImage = indexPath.row % 2 == 0 ? UIImage(named: "Button_off") : UIImage(named: "Button_on")
        cell.likeButton.setImage(likeButtonImage, for: .normal)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
}

extension ImagesListViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: "\(photosName[indexPath.row])") else {
            return 0
        }
        let imageViewWidth = tableView.bounds.size.width - 32
        let imageWidth = image.size.width
        let scale = imageViewWidth/imageWidth
        let imageHeight = image.size.height
        let imageViewHeight = imageHeight * scale + 8
        return imageViewHeight
    }
}
