//
//  ImagesListCell.swift
//  ImageGram
//
//  Created by Георгий Матросов on 11.07.2023.
//


import UIKit

final class ImagesListCell: UITableViewCell {
    @IBOutlet var buttonCell: UIButton!
    @IBOutlet var imageCell: UIImageView!
    @IBOutlet var dateLabelCell: UILabel!
    static let reuseIdentifier = "ImageListCell"
}
