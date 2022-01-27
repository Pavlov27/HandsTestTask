//
//  SchrodingerCell.swift
//  HandsTestTask
//
//  Created by Nikita Pavlov on 27.01.2022.
//

import Foundation
import UIKit

enum SchrodingerCellType {
    case dead
    case alive
    case life
}

class SchrodingerCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var labelsStackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        containerView.layer.cornerRadius = 8
        labelsStackView.distribution = .fillProportionally
        labelsStackView.spacing = 2
        nameLabel.font.withSize(20)
        descriptionLabel.font.withSize(14)
    }
    
    override func prepareForReuse() {
        cellImageView.image = nil
        nameLabel.text = ""
        descriptionLabel.text = ""
    }
    
    func configure(model: SchrodingerCellModel) {
        switch model.type {
        case .dead:
            cellImageView.image = UIImage(named: "deadIcon")
            nameLabel.text = "Мертвая"
            descriptionLabel.text = "или прикидывается"
        case .alive:
            cellImageView.image = UIImage(named: "aliveIcon")
            nameLabel.text = "Живая"
            descriptionLabel.text = "и шевелится!"
        case .life:
            cellImageView.image = UIImage(named: "lifeIcon")
            nameLabel.text = "Жизнь"
            descriptionLabel.text = "Ку-ку!"
        }
    }
    
    func shake() {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        shakeAnimation.duration = 0.05
        shakeAnimation.repeatCount = 2
        shakeAnimation.autoreverses = true
        let startAngle: Float = (-2) * 3.14159/180
        let stopAngle = -startAngle
        shakeAnimation.fromValue = NSNumber(value: startAngle as Float)
        shakeAnimation.toValue = NSNumber(value: 3 * stopAngle as Float)
        shakeAnimation.autoreverses = true
        shakeAnimation.duration = 0.15
        shakeAnimation.repeatCount = 10000
        shakeAnimation.timeOffset = 290 * drand48()

        let layer: CALayer = self.layer
        layer.add(shakeAnimation, forKey:"shaking")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.stopShaking()
        })
    }

    private func stopShaking() {
        let layer: CALayer = self.layer
        layer.removeAnimation(forKey: "shaking")
    }
}
