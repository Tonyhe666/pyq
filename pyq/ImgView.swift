//
//  imgView.swift
//  pyq
//
//  Created by heliang on 2020/7/15.
//  Copyright © 2020 heliang. All rights reserved.
//

import UIKit

class ImgView: UIView {

   func imgsPrepare(imgs: [String]){
        for i in 0 ..< imgs.count{
            let imgV = UIImageView()
            imgV.backgroundColor = UIColor.colorWith(str: "#eeeeee")
            imgV.contentMode = .scaleToFill
            imgV.clipsToBounds = true
            imgV.tag = i
            imgV.loadImage(url: imgs[i])
            self.addSubview(imgV)
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        let totalRow = 3
        
        let totalWidth = self.bounds.size.width
        let margin: CGFloat = 5
        let itemWH = (totalWidth - margin * CGFloat(totalRow + 1)) / CGFloat(totalRow)
       
        var i=0
        for view in self.subviews{

            let row = i / totalRow
            let col = i % totalRow
            
            let x = (CGFloat(col) + 1) * margin + CGFloat(col) * itemWH
            let y = (CGFloat(row) + 1) * margin + CGFloat(row) * itemWH
            let frame = CGRect(x: x, y: y, width: itemWH, height: itemWH)
            if self.subviews.count == 1 {
                view.frame = CGRect(x: 0, y: 0, width: 200, height: 150)
            }else{
                view.frame = frame
            }
            i += 1
        }
    }
    
}
