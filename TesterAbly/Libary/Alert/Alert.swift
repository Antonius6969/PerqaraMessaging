//
//  Alert.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 10/08/23.
//

import Foundation
import UIKit

protocol AlertProtocol : class{
    func pressAlertOkButton()
    func pressAlertCancelButton()
}

class Alert {
    
    internal static var alert:UIAlertController!
    
    internal static func showAlertServer(title: AlertInfo, msg: String){
        var msgs: String = msg
        alert = UIAlertController(title: title.rawValue, message: msgs, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.topViewController()?.present(Alert.alert, animated: true, completion: nil)
        return
        
    }
    
    internal static func showCustom(title: String, msg: String){
        alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.topViewController()?.present(Alert.alert, animated: true, completion: nil)
        return
        
    }
    
    internal static func show(title: AlertInfo, msg: String){
        alert = UIAlertController(title: title.rawValue, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.topViewController()?.present(Alert.alert, animated: true, completion: nil)
        return
        
    }
    
    internal static func showWithCallback(title: AlertInfo, msg: AlertInfo, complete: @escaping(() -> Void) ){
        alert = UIAlertController(title: title.rawValue, message: msg.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert in
            complete()
        }))
        UIApplication.topViewController()?.present(Alert.alert, animated: true)
        return
    }
    
    internal static func showDynamic(title: AlertInfo, message: AlertInfo, options: String..., completion: @escaping (Int) -> Void) {
        alert = UIAlertController(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alert.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        UIApplication.topViewController()?.present(Alert.alert, animated: true, completion: nil)
        
        return
    }
    
    internal static func showDefault(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alert.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        UIApplication.topViewController()?.present(Alert.alert, animated: true, completion: nil)
        
        return
    }
    
    internal static func showWithCallback(title: AlertInfo, msg: AlertInfo,_ result: @escaping (Bool) -> Void){
        
        alert = UIAlertController(title: title.rawValue, message: msg.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (res: UIAlertAction) in
            result(true)
        }))
        UIApplication.topViewController()?.present(Alert.alert, animated: true, completion: nil)
        return
        
    }
    
    internal static func close(){
        UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
    }
    
    internal static func closeThen(_ result: @escaping (Bool) -> Void){
        UIApplication.topViewController()?.dismiss(animated: true, completion: { ()
            result(true)
        })
    }
    
    internal static func showTwoButton(title: AlertInfo, msg: AlertInfo, delegate:AlertProtocol){
        alert = UIAlertController(title: title.rawValue, message: msg.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ya", style: .default, handler: { (res: UIAlertAction) in
            delegate.pressAlertOkButton()
        }))
        alert.addAction(UIAlertAction(title: "Tidak", style: .default, handler: { (res: UIAlertAction) in
            delegate.pressAlertCancelButton()
        }))
        UIApplication.topViewController()?.present(Alert.alert, animated: true, completion: nil)
        return
    }
    
    internal static func showToast(controller: UIViewController, message : AlertInfo, seconds: Double, isImage: Bool = false) {
        let alert = UIAlertController(title: nil, message: message.rawValue, preferredStyle: .alert)
            if isImage {
                let imgViewTitle = UIImageView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
                imgViewTitle.image = UIImage(named:"ic_copy_black")
                alert.view.addSubview(imgViewTitle)
            }
            alert.view.backgroundColor = .clear
            alert.view.layer.cornerRadius = 15
            controller.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
                alert.dismiss(animated: true)
            }
        }
}
