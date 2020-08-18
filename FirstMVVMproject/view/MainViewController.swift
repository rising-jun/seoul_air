//
//  MainViewController.swift
//  FirstMVVMproject
//
//  Created by 김동준 on 2020/07/28.
//  Copyright © 2020 김동준. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MainViewController: UIViewController,UIScrollViewDelegate{
    private var weatherService: WeatherDataService = WeatherDataService()
    private var lat: Double = 0.0
    private var lng: Double = 0.0
    private var airInfoList: Array<AirInfo> = []
    
    private let scrollView = UIScrollView()
    
    
    private let dateLabel = UILabel()
    private let timeLabel = UILabel()
    private let locLabel = UILabel()
    private let iconView = UIImageView()
    private let stateLabel = UILabel()
    private let comentLabel = UILabel()
    
    private let infoView = UIView()
    
    private let pm10View = UIView()
    private let pm25View = UIView()
    private let o3View = UIView()
    private let so2View = UIView()
    private let coView = UIView()
    private let no2View = UIView()
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        weatherService.setMainViewController(mainViewController: self)
        weatherService.sendMyLocationAirInfo(lat: self.lat, lng: self.lng, airList: self.airInfoList)
        viewSetting()
        
        
    }
    
    private func viewSetting(){
        scrollView.delegate = self
        self.presentingViewController?.dismiss(animated: false)
        self.view.addSubview(dateLabel)
        self.view.addSubview(timeLabel)
        self.view.addSubview(locLabel)
        self.view.addSubview(iconView)
        self.view.addSubview(stateLabel)
        self.view.addSubview(comentLabel)
        
        dateLabel.textAlignment = .center
        dateLabel.font = dateLabel.font.withSize(18)
        dateLabel.textColor = .white
        dateLabel.snp.makeConstraints { (make) in
            make.width.equalTo(144 * view.frame.width / 375)
            make.height.equalTo(20 * view.frame.height / 812)
            make.top.equalTo(view.frame.width).offset(66 * view.frame.height / 812)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(115 * view.frame.width / 375)
        }
        
        timeLabel.textAlignment = .center
        timeLabel.font = timeLabel.font.withSize(22)
        timeLabel.textColor = .white
        timeLabel.snp.makeConstraints { (make) in
            make.width.equalTo(144 * view.frame.width / 375)
            make.height.equalTo(25 * view.frame.height / 812)
            make.top.equalTo(dateLabel.snp.bottom).offset(53 * view.frame.height / 812)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(115 * view.frame.width / 375)
        }
        
        locLabel.textAlignment = .center
        locLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        locLabel.font = locLabel.font.withSize(42)
        locLabel.textColor = .white
        locLabel.snp.makeConstraints { (make) in
            make.width.equalTo(114 * view.frame.width / 375)
            make.height.equalTo(47 * view.frame.height / 812)
            make.top.equalTo(timeLabel.snp.bottom).offset(10 * view.frame.height / 812)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(130 * view.frame.width / 375)
        }
        
        iconView.snp.makeConstraints { (make) in
            make.width.equalTo(114 * view.frame.width / 375)
            make.height.equalTo(108 * view.frame.height / 812)
            make.top.equalTo(locLabel.snp.bottom).offset(33 * view.frame.height / 812)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(130 * view.frame.width / 375)
        }
        
        stateLabel.textAlignment = .center
        stateLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        stateLabel.font = stateLabel.font.withSize(61)
        stateLabel.textColor = .white
        stateLabel.snp.makeConstraints { (make) in
            make.width.equalTo(110 * view.frame.width / 375)
            make.height.equalTo(68 * view.frame.height / 812)
            make.top.equalTo(iconView.snp.bottom).offset(33 * view.frame.height / 812)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(132 * view.frame.width / 375)
        }
        
        comentLabel.textAlignment = .center
        comentLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        comentLabel.font = stateLabel.font.withSize(22)
        comentLabel.textColor = .white
        comentLabel.snp.makeConstraints { (make) in
            make.width.equalTo(200 * view.frame.width / 375)
            make.height.equalTo(25 * view.frame.height / 812)
            make.top.equalTo(stateLabel.snp.bottom).offset(22 * view.frame.height / 812)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(87 * view.frame.width / 375)
        }
        setScrollView()
    }
    
    private func setScrollView(){
        self.view.addSubview(scrollView)
        
        
         scrollView.snp.makeConstraints { (make) in
             make.width.equalTo(355 * view.frame.width / 375)
             make.height.equalTo(189 * view.frame.height / 812)
             make.top.equalTo(comentLabel.snp.bottom).offset(66 * view.frame.height / 812)
             make.leading.equalTo(view.safeAreaLayoutGuide).offset(10 * view.frame.width / 375)
             make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10 * view.frame.width / 375)
         
        }
        
        scrollView.contentSize.width = (130 * view.frame.width / 375) * 6
        scrollView.contentSize.height = (180 * view.frame.height / 812)
        scrollView.isScrollEnabled = true
        //scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        //scrollView.showsVerticalScrollIndicator = false
    }
    
    public func changeUi(airInfo: AirInfo){
        airInfo.printInfo()
        let timeArray : [String] = weatherService.convertDate(date: airInfo.getDataTime())
        
        setBackColor(grade: airInfo.getpm10Grade(),view: self.view)
        
        dateLabel.text = timeArray[0] + "년 " + timeArray[1] + "월 " + timeArray[2] + "일"
        timeLabel.text = weatherService.convertTime(time: timeArray[3])
        locLabel.text = airInfo.getStationName()
        
        iconView.image = setIcon(grade: airInfo.getpm10Grade())
        iconView.contentMode = .scaleAspectFit
        
        stateLabel.text = setStateText(grade: airInfo.getpm10Grade())
        comentLabel.text = setComentText(grade: airInfo.getpm10Grade())
        
        
        scrollView.addSubview(pm10View)
        scrollView.addSubview(pm25View)
        scrollView.addSubview(o3View)
        scrollView.addSubview(so2View)
        scrollView.addSubview(coView)
        scrollView.addSubview(no2View)
        
        
        setFactorUi(factorView: pm10View, name: "미세먼지",value: airInfo.getpm10Value(), grade: airInfo.getpm10Grade())
        setFactorUi(factorView: pm25View, name: "초미세먼지", value: airInfo.getPm25Value(), grade: airInfo.getPm25Grade())
        setFactorUi(factorView: o3View, name: "오존", value: airInfo.getO3Value(), grade: airInfo.getO3Grade())
        setFactorUi(factorView: so2View, name: "아황산가스", value: airInfo.getSo2Value(), grade: airInfo.getSo2Grade())
        setFactorUi(factorView: coView, name: "일산화탄소", value: airInfo.getCoValue(), grade: airInfo.getCoGrade())
        setFactorUi(factorView: no2View, name: "이산화질소", value: airInfo.getNo2Value(), grade: airInfo.getNo2Grade())
        
    }
    
    private func setFactorUi(factorView: UIView, name: String, value: String, grade: String){
        factorView.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
        factorView.layer.cornerRadius = 10
        factorView.snp.makeConstraints { (make) in
            make.width.equalTo(120 * view.frame.width / 375)
            make.height.equalTo(180 * view.frame.height / 812)
            if(name == "미세먼지"){
                make.leading.equalTo(scrollView).offset(10 * view.frame.width / 375)
            }
            
            if(name == "초미세먼지"){
                make.leading.equalTo(pm10View.snp.trailing).offset(10 * view.frame.width / 375)
            }
            
            if(name == "오존"){
                make.leading.equalTo(pm25View.snp.trailing).offset(10 * view.frame.width / 375)
            }
            
            if(name == "아황산가스"){
                make.leading.equalTo(o3View.snp.trailing).offset(10 * view.frame.width / 375)
            }
            
            if(name == "일산화탄소"){
                make.leading.equalTo(so2View.snp.trailing).offset(10 * view.frame.width / 375)
            }
            
            if(name == "이산화질소"){
                make.leading.equalTo(coView.snp.trailing).offset(10 * view.frame.width / 375)
            }
        }
        
        let nameLabel = UILabel()
        factorView.addSubview(nameLabel)
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        nameLabel.font = nameLabel.font.withSize(18)
        nameLabel.textColor = .white
        nameLabel.text = name
        nameLabel.snp.makeConstraints { (make) in
            make.width.equalTo(76 * view.frame.width / 375)
            make.height.equalTo(18 * view.frame.height / 812)
            make.top.equalTo(factorView).offset(22 * view.frame.height / 812)
            make.leading.equalTo(factorView).offset(22 * view.frame.width / 375)
        }
        
        let factorIcon = UIImageView()
        factorView.addSubview(factorIcon)
        factorIcon.image = setIcon(grade: grade)
        factorIcon.contentMode = .scaleAspectFit
        
        factorIcon.snp.makeConstraints { (make) in
            make.width.equalTo(58 * view.frame.width / 375)
            make.height.equalTo(55 * view.frame.height / 812)
            make.top.equalTo(nameLabel.snp.bottom).offset(15 * view.frame.height / 812)
            make.leading.equalTo(factorView).offset(31 * view.frame.width / 375)
        }
        
        let factorState = UILabel()
        factorView.addSubview(factorState)
        factorState.text = setStateText(grade: grade)
        factorState.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        factorState.font = stateLabel.font.withSize(18)
        factorState.textColor = .white
        factorState.snp.makeConstraints { (make) in
            make.width.equalTo(32 * view.frame.width / 375)
            make.height.equalTo(20 * view.frame.height / 812)
            make.top.equalTo(factorIcon.snp.bottom).offset(17 * view.frame.height / 812)
            make.leading.equalTo(factorView).offset(44 * view.frame.width / 375)
        }
        
        let factorValue = UILabel()
        factorView.addSubview(factorValue)
        factorValue.text = value + "㎍/m³"
        factorValue.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        factorValue.font = stateLabel.font.withSize(14)
        factorValue.textColor = .white
        factorValue.snp.makeConstraints { (make) in
            make.width.equalTo(50 * view.frame.width / 375)
            make.height.equalTo(16 * view.frame.height / 812)
            make.top.equalTo(factorState.snp.bottom).offset(4 * view.frame.height / 812)
            make.leading.equalTo(factorView).offset(35 * view.frame.width / 375)
        }
        
        
    }
    
    private func setBackColor(grade:String,view: UIView){
        if(grade == "1"){
            self.view.backgroundColor = UIColor(displayP3Red: 0/255, green: 102/255, blue: 255/255, alpha: 1)
        }else if(grade == "2"){
            self.view.backgroundColor = UIColor(displayP3Red: 8/255, green: 232/255, blue: 0/255, alpha: 1)
        }else if(grade == "3"){
            self.view.backgroundColor = UIColor(displayP3Red: 255/255, green: 187/255, blue: 0/255, alpha: 1)
        }else if(grade == "4"){
            self.view.backgroundColor = UIColor(displayP3Red: 255/255, green: 51/255, blue: 51/255, alpha: 1)
        }
    }
    
    private func setStateText(grade:String)->String{
        if(grade == "1"){
            return "좋음"
        }else if(grade == "2"){
            return "보통"
        }else if(grade == "3"){
            return "나쁨"
        }else if(grade == "4"){
            return "매우나쁨"
        }
        return "---"
    }
    
    private func setComentText(grade:String)->String{
        if(grade == "1"){
            return "오늘 공기 최고 좋아요!"
        }else if(grade == "2"){
            return "오늘 공기 보통이에요!"
        }else if(grade == "3"){
            return "오늘 공기 나빠요!"
        }else if(grade == "4"){
            return "오늘 공기 최악이에요!"
        }
        return "데이터를 가져오지 못하였습니다."
    }
    
    private func setIcon(grade:String)->UIImage{
        if(grade == "1"){
            return UIImage(named: "fine_icon.png")!
        }else if(grade == "2"){
            return UIImage(named: "usual_icon.png")!
        }else if(grade == "3"){
            return UIImage(named: "bad_icon.png")!
        }else if(grade == "4"){
            return UIImage(named: "very_bad_icon.png")!
        }
        return UIImage(named: "splash_icon.png")!
    }
    
    public func setPoint(lat: Double, lng: Double){
        self.lat = lat
        self.lng = lng
    }
    
    public func setAirInfoList(airInfoList: Array<AirInfo>){
        self.airInfoList = airInfoList
    }
    
}
