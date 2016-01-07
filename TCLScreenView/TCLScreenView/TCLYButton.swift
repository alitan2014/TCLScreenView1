//
//  TCLButton.swift
//  TwoToTwo
//
//  Created by TCL on 15/12/28.
//  Copyright © 2015年 twototwo. All rights reserved.
//

import UIKit
var X:CGFloat=12//X
var Y:CGFloat=12//Y
var width:CGFloat = 40//宽
var height:CGFloat = 21//高
//var FONT :UIFont = UIFont(name: "Heiti SC Thin", size: 15)!
class TCLYButton: UIButton {
    var label:UILabel!
    var imgView:UIImageView!
    var lineImgView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }

    func initUI(){
        label = UILabel(frame: CGRectMake(X,Y,width,height))
        label.font = UIFont.systemFontOfSize(15)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.grayColor()
        self.addSubview(label)
        
        imgView = UIImageView(frame: CGRectMake(CGRectGetMaxX(label.frame), Y, 17, 17))
        imgView.image = UIImage(named: "up")
        self.addSubview(imgView)
        lineImgView = UIImageView(frame: CGRectMake(CGRectGetWidth(self.frame)-1, Y, 1, height))
        lineImgView.image = UIImage(named: "vertical_line")
        lineImgView.backgroundColor = UIColor.redColor()
        self.addSubview(lineImgView)
    }
    func setLabelTitle(title:String)
    {
        label.text = title
    }
    override func setImage(image: UIImage?, forState state: UIControlState) {
            self.imgView.image = image
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
