//
//  HeaderView.swift
//  HandsTestTask
//
//  Created by Nikita Pavlov on 27.01.2022.
//

import UIKit

class HeaderView: UIView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        //Обычно использую SnapKit, но для этого решил не подтягивать лишнюю зависимость в проект
        label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: -8).isActive = true
        label.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        label.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
    }
    
    func setLabelTitle(_ value: String) {
        label.text = value
    }
}
