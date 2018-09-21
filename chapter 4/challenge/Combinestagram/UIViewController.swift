//
//  UIViewController.swift
//  Combinestagram
//
//  Created by Rahul Reddy Rachamalla on 9/21/18.
//  Copyright © 2018 Underplot ltd. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension UIViewController {
    func alert(_ title: String, description: String? = nil) -> Completable {
        return Completable.create { [weak self] completable in
            let alertVC = UIAlertController(title: title, message: description, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in
                    completable(.completed)
            }))
        self?.present(alertVC, animated: true, completion: nil)
            print(self)
            return Disposables.create() {
                self?.dismiss(animated: true, completion: nil)
                
            }
        }
    }
}
