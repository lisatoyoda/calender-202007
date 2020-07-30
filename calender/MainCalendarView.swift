//
//  MainCalendar.View.swift
//  calender
//
//  Created by 豊田莉彩 on 2019/05/23.
//  Copyright © 2019 豊田莉彩. All rights reserved.
//

import UIKit
import JTAppleCalendar

class MainCalendarView: UIView {

    var currentMonth: String!                          //表示月(YYYY年MM月)
    var selectDate: Date!                              //せ
    var calendarDelegate: MainCalendarViewDelegate?
    @IBOutlet var calendarView: JTAppleCalendarView!
    
    
    func changeCurrentMonth(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        let month = Calendar(identifier: .gregorian).dateComponents([.month],from: startDate).month
        let monthName = DateFormatter().monthSymbols[Int(month!)-1]
        let year = Calendar(identifier: .gregorian).component(.year, from: startDate)
        currentMonth = monthName + " " + String(year)
        
        
    }
    
    func dateToStr(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        return formatter.string(from: date)
    }
        
    override func awakeFromNib() {
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        let nibName = UINib(nibName: "MainCalendarCell", bundle:nil)
        calendarView.register(nibName, forCellWithReuseIdentifier: "MainCalendarCell")
        calendarView.minimumInteritemSpacing = 2
        calendarView.minimumLineSpacing = 2
    }
    
    
}

extension MainCalendarView: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        //セル情報更新
        let cell = calendar.dequeueReusableCell(withReuseIdentifier: "MainCalendarCell", for: indexPath) as! MainCalendarCell
        //日付が選択された時の文字の色//
        cell.dayLabel.text = cellState.text
        if currentMonth != getMonth(date: date) {//違う月だったら
            cell.dayLabel.textColor = UIColor.gray
            
        } else if cellState.isSelected == true /*cell選択された時*/ {
            cell.dayLabel.textColor = UIColor.red  //cell.dayLabelの色を変える
            
        } else { //true以外のとき
            cell.dayLabel.textColor = UIColor.black
        }
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.changeCurrentMonth(from: visibleDates)
        calendar.reloadData()
        calendarDelegate?.changeMonth(month: currentMonth)
    }
    
    func getMonth(date: Date) -> String {
        let month = Calendar(identifier: .gregorian).dateComponents([.month],from: date).month
        let monthName = DateFormatter().monthSymbols[Int(month!)-1]
        let year = Calendar(identifier: .gregorian).component(.year, from: date)
        return monthName + " " + String(year)
    }
    
    
    //選択した時の動作
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        selectDate = date
        calendarDelegate?.changeDate(date: dateToStr(from: date))//グッチー追加。選択日付が変わったことのdelegate
        if currentMonth != getMonth(date: date) {
            currentMonth = getMonth(date: date)
            calendarDelegate?.changeMonth(month: currentMonth)
        }

        
        calendar.reloadData(withanchor: date, completionHandler: nil) //セルの更新
    }
    
    //選択が外れた時
    private func calsendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        calendar.reloadData(withanchor: date, completionHandler: nil) //セルの更新
    }
    
    //カレンダーの基本設定
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .year, value: -1, to: calendar.startOfDay(for: Date()))
        let endDate = calendar.date(byAdding: .year, value: +1, to: calendar.startOfDay(for: Date()))
        let parameters = ConfigurationParameters(startDate: startDate!,endDate: endDate!,numberOfRows: 6,
                                                 calendar: calendar,generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfRow,firstDayOfWeek: .monday)
        return parameters
    }
    
}

protocol MainCalendarViewDelegate: class {
    func changeMonth(month: String)
    func changeDate(date: String)
}
