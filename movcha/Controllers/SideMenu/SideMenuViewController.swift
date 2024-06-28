//
//  SideMenuViewController.swift
//  movcha
//
//  Created by junehee on 6/29/24.
//

import UIKit

class SideMenuViewController: BaseViewController {
    
    let menuView = SideMenuView()
    let menuTitles = Constants.Text.Home.sideMenuTitle
    let menuIcons = Constants.Text.Home.sideMenuIcon
    
    override func loadView() {
        self.view = menuView
    }
    
    override func configureHierarchy() {
        menuView.menuTableView.delegate = self
        menuView.menuTableView.dataSource = self
        menuView.menuTableView.register(SideMenuTableViewCell.self, forCellReuseIdentifier: SideMenuTableViewCell.id)
    }
    
}


extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.id, for: indexPath) as? SideMenuTableViewCell else { return SideMenuTableViewCell() }

        let icon = menuIcons[indexPath.row]
        let title = menuTitles[indexPath.row]
        
        cell.selectionStyle = .none
        cell.configureCellData(icon: icon, title: title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(SignUpViewController(), animated: false)
    }
}
