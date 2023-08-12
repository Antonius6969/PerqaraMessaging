//
//  DateExtension.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 09/08/23.
//

import Foundation

enum LocaleDate: String {
  case id = "id"
}

enum FromTypeDate: String {
  
  case defaultPerqara = "dd MMM yyyy HH.mm"
  case defaultRegister = "dd MMMM yyyy"
  
  case ddMMyyyyStrip = "dd-MM-yyyy"
  case ddMMyyyySlash = "dd/MM/yyyy"
  case yyyyMMddStrip = "yyyy-MM-dd"
  case defaultTrxId = "yyyyMMddHHmmss"
  
  case yyyyMMdd = "yyyyMMdd"
  
  case ddMMMMyyWithTime = "dd MMMM yyyy - HH:mm:ss"
  case ddMMMMyyTimeNoSecond = "dd MMMM yyyy - HH:mm"
  case ddMMMyyyyHHmm = "dd MMM yyyy - HH:mm"
  case ddMMMyyyyHHmmss = "dd MMM yyyy - HH:mm:ss"
  case dMMyyyHHmmss = "M/DD/YYYY, hh:mm:ss"
  
  case defaultListHistory = "yyyy-MM-dd HH:mm:ss"
  case currentListHistoryDate = "d MMM yyyy"
  case currentListHistoryTime = "HH:mm:ss"
  
  case timeServer = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
  
  case yyyyMMMddStrip = "yyyy-MMM-dd"
  
  case yyyymm = "yyyyMM"
  case MMMyy = "MMM-yy"
  
  case timeOnly = "HH:mm"
}



enum DFCurrentDateFormat : String{
  case defaultPerqara = "dd MMM yyyy HH.mm"
  case defaultRegister = "dd MMMM yyyy"
}

extension DateFormatter {
  static func generateCurrentDate(_ dateFormat : FromTypeDate) -> String {
    let dateFormatter : DateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat.rawValue
    dateFormatter.locale = Locale(identifier: LocaleDate.id.rawValue)
    let dateString = dateFormatter.string(from: Date())
    return dateString
  }
  
  static func dateConvert(valueDate: String, from: FromTypeDate, to: FromTypeDate, locale: LocaleDate = .id) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.locale = Locale(identifier: locale.rawValue)
    inputFormatter.dateFormat = from.rawValue
    let showDate = inputFormatter.date(from: valueDate) ?? Date()
    inputFormatter.dateFormat = to.rawValue
    let resultString = inputFormatter.string(from: showDate)
    return resultString
  }
  
  static func timeStampToStringDate(timestamp: Int,
                             to: FromTypeDate,
                             locale: LocaleDate = .id) -> String {
    let timeResult = (Double(timestamp) as? Double) ?? 0.0
    let date = Date(timeIntervalSince1970: timeResult)
    
    let dateFormatter : DateFormatter = DateFormatter()
    dateFormatter.dateFormat = to.rawValue
    dateFormatter.locale = Locale(identifier: LocaleDate.id.rawValue)
    let dateString = dateFormatter.string(from: date)
    return dateString
  }
}

extension Date {
  func formatAsShortDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.doesRelativeDateFormatting = true
    dateFormatter.locale = Locale(identifier: "id_ID")
    dateFormatter.timeStyle = .short
    dateFormatter.dateStyle = .none
    
    let dateText = dateFormatter.string(from: self).lowercased()
    return dateText
  }
}

extension Date {
  func currentTimeMillis() -> Int64 {
    return Int64(self.timeIntervalSince1970 * 1000)
  }
}
