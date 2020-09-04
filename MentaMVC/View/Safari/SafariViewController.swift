//
//  SafariViewController.swift
//  MentaMVC
//
//  Created by Shunya Yamada on 2020/08/22.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit
import SafariServices

final class SafariViewController: SFSafariViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Configurations

extension SafariViewController {
    
    private func configure() {
        preferredControlTintColor = UIColor(red: 36 / 255, green: 186 / 255, blue: 197 / 255, alpha: 1)
    }
}
