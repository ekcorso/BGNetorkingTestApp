//
//  MainViewController.swift
//  BGNetworkingTestApp
//
//  Created by Emily Corso on 1/17/22.
//

import UIKit

class MainViewController: UIViewController {
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue

        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
