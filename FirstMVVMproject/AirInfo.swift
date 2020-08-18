//
//  AirInfo.swift
//  FirstMVVMproject
//
//  Created by 김동준 on 2020/07/18.
//  Copyright © 2020 김동준. All rights reserved.
//

import Foundation
struct AirInfo {
    init(coGrade: String,coValue: String,dataTime: String,khaiGrade: String,khaiValue: String,mangName: String,no2Grade: String,no2Value: String,o3Grade: String,o3Value: String,pm10Grade: String,pm10Value: String,pm25Grade: String,pm25Value: String,so2Grade: String,so2Value: String,stationName: String){
        self.coGrade = coGrade
        self.coValue = coValue
        self.dataTime = dataTime
        self.khaiGrade = khaiGrade
        self.khaiValue = khaiValue
        self.mangName = mangName
        self.no2Grade = no2Grade
        self.no2Value = no2Value
        self.o3Grade = o3Grade
        self.o3Value = o3Value
        self.pm10Grade = pm10Grade
        self.pm10Value = pm10Value
        self.pm25Grade = pm25Grade
        self.pm25Value = pm25Value
        self.so2Grade = so2Grade
        self.so2Value = so2Value
        self.stationName = stationName
    }
    
    public func getCoGrade() -> String{
        return self.coGrade
    }
    
    public func getCoValue() -> String{
        return self.coValue
    }
    
    public func getDataTime() -> String{
        return self.dataTime
    }
    
    public func getKhaiGrade() -> String{
        return self.khaiGrade
    }
    
    public func getKhaiValue() -> String{
        return self.khaiValue
    }
    
    public func getMangName() -> String{
        return self.mangName
    }
    
    public func getNo2Grade() -> String{
        return self.no2Grade
    }
    
    public func getNo2Value() -> String{
        return self.no2Value
    }
    
    public func getO3Grade() -> String{
        return self.o3Grade
    }
    
    public func getO3Value() -> String{
        return self.o3Grade
    }
    
    public func getpm10Grade() -> String{
        return self.pm10Grade
    }
    
    public func getpm10Value() -> String{
        return self.pm10Value
    }
    
    public func getPm25Grade() -> String{
        return self.pm25Grade
    }
    
    public func getPm25Value() -> String{
        return self.pm25Value
    }
    
    public func getSo2Grade() -> String{
        return self.so2Grade
    }
    
    public func getSo2Value() -> String{
        return self.so2Value
    }
    
    public func getStationName() -> String{
        return self.stationName
    }
    
    public func printInfo(){
        print("coGrade : \(coGrade) coValue : \(coValue) dataTime : \(dataTime) khaiValue : \(khaiValue) mangName : \(mangName) no2Value : \(no2Value) o3Value : \(o3Value) pm10Value : \(pm10Value) pm25Value : \(pm25Value) so2Value : \(so2Value) stationName : \(stationName)")
    }
    
    private var coGrade: String = ""
    private var coValue: String = "" // 일산화탄소
    private var dataTime: String = ""
    private var khaiGrade: String = ""
    private var khaiValue: String = ""
    private var mangName: String = ""
    private var no2Grade: String = ""
    private var no2Value: String = "" // 이산화질소
    private var o3Grade: String = ""
    private var o3Value: String = "" // 오존
    private var pm10Grade: String = ""
    private var pm10Value: String = "" // 미세먼지
    private var pm25Grade: String = ""
    private var pm25Value: String = "" // 초미세먼지
    private var so2Grade: String = ""
    private var so2Value: String = "" // 아황산가스
    private var stationName: String = ""
}
