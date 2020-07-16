//
//  PyqCell.swift
//  pyq
//
//  Created by heliang on 2020/7/15.
//  Copyright © 2020 heliang. All rights reserved.
//

import UIKit
import  SnapKit

class PyqCell : UITableViewCell {
    
    private var name:UILabel!
    private var head:UIImageView!
    private var timeLabel: UILabel!
    var textview: UITextView!
    private var preImg: ImgView?
    private var imageUrl :[String]?{
        didSet{
            if let img = imageUrl{
              
                var imageheight = 0
                if img.count == 0 {
                    preImg?.removeFromSuperview()
                    return
                }
                 if img.count == 1 {
                     imageheight = 150
                 }else if img.count <= 3 {
                     imageheight = 90
                 }else if img.count <= 6 {
                     imageheight = 90*2
                 }else if img.count <= 9 {
                     imageheight = 90*3
                 }
                preImg?.removeFromSuperview()
                preImg = ImgView()
                preImg?.backgroundColor = .white
                self.contentView.addSubview(preImg!)
                preImg?.imgsPrepare(imgs: img)
                 preImg?.snp.makeConstraints { (maker) in
                    if textview.attributedText.isEqual(""){
                         maker.top.equalTo(50)
                     }
                     maker.leading.equalTo(80)
                     maker.trailing.equalTo(-20)
                    maker.top.equalTo(textview.snp.bottom).offset(15)
                     maker.height.equalTo(imageheight)
                     //maker.bottom.equalTo(self.contentView.snp.bottom).offset(-40).priority(260)
                 }
                
                
                
                timeLabel.snp.makeConstraints { (maker) in
                    maker.leading.equalTo(83)
                    maker.width.equalTo(50)
                    maker.top.equalTo(textview.snp.bottom).offset(20+imageheight)
                    maker.height.equalTo(25).priority(240)
                    maker.bottom.equalTo(self.contentView.snp.bottom).offset(-15).priority(270)
                }

                
            }
        }
    }
    
    var model :PyqModel?{
        didSet{
            if let data = model {
                name.text = data.name
                head.loadImage(url: data.head)
                timeLabel.text = data.time
                let string = data.content
                 let urls = getUrls(str: string)
                 
                 textview.linkString(string: data.content, urls: urls)
                 let stringSize = data.content.calcMulLineStringSize(font : UIFont.systemFont(ofSize: 15) , width : CGFloat(Int(UIScreen.main.bounds.width) - (20-50)))
                
                 textview.snp.makeConstraints { (maker) in
                     maker.leading.equalTo(75)
                     maker.trailing.equalTo(-20)
                     maker.top.equalTo(50)
                     maker.height.equalTo(stringSize.height)
                     maker.bottom.equalTo(self.contentView.snp.bottom).offset(-20).priority(250)
                 }
                if imageUrl == nil {
                    imageUrl = data.imgs
                }
            }
        }
    }
    
    /**
         匹配字符串中所有的URL
         */
     private func getUrls(str:String) -> [String] {
         var urls = [String]()
         // 创建一个正则表达式对象
         do {
             let dataDetector = try NSDataDetector(types:
                NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue))
             // 匹配字符串，返回结果集
            let res = dataDetector.matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0),
                 range: NSMakeRange(0, str.count))
             // 取出结果
             for checkingRes in res {
                urls.append((str as NSString).substring(with: checkingRes.range))
             }
         }
         catch {
             print(error)
         }
         return urls
     }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        head = UIImageView()
        head.layer.cornerRadius = 4
        head.layer.masksToBounds = true
        head.backgroundColor = UIColor.red
        //head.loadImage(url: "http://ww4.sinaimg.cn/crop.0.0.640.640.1024/62b4e495jw8eov1yagwioj20hs0hsdix.jpg")
        self.contentView.addSubview(head)
        head.snp.makeConstraints { (maker) in
            maker.leading.equalTo(15)
            maker.top.equalTo(20)
            maker.width.height.equalTo(50)
            //maker.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
        }
        
        name = UILabel()
        name.font = UIFont.systemFont(ofSize: 18)
        name.textColor = UIColor.colorWith(str: "#5a6b90")
        //name.text = "贺亮"
        self.contentView.addSubview(name)
        name.snp.makeConstraints { (maker) in
            maker.leading.equalTo(80)
            maker.top.equalTo(20)
            maker.height.equalTo(25)
            maker.trailing.equalTo(20)
        }

        textview = UITextView()
        textview.textContainerInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0,right: 0)
        //textview.backgroundColor = UIColor.red
        textview.font = UIFont.systemFont(ofSize: 15)
        textview.isSelectable = true
        textview.isEditable = false
        textview.textAlignment = .left
        self.contentView.addSubview(textview)
        
        let line = UIView()
        self.contentView.addSubview(line)
        line.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        line.snp.makeConstraints { (maker) in
            maker.bottom.trailing.leading.equalToSuperview()
            maker.height.equalTo(1)
        }
        
//        preImg = ImgView()
//        preImg.backgroundColor = .white
//        self.contentView.addSubview(preImg)
        
       
        // 时间
        timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.gray
        //timeLabel.text = "2小时前"
        self.contentView.addSubview(timeLabel)
        
    }

}
