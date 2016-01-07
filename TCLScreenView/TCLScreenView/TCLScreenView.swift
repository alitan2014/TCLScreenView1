//
//  TCLScreenView.swift
//  TwoToTwo
//
//  Created by TCL on 15/12/28.
//  Copyright © 2015年 twototwo. All rights reserved.
//

import UIKit
let TCL_IPHONE_WIDTH = UIScreen.mainScreen().bounds.width
let TCL_IPHONE_HEIGHT = UIScreen.mainScreen().bounds.height
let window = UIApplication.sharedApplication().delegate?.window
typealias buttonClickComplete=(UIButton)-> Void
typealias tableViewSelectedeBlock=(AnyObject,NSInteger) ->Void
typealias selectedRightTabelViewBlock=(AnyObject,NSInteger)->Void
class TCLScreenView: UIView,UITableViewDelegate,UITableViewDataSource {
    var clickComplete:buttonClickComplete!
    var tableViewSelectedeComplete:tableViewSelectedeBlock!
    var rightTableViewSelectedComplete:selectedRightTabelViewBlock!
    var leftTableView:UITableView!
    var rightTableView:UITableView!
    var wholeTableView:UITableView!
    var leftArray:NSArray!
    var rightArray:NSArray!
    var wholeArray:NSArray!
    var oldButton:UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    func initUI(){
        self.leftArray = NSArray()
        self.rightArray = NSArray()
        self.wholeArray = NSArray()
        
        let imgView = UIImageView(frame: CGRectMake(0, CGRectGetHeight(self.frame)-5, TCL_IPHONE_WIDTH, 5))
        imgView.image = UIImage(named: "line_gray")
        self.addSubview(imgView)
        
        
    }
    /**
     创建TableView
     */
    func initTableView(){
        
        let frame = self.convertRect(self.bounds, toView: window!)
        self.leftTableView = UITableView(frame: CGRectMake(0, CGRectGetMaxY(frame), TCL_IPHONE_WIDTH/2, TCL_IPHONE_HEIGHT-CGRectGetMaxY(frame)), style: UITableViewStyle.Plain)
        self.leftTableView.delegate = self
        self.leftTableView.tag = 1
        self.leftTableView.dataSource = self
        self.leftTableView.backgroundColor = UIColor.whiteColor()
        
        self.rightTableView = UITableView(frame: CGRectMake(TCL_IPHONE_WIDTH/2, CGRectGetMaxY(frame), TCL_IPHONE_WIDTH/2, TCL_IPHONE_HEIGHT-CGRectGetMaxY(frame)), style: UITableViewStyle.Plain)
        self.rightTableView.tag = 2
        self.rightTableView.delegate = self
        self.rightTableView.dataSource = self
        
        self.wholeTableView = UITableView(frame: CGRectMake(0, CGRectGetMaxY(frame), TCL_IPHONE_WIDTH, TCL_IPHONE_HEIGHT-CGRectGetMaxY(frame)), style: UITableViewStyle.Plain)
        self.wholeTableView.delegate = self
        self.wholeTableView.tag = 3
        self.wholeTableView.dataSource = self
    }
    /**
     改变tableView的Frame
     */
    func changeTableViewFrame(){
        let frame = self.convertRect(self.bounds, toView: window!)
        self.leftTableView.frame = CGRectMake(0, CGRectGetMaxY(frame), TCL_IPHONE_WIDTH/2, TCL_IPHONE_HEIGHT-CGRectGetMaxY(frame))
        self.rightTableView.frame = CGRectMake(TCL_IPHONE_WIDTH/2, CGRectGetMaxY(frame), TCL_IPHONE_WIDTH/2, TCL_IPHONE_HEIGHT-CGRectGetMaxY(frame))
        self.wholeTableView.frame = CGRectMake(0, CGRectGetMaxY(frame), TCL_IPHONE_WIDTH, TCL_IPHONE_HEIGHT-CGRectGetMaxY(frame))
    }
    /**
     根据外部传入数组创建按钮
     
     - parameter titleArray:             外部传入数组
     - parameter btnClickComplete:       点击按钮触发事件
     - parameter leftTableViewSelected:  点击左边tableView row 触发事件
     - parameter rightTableViewSelected: 点击右边tableView row 触发事件
     
     - returns:
     */
    func initButtonWithArray(titleArray:NSArray,btnClickComplete:buttonClickComplete,leftTableViewSelected:tableViewSelectedeBlock,rightTableViewSelected:selectedRightTabelViewBlock){
        self.clickComplete = btnClickComplete
        self.tableViewSelectedeComplete = leftTableViewSelected
        self.rightTableViewSelectedComplete = rightTableViewSelected
        let count:CGFloat = CGFloat(titleArray.count)
        for var i=0; i<titleArray.count; i++ {
            let button = TCLYButton(frame: CGRectMake(TCL_IPHONE_WIDTH/4*CGFloat(i),0,TCL_IPHONE_WIDTH/count,45))
            button.tag = i+1;
            button.addTarget(self, action: "btnClick:", forControlEvents: UIControlEvents.TouchUpInside)
            button.setLabelTitle(titleArray.objectAtIndex(i) as! String)
            self.addSubview(button)
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.leftTableView{
            if self.leftArray.count != 0 {
                if self.oldButton.tag == 3 {
                    return self.leftArray.count
                }
                return self.leftArray.count
            }else{
                return 0
            }
            
        }else if tableView == self.rightTableView{
            if self.rightArray.count != 0 {
               return self.rightArray.count
            }else{
                return 0
            }
            
        }else{
            if self.wholeArray.count != 0 {
                return self.wholeArray.count
            }else{
                return 0
            }
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        if tableView == self.leftTableView{
            
            cell?.textLabel?.text = self.leftArray.objectAtIndex(indexPath.row) as? String
            
            
        }else if tableView == self.rightTableView {
            if self.rightArray.count != 0 {
                cell?.textLabel?.text = self.rightArray.objectAtIndex(indexPath.row) as?String
            }
        }else{
            if self.wholeArray.count != 0 {
                cell?.textLabel?.text = self.wholeArray.objectAtIndex(indexPath.row) as?String
            }
        }
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == self.leftTableView {
            if self.tableViewSelectedeComplete != nil {
                if self.oldButton.tag == 3 {
                    self.tableViewSelectedeComplete(indexPath.row,self.oldButton.tag)
                }else{
                    self.tableViewSelectedeComplete(indexPath.row,self.oldButton.tag)
                }
                
            }
        }else if tableView == self.rightTableView {
            if self.rightTableViewSelectedComplete != nil {
                if self.oldButton.tag == 3 {
                        (self.oldButton as!TCLYButton).label.text = self.rightArray.objectAtIndex(indexPath.row) as?String
                        self.rightTableViewSelectedComplete(indexPath.row,self.oldButton.tag)
                }else{
                    (self.oldButton as!TCLYButton).label.text = self.rightArray.objectAtIndex(indexPath.row) as?String
                    self.rightTableViewSelectedComplete(indexPath.row,self.oldButton.tag)
                }
                
            }
            self.leftTableView.removeFromSuperview()
            self.rightTableView.removeFromSuperview()
            self.wholeTableView.removeFromSuperview()
            self.oldButton.setImage(UIImage(named: "up"), forState: UIControlState.Normal)
            self.oldButton.selected = false
        }else{
            if (self.tableViewSelectedeComplete != nil){
                (self.oldButton as!TCLYButton).label.text = self.wholeArray.objectAtIndex(indexPath.row) as?String
                self.tableViewSelectedeComplete(indexPath.row,self.oldButton.tag)
            }
            
            self.leftTableView.removeFromSuperview()
            self.rightTableView.removeFromSuperview()
            self.wholeTableView.removeFromSuperview()
            self.oldButton.setImage(UIImage(named: "up"), forState: UIControlState.Normal)
            self.oldButton.selected = false
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
     点击按钮触发事件
     - parameter btn: 传入被点击的按钮
     */
    func btnClick(btn:UIButton){
        if self.leftTableView == nil || self.rightTableView == nil || self.wholeTableView == nil {
            self.initTableView()
        }
        
        self.changeTableViewFrame()
        /**
        *  除了被点击的按钮外，都让其恢复Normal状态
        */
        if self.oldButton != nil {
            if btn.tag != self.oldButton.tag{
                self.oldButton.selected = false
                self.oldButton.setImage(UIImage(named: "up"), forState: UIControlState.Normal)
                self.oldButton = btn
            }
        }else{
            self.oldButton = btn
        }
        
        /**
        *  按钮的状态改变，按钮的图案也随之改变
        */
        btn.selected = !btn.selected
        if btn.selected == true{
            if btn.tag<=3{
                self.window?.addSubview(self.leftTableView)
                self.window?.addSubview(self.rightTableView)
            }else{
                self.window?.addSubview(self.wholeTableView)
            }
            
            btn.setImage(UIImage(named: "down"), forState: UIControlState.Selected)
        }else{
            self.leftTableView.removeFromSuperview()
            self.rightTableView.removeFromSuperview()
            self.wholeTableView.removeFromSuperview()

            btn.setImage(UIImage(named: "up"), forState: UIControlState.Normal)
        }
        
        if (self.clickComplete != nil){
            self.clickComplete(btn)
            
        }
    }
    /**
     刷新leftTableView数据
     
     - parameter dataArrary: 数据源
     */
    func refreshTableViewData(dataArray:NSArray,seconderArray:NSArray,tag:NSInteger){
        
        if tag <= 3{
            self.leftArray = dataArray
            self.rightArray = seconderArray
            self.leftTableView.reloadData()
            self.rightTableView.reloadData()
        }else{
            self.wholeArray = dataArray
            self.wholeTableView.reloadData()
        }
    }
    /**
     刷新rightTableView数据
     
     - parameter rightArray: 数据源
     */
    func refreshRightTableView(rightArray:NSArray){
        self.rightArray = rightArray
        self.rightTableView.reloadData()
    }

}
