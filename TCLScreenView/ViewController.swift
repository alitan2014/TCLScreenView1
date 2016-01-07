//
//  ViewController.swift
//  TCLScreenView
//
//  Created by TCL on 16/1/6.
//  Copyright © 2016年 alitan2014. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initUI()
    }
    func initUI(){
        self.tableView = UITableView(frame: CGRectMake(0, 20, TCL_IPHONE_WIDTH, TCL_IPHONE_HEIGHT), style: UITableViewStyle.Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let screenView = TCLScreenView(frame: CGRectMake(0,0,TCL_IPHONE_WIDTH,50))
        screenView.initButtonWithArray(["附近","美食","智能排序","赛选"], btnClickComplete: {
            /**
            *  点击button触发事件
            */(sender:UIButton) -> Void in
            switch sender.tag {
            case 1:
                screenView.refreshTableViewData(["附近","美食","智能排序","赛选"], seconderArray: ["附近","美食","智能排序","赛选"], tag: sender.tag)
            case 2:
                screenView.refreshTableViewData(["哈哈","呵呵","吼吼","哒哒"], seconderArray: ["啦啦","嗯嗯","啧啧","咳咳"], tag: sender.tag)
            case 3:
                screenView.refreshTableViewData(["11","22","33","44"], seconderArray: [], tag: sender.tag)
            default:
                screenView.refreshTableViewData(["555","666","777","8888"], seconderArray: [], tag: sender.tag)
                print("")
            }
            }, leftTableViewSelected: { (obj, tag) -> Void in
                /**
                *   点击左边tableView row 触发事件
                */
                screenView.refreshRightTableView(["附近","美食","智能排序","赛选"])
                
            }) { (obj, tag) -> Void in
                /**
                点击右边tablev row 触发 事件
                */
                
        }
        return screenView
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = NSString.localizedStringWithFormat("第%ld行", indexPath.row) as String
        return cell!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

