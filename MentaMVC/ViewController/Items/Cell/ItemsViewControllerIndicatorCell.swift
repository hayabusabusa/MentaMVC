//
//  ItemsViewControllerIndicatorCell.swift
//  MentaMVC
//
//  Created by Shunya Yamada on 2020/08/22.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

class ItemsViewControllerIndicatorCell: UITableViewCell {

    // MARK: IBOutlet
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: Properties
    
    static let reuseIdentifier: String = "ItemsViewControllerIndicatorCell"
    static let nib: UINib = UINib(nibName: "ItemsViewControllerIndicatorCell", bundle: nil)
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Configurations
    
    func configureCell() {
        activityIndicatorView.startAnimating()
    }
}
