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
    
    var dateList = [ClassDate]() {
        didSet {
            dateList = dateList.sorted()
            // The following line inserts a random element for testing whether the network fetch has occured
//            dateList.insert(dateList.randomElement()!, at: 0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        populateDateList()
        registerForNotifications()
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
        Networking.fetchScheduleData() { [self] dates in
            // Check that dateList doesn't already contain these dates. If it doesn't, add them.
            self.dateList += dates.filter() { !self.dateList.contains($0) }
            
            DispatchQueue.main.async {
                customTableView.reloadData()
            }
        }
    }
    
    func populateDateListFromNotification(_ dateList: [ClassDate]) {
        self.dateList += dateList.filter() { !self.dateList.contains($0) }
        DispatchQueue.main.async {
            self.customTableView.reloadData()
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

    func registerForNotifications() {
        print("registering for notification")
        NotificationCenter.default.addObserver(forName: .newScheduleData, object: nil, queue: nil) { (notification) in
            if let userInfo = notification.userInfo, let schedule = userInfo["schedule"] as? [ClassDate] {
                print("Updating data from notification")
                self.populateDateListFromNotification(schedule)
            }
        }
    }

}
