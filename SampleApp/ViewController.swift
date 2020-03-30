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
        // fixes navigationBar not contracting after endResfresh is called on iOS 12 & opaque navBar. better
        // than toggling `navigationController?.navigationBar.isTranslucent` off then on.
        // also makes the refreshControl visible during loading, and doesn't impact translucent navBars
        extendedLayoutIncludesOpaqueBars = true

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
        else {
            tableView.refreshControl?.endRefreshing()
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

