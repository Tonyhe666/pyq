//
//  ViewController.swift
//  pyq
//
//  Created by heliang on 2020/7/15.
//  Copyright © 2020 heliang. All rights reserved.
//

import UIKit
import SnapKit

class PyqVC: UIViewController {
    let STATUS_BAR_HEIGHT = UIApplication.shared.statusBarFrame.height
    let NAVIGATION_BAR_HEIGHT : CGFloat = 44
    private var cusNavigator : UIView?
    private var lastContentOffsetY : CGFloat = 0
    private var model:[PyqModel] = []
    private var tableView : UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            
            // 修改tableview分割线的颜色， sb 中需要清除默认分割线颜色
            tableView.separatorStyle = .singleLine
            tableView.separatorColor = UIColor.colorWith(str: "#eeeeee")
            
            tableView.showsVerticalScrollIndicator = false
            tableView.estimatedRowHeight = 600
            tableView.rowHeight = UITableView.automaticDimension
            
            tableView.register(HeadViewCell.self, forCellReuseIdentifier: "HeadViewCell")
            tableView.register(PyqCell.self, forCellReuseIdentifier: "PyqCell")
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.separatorInset = UIEdgeInsets.zero
            tableView.layoutMargins = UIEdgeInsets.zero
            tableView.separatorStyle = .none;
        }
    }
    
    func createUI(){

        tableView = UITableView(frame: CGRect(), style: .grouped)
        tableView.backgroundColor = UIColor.black
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }

        cusNavigator = UIView()
        cusNavigator!.isUserInteractionEnabled = true
        cusNavigator!.backgroundColor = UIColor.white
        cusNavigator!.alpha = 0
        self.view.addSubview(cusNavigator!)
        cusNavigator!.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.equalToSuperview()
            maker.height.equalTo(STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)
        }
        let label = UILabel()
        label.text = "朋友圈"
        label.textColor = UIColor.colorWith(str: "#3b4257")
        label.font = UIFont.systemFont(ofSize: 15)
        cusNavigator!.addSubview(label)
        label.snp.makeConstraints { (maker) in
             maker.centerX.equalToSuperview()
             maker.centerY.equalToSuperview().offset(STATUS_BAR_HEIGHT / 2)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        model = PyqModel.getTestData()
        createUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func updateStatusBarStyle(style:UIStatusBarStyle? = nil){
        if let style = style{
            UIApplication.shared.statusBarStyle = style
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
}


extension PyqVC : UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(cusNavigator == nil){
             return
         }
         if(!scrollView.isDragging && abs(lastContentOffsetY - scrollView.contentOffset.y) > 150){
             return
         }
         
         lastContentOffsetY = scrollView.contentOffset.y
         
         var alpha = (scrollView.contentOffset.y-110) / 150
         if(alpha < 0){
             alpha = 0
             updateStatusBarStyle(style: UIStatusBarStyle.lightContent)
         }else if(alpha > 1){
             alpha = 1
             self.updateStatusBarStyle(style: UIStatusBarStyle.default)
         }
         cusNavigator?.alpha = alpha
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 320
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
}

extension PyqVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeadViewCell") as! HeadViewCell
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PyqCell") as! PyqCell
            cell.model = model[indexPath.row]
            cell.textview.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 1
        }
        return model.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
}

extension PyqVC: UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL,in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if let scheme = URL.scheme {
            switch scheme {
            case "about:" :
                showAlert(tagType: "about",
                          payload: (URL as NSURL).resourceSpecifier!.removingPercentEncoding!)
            case "feedback" :
                showAlert(tagType: "feedback",
                          payload: (URL as NSURL).resourceSpecifier!.removingPercentEncoding!)
            default:
                print("这个是普通的url")
            }
        }
         
        return true
    }
     
    //显示消息
    func showAlert(tagType:String, payload:String){
        let alertController = UIAlertController(title: "检测到\(tagType)标签",
            message: payload, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

