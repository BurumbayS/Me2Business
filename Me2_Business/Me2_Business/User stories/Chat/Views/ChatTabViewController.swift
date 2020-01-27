//
//  ChatTabViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/5/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class ChatTabViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let newChatButton = CustomLargeTitleBarButton()
    
    let viewModel = ChatTabViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadChatsList()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showNewChatButton(true)
//
//        if viewModel.roomUUIDToOpenFirst.value != "" { openChatOnPush() }
        
        navigationController?.navigationBar.isTranslucent = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showNewChatButton(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureTableView()
        loadChatsList()
    }
    
    private func loadChatsList() {
        viewModel.getChatList { [weak self] (status, message) in
            self?.tableView.reloadData()
        }
    }
    
    private func configureNavBar() {
        extendedLayoutIncludesOpaqueBars = true
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.title = "Чаты"
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.searchBar.placeholder = "Поиск"
        search.searchBar.setValue("Отменить", forKey: "cancelButtonText")
        navigationItem.searchController = search

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

        newChatButton.add(to: navigationController!.navigationBar, with: UIImage(named: "new_chat_icon")!) { [weak self] in
//            self?.createNewChat()
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        
        tableView.registerNib(ChatTableViewCell.self)
    }
    
    private func goToChat(room: Room) {
        switch room.type {
        case .SIMPLE, .SERVICE:
            
            let vc = Storyboard.chatViewController() as! ChatViewController
            vc.viewModel = ChatViewModel(room: room)
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
    
    private func showNewChatButton(_ show: Bool) {
       UIView.animate(withDuration: 0.2) {
           self.newChatButton.alpha = show ? 1.0 : 0.0
       }
    }
}

extension ChatTabViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.searchActivated = false
        tableView.reloadSections([0], with: .automatic)
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }

        if text != "" {
            viewModel.searchActivated = true
            viewModel.searchChat(with: text) { [weak self] in
                self?.tableView.reloadSections([0], with: .automatic)
            }
        }
    }
}

extension ChatTabViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001//CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001//CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.searchActivated {
            return viewModel.searchResults.count
        }

        return viewModel.chatsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let room = (viewModel.searchActivated) ? viewModel.searchResults[indexPath.row] : viewModel.chatsList[indexPath.row]
        cell.configure(with: room)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//            self.addActionSheet(titles: ["Очистить чат", "Удалить чат"], actions: [clearChat, deleteChat], styles: [.default, .destructive])
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let room = viewModel.chatsList[indexPath.row]

        goToChat(room: room)

        tableView.deselectRow(at: indexPath, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        newChatButton.moveAndResizeImage(for: height)
    }
}
