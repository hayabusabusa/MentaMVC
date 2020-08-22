//
//  ItemsViewControllerCell.swift
//  MentaMVC
//
//  Created by Shunya Yamada on 2020/08/22.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

class ItemsViewControllerCell: UITableViewCell {
    
    // MARK: IBOutlet
    
    // MARK: Properties
    
    static let reuseIdentifier: String = "ItemsViewControllerCell"
    static let estimatedRowHeight: CGFloat = 164
    static let nib: UINib = UINib(nibName: "ItemsViewControllerCell", bundle: nil)
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Configurations
    
    func configureCell() {
        
    }
}
