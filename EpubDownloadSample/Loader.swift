//
//  Loader.swift
//  EpubDownloadSample
//
//  Created by kazuki.morita on 2019/10/05.
//

import Foundation
import MBProgressHUD

class Loader {
    
    static func show() {
        let progressHUD = MBProgressHUD.showAdded(to: foregroundViewController().view, animated: true)
        progressHUD.bezelView.style = .solidColor
        progressHUD.bezelView.backgroundColor = UIColor(white: 0x020203, alpha: 0.4)
        progressHUD.show(animated: true)
    }
    
    static func hide() {
        MBProgressHUD.hide(for: foregroundViewController().view, animated: true)
    }
    
    private static func foregroundViewController() -> UIViewController {
        var topController = UIApplication.shared.windows[0].rootViewController!
        while topController.presentedViewController != nil {
            topController = topController.presentedViewController!
        }
        return topController
    }
}
