//
//  TableView.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/27/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class TableView: UITableView {
    private var reloadDataCompletionBlock: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        reloadDataCompletionBlock?()
        reloadDataCompletionBlock = nil
    }
    
    func reloadDataWithCompletion(completion: @escaping () -> Void) {
        reloadDataCompletionBlock = completion
        self.reloadData()
    }
}
