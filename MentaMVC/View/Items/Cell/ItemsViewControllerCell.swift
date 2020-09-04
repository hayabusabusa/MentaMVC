//
//  ItemsViewControllerCell.swift
//  MentaMVC
//
//  Created by Shunya Yamada on 2020/08/22.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit
import Kingfisher

class ItemsViewControllerCell: UITableViewCell {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var tagsLabel: UILabel!
    @IBOutlet private weak var likesCountLabel: UILabel!
    @IBOutlet private weak var commentsCountLabel: UILabel!
    
    // MARK: Properties
    
    static let reuseIdentifier: String = "ItemsViewControllerCell"
    static let estimatedRowHeight: CGFloat = 143
    static let nib: UINib = UINib(nibName: "ItemsViewControllerCell", bundle: nil)
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Configurations
    
    func configureCell(profileImageURL: String?, title: String?, body: String?, tags: String?, likesCount: Int, commentsCount: Int) {
        titleLabel.text = title
        bodyLabel.text = body
        tagsLabel.text = tags
        tagsLabel.superview?.isHidden = tags == nil
        likesCountLabel.text = "\(likesCount)"
        commentsCountLabel.text = "\(commentsCount)"
        
        if let url = URL(string: profileImageURL ?? "") {
            profileImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.3))])
        }
    }
}
