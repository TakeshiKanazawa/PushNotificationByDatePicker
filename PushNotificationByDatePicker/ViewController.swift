//
//  ViewController.swift
//  PushNotificationByDatePicker
//  Copyright © 2020 tk. All rights reserved.
//

import UIKit
import UserNotifications

//引数で指定した日付との差分の秒数を返すextension
extension Date {
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //UI Datepicker
    @IBOutlet weak var datePicker: UIDatePicker!
    //button for set localPushNotification
    @IBAction func buttonAction(_ sender: Any) {
        print("push notification set!")
        setNotification(date: datePicker.date)
    }

    func setNotification(date: Date) {
        //通知日時の設定
        var trigger: UNNotificationTrigger
        //noticficationtimeにdatepickerで取得した値をset
        let notificationTime = Calendar.current.dateComponents(in: TimeZone.current, from: date)
        //現在時刻の取得
        let now = Date()
        //変数setDateに取得日時をDatecomponens型で代入
        let setDate = DateComponents(calendar: .current, year: notificationTime.year, month: notificationTime.month, day: notificationTime.day, hour: notificationTime.hour, minute: notificationTime.minute, second: notificationTime.second).date!
        //変数secondsに現在時刻と通知日時の差分の秒数を代入
        let seconds = setDate.seconds(from: now)
        //triggerに現在時刻から〇〇秒後の実行時間をset
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
        //通知内容の設定
        let content = UNMutableNotificationContent()
        content.title = "title text"
        content.body = "body text"
        content.sound = .default
        //ユニークIDの設定
        let identifier = NSUUID().uuidString
        //登録用リクエストの設定
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        //通知をセット
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}


