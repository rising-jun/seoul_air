//
//  WeatherDataService.swift
//  FirstMVVMproject
//
//  Created by 김동준 on 2020/07/28.
//  Copyright © 2020 김동준. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class WeatherDataService{
    private var mainViewController: MainViewController!
    private let weatherDataModel: WeatherViewDataModel = WeatherViewDataModel()
    
    public func setMainViewController(mainViewController: MainViewController){
        self.mainViewController = mainViewController
    }
    
    public func bringAirInfoList() -> Observable<Array<AirInfo> >{
        return weatherDataModel.bringAirInfoList()
    }
    
    public func sendMyLocationAirInfo(lat: Double,lng: Double,airList: Array<AirInfo>){
        weatherDataModel.setWeatherDataService(weatherDataService: self)
        weatherDataModel.sendMyLocationAirInfo(lat: lat, lng: lng,airList: airList)
    }
    
    public func requestMyLocationAirInfo(airInfo: AirInfo){
        mainViewController.changeUi(airInfo: airInfo)
    }
    
    public func convertDate(date:String) -> [String]{
        return weatherDataModel.convertDate(date: date)
    }
    
    public func convertTime(time:String)->String{
        return weatherDataModel.convertTime(time: time)
    }
}
