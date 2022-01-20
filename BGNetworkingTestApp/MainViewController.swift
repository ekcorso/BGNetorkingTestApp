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
    
    var dateList = [ClassDate]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        populateDateList()
        
        // populate dateList
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
    
    func populateDateList() {
        let fetcher = Networking()
        fetcher.fetchScheduleData() { [self] dates in
            // Check that dateList doesn't already contain these dates. If it doesn't, add them.
            self.dateList += dates.filter() { !self.dateList.contains($0) }
            
            DispatchQueue.main.async {
                customTableView.reloadData()
            }
        }
    }
    
    // MARK: - Table View Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dateList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateList[section].exactDate!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateList[section].classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let mbaClass = dateList[indexPath.section].classes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = mbaClass.name
        cell.contentConfiguration = content
        
        return cell
    }


}
