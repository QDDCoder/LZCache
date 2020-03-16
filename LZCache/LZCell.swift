//
//  LZCell.swift
//  LZCache
//
//  Created by 湛亚磊 on 2020/3/14.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit

class LZCell: UITableViewCell {

    var model:GoodModel = GoodModel(){
        didSet{
            infoLabel.text = model.name
        }
    }
    
    lazy var infoLabel: UILabel = {
        let infoLabel = UILabel(frame: self.bounds)
        infoLabel.textAlignment = .center
        return infoLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(infoLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: true)
    }

}
