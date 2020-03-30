//
//  ViewController.swift
//  SampleApp
//
//  Created by Stanislas Chevallier on 30/03/2020.
//  Copyright © 2020 Syan.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()

        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = nil
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(self.refreshControlTick), for: .valueChanged)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()
    }

    // MARK: Properties
    private var data: [String] = []
    
    // MARK: Views
    @IBOutlet private var tableView: UITableView!
    
    // MARK: Content
    private func updateData() {
        data = DataGenerator.generateData(count: 50)
        tableView.reloadData()
    }
    
    // MARK: Actions
    @objc private func refreshControlTick() {
        // on iOS 12 the refreshControl disappears at this point, don't know how to fix it, except disable large titles
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.stopLoading()
        }
    }
    
    @objc private func stopLoading() {
        // needs to be called BEFORE ending refresh
        updateData()

        if #available(iOS 13.0, *) {
            // DispatchQueue.main.async can sometimes help
            tableView.refreshControl?.endRefreshing()
        }
        else if #available(iOS 12.0, *) {
            tableView.refreshControl?.endRefreshing()
            // fix large title nav bar stuck, for iOS 12, but results in un-animated jump
            // https://stackoverflow.com/a/48176010/1439489
            // it also screws up navBar when it is translucent
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.isTranslucent = false
        }
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "Line \(indexPath.row + 1): \(data[indexPath.row])"
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // if estimated height is too big it will cause UINavigationBar positionning issues (at least on iOS 13)
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

