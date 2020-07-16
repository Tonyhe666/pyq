//
//  HeadViewCell.swift
//  pyq
//
//  Created by heliang on 2020/7/15.
//  Copyright © 2020 heliang. All rights reserved.
//
import UIKit
import SnapKit
import SDWebImage

class HeadViewCell : UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        let bg = UIImageView(image: UIImage.color2Image(UIColor.green))
        self.contentView.addSubview(bg)
        bg.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-70)
        }
        bg.loadImage(url: "http://cdn.aixifan.com/dotnet/artemis/u/cms/www/201509/082202103hgrxnxe.jpg")
        
        //头像
        let ivHead = UIImageView()
        ivHead.layer.cornerRadius = 4
        ivHead.layer.masksToBounds = true
        ivHead.backgroundColor = UIColor.red
        bg.addSubview(ivHead)
        ivHead.loadImage(url: "http://ww4.sinaimg.cn/crop.0.0.640.640.1024/62b4e495jw8eov1yagwioj20hs0hsdix.jpg")
        ivHead.snp.makeConstraints({ (maker) in
            maker.width.height.equalTo(60)
            maker.trailing.equalTo(-20)
            maker.bottom.equalTo(self.contentView.snp.bottom).offset(-50)
        })
        
        // name
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 18)
        name.textAlignment = .right
        name.textColor = UIColor.white
        name.text = "贺亮"
        bg.addSubview(name)
        name.snp.makeConstraints { (maker) in
            maker.leading.equalTo(20)
            maker.top.equalTo(ivHead.snp.top).offset(10)
            maker.trailing.equalTo(ivHead.snp.leading).offset(-20)
            maker.height.equalTo(30)
        }
        // 个性签名
        let quotes = UILabel()
        quotes.font = UIFont.systemFont(ofSize: 15)
        quotes.textAlignment = .right
        quotes.textColor = UIColor.black
        quotes.text = "我是一个个性签名😂"
        self.contentView.addSubview(quotes)
        quotes.snp.makeConstraints { (maker) in
            maker.leading.equalTo(20)
            maker.top.equalTo(ivHead.snp.bottom).offset(20)
            maker.trailing.equalTo(-20)
            maker.height.equalTo(20).priority(250)
            
            maker.bottom.equalTo(self.contentView.snp.bottom).offset(-20).priority(750)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
