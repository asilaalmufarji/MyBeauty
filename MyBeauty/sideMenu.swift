//
//  sideMenu.swift
//  MyBeauty
//
//  Created by OJP11 on 11/21/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import Foundation
import UIKit
protocol MenuControllerDelegate {
    func  didSelectMenuItem(named: sideMenuItem)
}
enum sideMenuItem : String , CaseIterable {
    case home = "Home"
    case profile = "Profile"
}
class MenuController: UITableViewController {
    
    public var deleget: MenuControllerDelegate?
    
    private let menuItems:[sideMenuItem]
    
    init(with menuItems:[sideMenuItem]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row].rawValue
        cell.textLabel?.textColor = .purple
        
        
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = menuItems[indexPath.row]
        deleget?.didSelectMenuItem(named: selectedItem)
        
    }
}
