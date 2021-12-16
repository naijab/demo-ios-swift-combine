//
//  PostItemTableViewCell.swift
//  DemoCombine
//
//  Created by Nattapon Pondongnok on 16/12/2564 BE.
//

import UIKit

class PostItemTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var usernameLabel: UILabel?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var bodyLabel: UILabel?
    
    static let identifier = String(describing: self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(post: PostModel) {
        titleLabel?.text = post.title ?? ""
        bodyLabel?.text = post.body ?? ""
        usernameLabel?.text = post.user?.username ?? ""
    }

}
