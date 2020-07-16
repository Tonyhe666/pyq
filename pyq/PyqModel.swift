//
//  PyqModel.swift
//  pyq
//
//  Created by heliang on 2020/7/15.
//  Copyright © 2020 heliang. All rights reserved.
//


class PyqModel{
    var name:String = ""
    var head:String = ""
    var time:String = ""
    var imgs: [String] = []
    var content : String = ""
    init() {
        
    }
    
    init(name:String, head:String, time:String ,imgs:[String], content:String) {
        self.name = name
        self.head = head
        self.time = time
        self.imgs = imgs
        self.content = content
    }
    
    private static let s_imgs = [
        "http://cdn.aixifan.com/dotnet/artemis/u/cms/www/201509/082202103hgrxnxe.jpg",
        "http://ww4.sinaimg.cn/crop.0.0.640.640.1024/62b4e495jw8eov1yagwioj20hs0hsdix.jpg",
        "http://ww1.sinaimg.cn/crop.0.0.179.179.1024/9ccc7942gw1enacnterhdj2050050jrk.jpg",
        "http://ww1.sinaimg.cn/crop.0.0.511.511.1024/64dfd849gw1ep43ip52qlj20e80e840a.jpg",
        "http://ww4.sinaimg.cn/crop.1.93.592.592.1024/bec21fccgw1eb7twn8lbzj20gl0m8grl.jpg",
        "http://ww4.sinaimg.cn/crop.0.0.480.480.1024/ebebae87jw8edqmlxzypxj20dc0dcmxr.jpg",
        "http://ww2.sinaimg.cn/crop.0.0.511.511.1024/631bcd1ajw8evts0mwbpej20e70e8aam.jpg",
        "http://ww1.sinaimg.cn/crop.0.0.720.720.1024/48e3f28djw8eix7rrtdlxj20k00k00tr.jpg",
        "http://ww1.sinaimg.cn/crop.0.0.179.179.1024/9ccc7942gw1enacnterhdj2050050jrk.jpg",
        "http://ww4.sinaimg.cn/crop.0.0.640.640.1024/62b4e495jw8eov1yagwioj20hs0hsdix.jpg"
    ]
    
    private class func getImage() -> [String]{
        var img: [String] = []
        let NwIntNumber = Int.randomIntNumber(lower: 0, upper: s_imgs.count)
        for i in 0..<NwIntNumber {
            img.append(s_imgs[i])
        }
        return img
    }
    
    private class func getHeader() -> String{
        let NwIntNumber = Int.randomIntNumber(lower: 0, upper: s_imgs.count)
        return s_imgs[NwIntNumber]
    }
    
    class func getTestData() -> [PyqModel]{
        var model : [PyqModel] = []
        for i in 0..<100 {
            let data = PyqModel(name: "张三"+String(i), head: getHeader(), time: "2小时前", imgs:getImage(), content: "我是一个url测试 打开百度 http://www.baidu.com 然后打开http://hao123.com")
             model.append(data)
        }
        return model
    }
    
    
}
