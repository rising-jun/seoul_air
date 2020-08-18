//
//  WeatherDataModel.swift
//  FirstMVVMproject
//
//  Created by 김동준 on 2020/07/16.
//  Copyright © 2020 김동준. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation
class WeatherViewDataModel{
    private var disposeBag: DisposeBag = DisposeBag()
    private var weatherDataService: WeatherDataService!
    public func setWeatherDataService(weatherDataService: WeatherDataService){
        self.weatherDataService = weatherDataService
    }
    
    public func bringAirInfoList() -> Observable<Array<AirInfo> >{
        let key = "1JUx53nAuRK7R7oDRkF%2BQ3B8Aonj3YXBgV0nIQmDoNBl8yb7M4B4IprCD5mRpOuaL%2Fv6j8mgCLeXiaG08tYWaw%3D%3D"        // 영화진흥회에서 받을 key
        let urlString: String = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty?ServiceKey=1JUx53nAuRK7R7oDRkF%2BQ3B8Aonj3YXBgV0nIQmDoNBl8yb7M4B4IprCD5mRpOuaL%2Fv6j8mgCLeXiaG08tYWaw%3D%3D&numOfRows=50&pageNo=1&sidoName=%EC%84%9C%EC%9A%B8&ver=1.3&_returnType=json"
        
           let url = URL(string: urlString)
            var airInfoList: Array<AirInfo> = []
              return URLSession.shared.rx.json(url: url!).map { (any) in
                  let json = any as! [String : Any]
                  airInfoList = self.convertJsonToVoList(json: json)
                  return airInfoList
                  }.observeOn(MainScheduler.instance)
        
    }
    
    public func convertJsonToVoList(json : [String : Any])->Array<AirInfo>{
        var airInfoList : Array<AirInfo> = []
        if let air = json["list"] as? [[String : Any]]{
            for airIdx in air{
                let mangName = airIdx["mangName"] as! String
                if mangName == "도시대기"{
                let airInfo : AirInfo
                    = AirInfo(coGrade: airIdx["coGrade"] as? String ?? "", coValue: airIdx["coValue"] as! String, dataTime: airIdx["dataTime"] as! String, khaiGrade: airIdx["khaiGrade"] as? String ?? "", khaiValue: airIdx["khaiValue"] as! String, mangName: mangName, no2Grade: airIdx["no2Grade"] as? String ?? "", no2Value: airIdx["no2Value"] as! String, o3Grade: airIdx["o3Grade"] as? String ?? "", o3Value: airIdx["o3Value"] as! String, pm10Grade: airIdx["pm10Grade"] as? String ?? "", pm10Value: airIdx["pm10Value"] as! String, pm25Grade: airIdx["pm25Grade"] as? String ?? "", pm25Value: airIdx["pm25Value"] as! String, so2Grade: airIdx["s2Grade"] as? String ?? "", so2Value: airIdx["so2Value"] as? String ?? "", stationName: airIdx["stationName"] as! String)
                airInfoList.append(airInfo)
            }
            }
        }
        return airInfoList
    }
    
    private var locationManager: CLLocationManager!
    private var address: String = "before"
    public func sendMyLocationAirInfo(lat: Double, lng: Double,airList: Array<AirInfo>){
        locationManager = CLLocationManager()
        let findLocation = CLLocation(latitude: lat, longitude: lng)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr") //원하는 언어의 나라 코드를 넣어주시면 됩니다.
        
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            if let address = placeMark?.addressDictionary!["City"] as? String{
                for airIdx in airList{
                    if(airIdx.getStationName() == address){
                        self.weatherDataService.requestMyLocationAirInfo(airInfo: airIdx)
                        return
                    }
                }
                
            }else{
                print("fail to get address")
            }
        })
    }
    
    public func convertDate(date:String) -> [String]{
        var dateArray : [String] = ["","","",""]
        var i: Int = 0
        for str in date {
            if(str == "-" || str == " "){
                i+=1
            }else{
                dateArray[i] += String(str)
            }
        }
        return dateArray
    }
    
    public func convertTime(time: String)->String{
        var timeText: String = ""
        var hmArray: [String] = ["",""]
        var i: Int = 0
        for str in time {
            if(str == ":"){
                i+=1
            }else{
                hmArray[i] += String(str)
            }
        }
        var hour: Int = Int(hmArray[0]) ?? 0
        
        if(hour > 12){
            hour -= 12
            
            if(hour < 10){
                timeText = "오후 0\(hour)시 기준"
            }else{
                timeText = "오후 \(hour)시 기준"
                }
            }else{
            timeText = "오전 \(hour)시 기준"
        }
        
        return timeText
    }
    
}
