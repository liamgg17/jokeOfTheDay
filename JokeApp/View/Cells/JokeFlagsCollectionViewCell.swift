//
//  JokeFlagsCollectionViewCell.swift
//  JokeApp
//
//  Created by Christian Martinez on 11/11/22.
//

import UIKit

class JokeFlagsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblFlag: UILabel!
    
    func setData(key: String?, value:Bool?) {
     
        if let key = key {
            
            self.lblFlag.text = key
        }
        
        if let value = value, value == true {
            
            self.lblFlag.textColor = .white
            self.lblFlag.font = UIFont(name: "Montserrat-Bold", size: 16)
        }
    }
    
}
