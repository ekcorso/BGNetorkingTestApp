//
//  MainViewController.swift
//  BGNetworkingTestApp
//
//  Created by Emily Corso on 1/17/22.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let customTableView: UITableView = {
        let customTableView = UITableView()
        customTableView.backgroundColor = .systemBackground
        customTableView.translatesAutoresizingMaskIntoConstraints = false
        return customTableView
    }()
    
    let words = ["Yum", "Wow", "Yikes", "Yippe", "Whoa"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        customTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        customTableView.delegate = self
        customTableView.dataSource = self
        
        view.addSubview(customTableView)
        
        NSLayoutConstraint.activate([
            customTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            customTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            customTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let word = words[indexPath.row]
        cell.textLabel?.text = word
        return cell
    }


}
