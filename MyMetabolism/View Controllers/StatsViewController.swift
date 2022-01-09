//
//  StatsViewController.swift
//  MyMetabolism
//
//  Created by Liam Shatzel on 8/26/21.
//  Copyright © 2021 Liam Shatzel. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Charts

//Firestore Document Location
let docRef = Firestore.firestore().collection("users").document(currentUser()).collection("finishTime").document("time")

var count : Float = 0


func getDayOfWeek() -> Int? {
    let todayDate = Date()
    let myCalendar = Calendar(identifier: .gregorian)
    let weekDay = myCalendar.component(.weekday, from: todayDate)
    return weekDay
}

func timeFormat(_ time: Float) -> String{
    let retVal = String (format: "%.2f", time)
    let formatted: [String] = (retVal.components(separatedBy: "."))
    var hour = formatted[0]
    var min = formatted[1]
    let minRound: Int = Int(min)! % 60
    min = String(format: "%02d", minRound)
    var hourNum = Int(time) as Int
    var dayNight = ""
    print(hourNum)
    
    if(hourNum >= 24){
        hourNum -= 12
        hour = String(hourNum)
        dayNight = "AM"
    }else if(hourNum > 12){
        hourNum -= 12
        hour = String(hourNum)
        dayNight = "PM"
    }else{
        hour = String(hourNum)
        dayNight = "AM"
    }
    return "\(hour):\(min) \(dayNight)"
}

var times: [String]!

weak var axisFormatDelegate: IAxisValueFormatter?

func timeToFloat(timeString: String) -> Float{
    //From string into time and AM/PM
    let timeArr: [String] = timeString.components(separatedBy: " ")
    let time : String = timeArr[0]
    let dayNight : String = timeArr[1]
    
    //Into hours and minutes
    let timeSplit : [String] = time.components(separatedBy: ":")
    var hours : Int = Int(timeSplit[0]) ?? 0
    if dayNight == "PM" && hours != 12{
        hours += 12
    } else if hours == 12 && dayNight == "AM" {
        hours += 12
    }
    let decMins : String = "." + timeSplit[1]
    let mins = (decMins as NSString).floatValue
    return Float(hours) + mins
}




class StatsViewController: UIViewController, ChartViewDelegate{
    
    @IBOutlet weak var timeFinishLabel: UILabel!
    
    
    @IBOutlet weak var gradeLabel: UILabel!
    
    var lineChart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timesFront = ["00:00", "1:00 AM", "2:00 AM", "3:00 AM", "4:00 AM", "5:00 AM", "6:00 AM", "7:00 AM", "8:00 AM", "9:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM", "5:00 PM", "6:00 PM", "7:00 PM", "8:00 PM", "9:00 PM", "10:00 PM", "11:00 PM", "12:00 AM"]
        times = timesFront.reversed()
        print(times)
        lineChart.delegate = self
        
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0]
        setChart(dataEntryX: times, dataEntryY: unitsSold)
        
        //Sets the timeLabel text when there are no real entries
        func setTimeLabel(){
            print("time == 00")
            let timeRef = Firestore.firestore().collection("users").document(currentUser()).collection("timeList")
            timeRef.whereField("date", isNotEqualTo: 0).order(by: "date").limit(to: 1).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let timeDone = timeFormat(document.get("time") as! Float)
                        self.timeFinishLabel.text = timeDone
                    }
                }
            }
        }
        
        //Fetches document from Firestore and Sets timeLabel as time set
        docRef.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            let getTime = document.get("overallAverage") as! Float?
            if (Float(getTime ?? 0.0) == 0.0) {
                setTimeLabel()
            } else {
                let timeFinish = timeFormat(getTime ?? 0.0)
                self.timeFinishLabel.text = timeFinish
            }
            
            switch getTime ?? 0.0{
            case 11...18:
                self.gradeLabel.text = "😀"
            case 19...20:
                self.gradeLabel.text = "🙂"
            case 21...22:
                self.gradeLabel.text = "😐"
            case 22..<23:
                self.gradeLabel.text = "😬"
            default:
                self.gradeLabel.text = "😳"
            }
        }
        

        
    }
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    func setChart(dataEntryX forX:[String], dataEntryY forY:[Double]){
        var entries: [ChartDataEntry] = []
        for x in 0..<forY.count {
            let entry = ChartDataEntry(x: Double(x), y: Double(forY[x]), data: times as [String]?)
            print(entry)
            entries.append(entry)
        }
        let set = LineChartDataSet(entries: entries, label: "Time Finished Eating")
        let TimeColorString = [NSUIColor(cgColor: UIColor(named: "Text")!.cgColor)]
        set.colors = TimeColorString
        let data = LineChartData(dataSet: set)
        let yAxis = lineChartView.leftAxis
        let legend = lineChartView.legend
        legend.font = .boldSystemFont(ofSize: 10)
        
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChartView.animate(xAxisDuration: 1.2)
        lineChartView.xAxis.setLabelCount(8, force: true)
        
        set.circleColors = TimeColorString
        set.circleRadius = 4
        set.drawValuesEnabled = false
        
        
        data.setValueFont(.boldSystemFont(ofSize: 12))
        //let chartDataSet = ChartDataSet(entries: entries, label: "Units Sold")
        // let chartData = ChartData(dataSet: chartDataSet)

        lineChartView.xAxis.granularityEnabled = true
        lineChartView.xAxis.granularity = 1.0 //default granularity is 1.0, but it is better to be explicit
        lineChartView.xAxis.decimals = 0
        

        
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.labelPosition = .bottom
        yAxis.valueFormatter = LineChartYFormatter()
        lineChartView.xAxis.valueFormatter = LineChartXFormatter()
        lineChartView.data = data
        
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        var entries = [ChartDataEntry]()
//
//        for x in 1..<11 {
//            entries.append(ChartDataEntry(x: Double((x)), y: Double(x)))
//        }
//        let set = LineChartDataSet(entries: entries, label: "Time Finished Eating")
//        let TimeColorString = [NSUIColor(cgColor: UIColor(named: "Text")!.cgColor)]
//        set.colors = TimeColorString
//        let data = LineChartData(dataSet: set)
//        let yAxis = lineChartView.leftAxis
//        let legend = lineChartView.legend
//        legend.font = .boldSystemFont(ofSize: 10)
//
//        yAxis.labelFont = .boldSystemFont(ofSize: 12)
//        lineChartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
//        lineChartView.animate(xAxisDuration: 1.2)
//        lineChartView.xAxis.setLabelCount(7, force: true)
//
//        set.circleColors = TimeColorString
//        set.circleRadius = 4
//
//
//        data.setValueFont(.boldSystemFont(ofSize: 12))
//
//        lineChartView.rightAxis.enabled = false
//        lineChartView.xAxis.labelPosition = .bottom
//        lineChartView.data = data
//        lineChartView.xAxis.valueFormatter = axisFormatDelegate
//
//    }
}

@objc(LineChartYFormatter)
public class LineChartYFormatter: NSObject, IAxisValueFormatter
{
    var times = ["12:00 AM", "11:00 PM", "10:00 PM", "9:00 PM", "8:00 PM", "7:00 PM", "6:00 PM", "5:00 PM", "4:00 PM", "3:00 PM", "2:00 PM", "1:00 PM", "12:00 PM", "11:00 AM", "10:00 AM", "9:00 AM", "8:00 AM", "7:00 AM", "6:00 AM", "5:00 AM", "4:00 AM", "3:00 AM", "2:00 AM", "1:00 AM", "00:00"]

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String
    {
        return times[Int(value)]
    }

    public func setValues(values: [String])
    {
        self.times = values
    }
}

@objc(LineChartXFormatter)
public class LineChartXFormatter: NSObject, IAxisValueFormatter
{
    var days = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"]

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String
    {
        return days[Int(value)]
    }

    public func setValues(values: [String])
    {
        self.days = values
    }
}

//extension LineChartView: IAxisValueFormatter {
//    var names = [String]()
//    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        return times[Int(value)]
//    }
//    public func setValues(values: [String])
//     {
//         self.names = values
//     }
//}




