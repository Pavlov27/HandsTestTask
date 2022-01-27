//
//  ViewController.swift
//  HandsTestTask
//
//  Created by Nikita Pavlov on 27.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private let builder = CellBuilder()
    private var cellModels = [SchrodingerCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "593371")
        setupTableView()
        setupCreateButton()
        setTableViewBackgroundGradient()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "SchrodingerCell", bundle: nil), forCellReuseIdentifier: "SchrodingerCell")
        tableView.separatorStyle = .none
        tableView.contentInset.bottom = 100
    }
    
    private func setupCreateButton() {
        createButton.layer.cornerRadius = 4
        createButton.backgroundColor = UIColor(hex: "5A3472")
        createButton.titleLabel?.text = "СОТВОРИТЬ"
        createButton.titleLabel?.textColor = .white
    }
    
    private func setTableViewBackgroundGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: "2E004D").cgColor, UIColor(hex: "000000").cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = tableView.bounds
        let backgroundView = UIView(frame: tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        tableView.backgroundView = backgroundView
    }
    
    private func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.cellModels.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    @IBAction func createButtonDidTapped(_ sender: Any) {
        cellModels = builder.buildCellModels(cellModels)
        tableView.reloadData()
        scrollToBottom()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cellModels[indexPath.row].type == .alive {
            guard let cell = tableView.cellForRow(at: indexPath) as? SchrodingerCell else { return }
            cell.shake()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        header.setLabelTitle("Клеточное наполенение")
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchrodingerCell", for: indexPath) as! SchrodingerCell
        cell.configure(model: model)
        
        return cell
    }
}
