//
//  ImagesListCell.swift
//  ImageGram
//
//  Created by Георгий Матросов on 11.07.2023.
//


import UIKit

final class ImagesListCell: UITableViewCell {
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    static let reuseIdentifier = "ImageListCell"
}
