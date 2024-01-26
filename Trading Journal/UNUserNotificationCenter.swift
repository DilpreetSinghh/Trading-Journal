//
//  UNUserNotificationCenter.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 27/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import UserNotifications

func scheduleNotification(for trade: TradeNote) {
    let content = UNMutableNotificationContent()
    content.title = "Trade Reminder"
    content.body = "Remember to check your trade for \(trade.symbol)."

    // Configure the trigger for a specific date and time.
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (60*15), repeats: true)

    // Create the request
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    // Schedule the request with the system.
    UNUserNotificationCenter.current().add(request)
}

