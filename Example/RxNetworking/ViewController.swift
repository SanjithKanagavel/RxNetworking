//
//  ViewController.swift
//  RxNetworking
//
//  Created by SanjithKanagavel on 11/19/2020.
//  Copyright (c) 2020 SanjithKanagavel. All rights reserved.
//

import UIKit
import RxNetworking
import RxSwift

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        urlExample()
        getExample()
        postExample()
        putExample()
    }
    
    func urlExample() {
        if let url = URL(string: "https://postman-echo.com/get?foo1=bar1&foo2=bar2") {
            URLSession.shared
                .rx
                .dataTask(url: url)
                .subscribe(onNext: { (result) in
                    switch result {
                    case .success(let data, _):
                        if let d = data {
                            print("urlExample:")
                            print(String(decoding: d, as: UTF8.self))
                        }
                        break
                    case .failure(_):
                        break
                    }
                }).disposed(by: disposeBag)
        }
    }

    func getExample() {
        var request = URLRequest(url: URL(string: "https://postman-echo.com/get?foo1=bar1&foo2=bar2")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        URLSession.shared
            .rx
            .dataTask(request: request)
            .subscribe(onNext: { (result) in
                switch result {
                case .success(let data, _):
                    if let d = data {
                        print("getExample:")
                        print(String(decoding: d, as: UTF8.self))
                    }
                    break
                case .failure(_):
                    break
                }
            }).disposed(by: disposeBag)
    }
    
    func postExample() {
        let parameters = "foo1=bar1&foo2=bar2"
        let postData =  parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "https://postman-echo.com/post")!,timeoutInterval: Double.infinity)
        request.httpMethod = "POST"
        request.httpBody = postData
        
        URLSession.shared
            .rx
            .dataTask(request: request)
            .subscribe(onNext: { (result) in
                switch result {
                case .success(let data, _):
                    if let d = data {
                        print("postExample:")
                        print(String(decoding: d, as: UTF8.self))
                    }
                    break
                case .failure(_):
                    break
                }
            }).disposed(by: disposeBag)
        
    }
    
    func putExample() {
        let parameters = "This is expected to be sent back as part of response body."
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "https://postman-echo.com/put")!,timeoutInterval: Double.infinity)
        request.httpMethod = "PUT"
        request.httpBody = postData
        
        URLSession.shared
            .rx
            .dataTask(request: request)
            .subscribe(onNext: { (result) in
                switch result {
                case .success(let data, _):
                    if let d = data {
                        print("putExample:")
                        print(String(decoding: d, as: UTF8.self))
                    }
                    break
                case .failure(_):
                    break
                }
            }).disposed(by: disposeBag)
    }

}

