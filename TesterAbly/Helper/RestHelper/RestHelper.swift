//
//  RestHelper.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 08/08/23.
//

import Foundation
import Alamofire

//enum ResultStatusResp<Value> {
//  case success(Value)
//  case failure(Err)
//}

class RestHelper{
  func getAuthHeader() -> HTTPHeaders {
    return [
      "accept": "application/json",
      "Content-Type": "application/json"
    ]
  }
  
  func getHeader() -> HTTPHeaders {
    return [
      "accept": "application/json",
      "Content-Type": "application/json"
    ]
  }
  
  func getWithAuth() -> HTTPHeaders {
    return [
      //"Authorization": "Bearer \(Prefs.getToken() ?? "")",
      "accept": "application/json",
      "Content-Type": "application/json",
    ]
  }
  
  func getWithIdHeader() -> HTTPHeaders {
    return [
      //"Authorization": "Bearer \(Prefs.getToken() ?? "")",
      "accept": "application/json",
      "Content-Type": "application/json",
      "X-Language": "id"
    ]
  }
  
  func objectToDict<T: Encodable>(data: T) -> [String:Any]? {
    do {
      let json = try JSONEncoder().encode(data)
      let dictResult = try JSONSerialization.jsonObject(with: json, options: []) as? [String:Any]
      return dictResult
    } catch {
      return nil
    }
  }
  
//  func postFileImage<T : Decodable, U : Encodable>(url: String,
//                                                   imgData : Data,
//                                                   fileName:String,
//                                                   responseType: T.Type,
//                                                   param: U? = nil,
//                                                   complete: @escaping((MessageSendFileResp) -> Void),
//                                                   errors: @escaping((Err) -> Void) ) {
//    let parameter = objectToDict(data: param) ?? [:]
//    let request = AF.upload(multipartFormData: { (multipart: MultipartFormData) in
//      multipart.append(imgData, withName: "file", fileName: fileName, mimeType: "image/png")
//      for (key, value) in parameter {
//        multipart.append((value as! String).data(using: String.Encoding.utf8)!, withName: key as String)
//      }
//    },to: url,usingThreshold: UInt64.init(),method: .post,headers: getWithAuth())
//      .uploadProgress(queue: .main, closure: { progress in
//        //Current upload progress of file
//        print("Upload Progress: \(progress.fractionCompleted)")
//      })
//      .responseJSON(completionHandler: { data in
//        //Do what ever you want to do with response
//        switch data.result {
//        case .success(let upload):
//          print("Succesfully uploaded")
//          var resp = MessageSendFileResp(success: true, message: "")
//          complete(resp)
//          break
//        case .failure(let error):
//          print("Error in upload: \(error.localizedDescription)")
//          errors(Err(status:"\(error.responseCode)",message:"\(error.localizedDescription)"))
//        }
//      })
//  }
}
