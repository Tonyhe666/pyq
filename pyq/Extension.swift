//
//  UIColorExtension.swift
//  pyq
//
//  Created by heliang on 2020/7/15.
//  Copyright © 2020 heliang. All rights reserved.
//

import UIKit
import SDWebImage

extension UIColor {
     public class func colorWith(str : String) -> UIColor{
         var cString : String = str
         if cString.count < 6 { return UIColor.black }
         if cString.hasPrefix("0X") {
             assertionFailure("Color string cant start with 0X")
         }
         if cString.hasPrefix("#") {
             cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
         }
         if cString.count != 6 { return UIColor.gray }
         
         var range: NSRange = NSMakeRange(0, 2)
         
         let rString = (cString as NSString).substring(with: range)
         range.location = 2
         let gString = (cString as NSString).substring(with: range)
         range.location = 4
         let bString = (cString as NSString).substring(with: range)
         
         var r: UInt32 = 0x0
         var g: UInt32 = 0x0
         var b: UInt32 = 0x0
         Scanner.init(string: rString).scanHexInt32(&r)
         Scanner.init(string: gString).scanHexInt32(&g)
         Scanner.init(string: bString).scanHexInt32(&b)
         return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    public class func hexFrom(color:UIColor) -> String?{
        let cgColor = color.cgColor
        let componentsCount = cgColor.numberOfComponents
        if(componentsCount == 2){
            if let components = color.cgColor.components{
                let gray: Int = (Int)(components[0] * 255.0)
                return String(NSString(format: "#%02X%02X%02X", gray,gray,gray))
            }
        }else if(componentsCount == 4){
            if let components = color.cgColor.components{
                let red: Int = (Int)(components[0] * 255.0)
                let green: Int = (Int)(components[1] * 255.0)
                let blue: Int = (Int)(components[2] * 255.0)
                return String(NSString(format: "#%02X%02X%02X", red,green,blue))
            }
        }
        return nil
    }
}

extension UIImage { // 颜色转成图片
    class func color2Image(_ color: UIColor)-> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIImageView{
     public func loadImage(url:String,placeHolder:UIImage? = nil, completed: SDExternalCompletionBlock? = nil){
           let resource = URL(string: url)
           
           self.sd_setImage(with: resource, placeholderImage: placeHolder, completed: completed)
       }
}
extension String{
    public func rangeOf(_ of: String) -> NSRange {
        let range = self.range(of: of, options: NSString.CompareOptions())
        if(range?.lowerBound != nil && range?.upperBound != nil) {
            let lower: Int = self.distance(from: self.startIndex, to: (range?.lowerBound)!)
            return NSMakeRange(lower, of.count)
        }
        return NSRange()
    }
    public func calcMulLineStringSize(_ fontSize: CGFloat, width: CGFloat = UIScreen.main.bounds.width - 20) -> CGSize {
        // 计算多行文本的size
        let attr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        let size = (NSString(string: self)).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attr, context: nil).size
        return size
    }

    public func calcMulLineStringSize(font: UIFont, width: CGFloat = UIScreen.main.bounds.width - 20,breakMode: NSLineBreakMode? = nil) -> CGSize {
        // 计算多行文本的size
        var attr: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font]
        
        if let mode = breakMode{
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = mode
            attr[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        
        let size = (NSString(string: self)).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attr, context: nil).size
        return size
    }

    public func calcSingleLineStringSize(_ fontSize: CGFloat) -> CGSize {
        // 计算单行文本的size
        return calcSingleLineStringSize(font: UIFont.systemFont(ofSize: fontSize))
    }

    public func calcSingleLineStringSize(font: UIFont) -> CGSize {
        let attr = [NSAttributedString.Key.font: font]
        let size = NSString(string: self).size(withAttributes: attr)
        return size
    }
    public func equals(_ string: String) -> Bool {
        return self.compareNoCase(string)
    }
    // 比较子符串
      public func compareNoCase(_ string: String) -> Bool {
          return ComparisonResult.orderedSame == self.compare(string, options: NSString.CompareOptions.caseInsensitive)
      }
}

extension UITextView {
    func linkString(string:String, urls:[String] = []){
        let str = NSMutableAttributedString(string: string)
        for url in urls {
            str.addAttribute(NSAttributedString.Key.link, value: url, range:  string.rangeOf(url))
        }
        str.addAttribute(NSAttributedString.Key.font, value: self.font!, range:  NSMakeRange(0, string.count))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byCharWrapping
        str.addAttribute(NSAttributedString.Key.paragraphStyle,
                         value: paragraphStyle, range: NSMakeRange(0, string.count))
        self.attributedText = str
    }
    
    func appendLinkString(string:String, withURLString:String = "") {
        //原来的文本内容
        let attrString:NSMutableAttributedString = NSMutableAttributedString()
        attrString.append(self.attributedText)
         
        //新增的文本内容（使用默认设置的字体样式）
        let attrs = [NSAttributedString.Key.font : self.font!]
        let appendString = NSMutableAttributedString(string: string, attributes:attrs)
        //判断是否是链接文字
        if withURLString != "" {
            let range:NSRange = NSMakeRange(0, appendString.length)
            appendString.beginEditing()
            appendString.addAttribute(NSAttributedString.Key.link, value:withURLString, range:range)
            appendString.endEditing()
        }
        //合并新的文本
        attrString.append(appendString)
         
        //设置合并后的文本
        self.attributedText = attrString
    }
}

extension Int {
    /*这是一个内置函数
     lower : 内置为 0，可根据自己要获取的随机数进行修改。
     upper : 内置为 UInt32.max 的最大值，这里防止转化越界，造成的崩溃。
     返回的结果： [lower,upper) 之间的半开半闭区间的数。
     */
    public static func randomIntNumber(lower: Int = 0,upper: Int = Int(UInt32.max)) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower)))
    }
    /**
     生成某个区间的随机数
     */
    public static func randomIntNumber(range: Range<Int>) -> Int {
        return randomIntNumber(lower: range.lowerBound, upper: range.upperBound)
    }
}

