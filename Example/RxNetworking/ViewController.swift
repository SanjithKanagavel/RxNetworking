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
        urlDataTaskExample()
        getRequest()
        getRequestWithParseData()
        postRequest()
        putRequest()
    }
    
    func urlDataTaskExample() {
        if let url = URL(string: "https://postman-echo.com/get?foo1=bar1&foo2=bar2") {
            URLSession.shared
                .rx
                .dataTask(url: url)
                .subscribe(onNext: { (result) in
                    if result.Error == nil, let data = result.Data {
                        print("urlDataTaskExample:\n" + String(decoding: data, as: UTF8.self))
                    }
                }).disposed(by: disposeBag)
        }
    }
    
    func urlDataTaskWithParseDataExample() {
        if let url = URL(string: "https://postman-echo.com/get?foo1=bar1&foo2=bar2") {
            URLSession.shared
                .rx
                .dataTask(url: url,returnType: ResponseData.self)
                .subscribe(onNext: { (result) in
                    if result.Error == nil, let data = result.Data,
                        let jsonData = try? JSONEncoder().encode(data),
                        let jsonString = String(data: jsonData, encoding: .utf8) {
                            print("urlDataTaskWithParseDataExample :\n" + jsonString)
                    }
                }).disposed(by: disposeBag)
        }
    }

    func getRequest() {
        var request = URLRequest(url: URL(string: "https://postman-echo.com/get?foo1=bar1&foo2=bar2")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        URLSession.shared
            .rx
            .dataTask(request: request)
            .subscribe(onNext: { (result) in
                if result.Error == nil, let data = result.Data {
                    print("getRequest:\n" + String(decoding: data, as: UTF8.self))
                }
            }).disposed(by: disposeBag)
    }
    
    func getRequestWithParseData() {
        var request = URLRequest(url: URL(string: "https://postman-echo.com/get?foo1=bar1&foo2=bar2")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        URLSession.shared
            .rx
            .dataTask(request: request, returnType: ResponseData.self)
            .subscribe(onNext: { (result) in
                if result.Error == nil, let data = result.Data,
                    let jsonData = try? JSONEncoder().encode(data),
                    let jsonString = String(data: jsonData, encoding: .utf8) {
                        print("getRequestWithParseData:\n" + jsonString)
                }
            }).disposed(by: disposeBag)
    }
    
    func postRequest() {
        let parameters = "foo1=bar1&foo2=bar2"
        let postData =  parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "https://postman-echo.com/post")!,timeoutInterval: Double.infinity)
        request.httpMethod = "POST"
        request.httpBody = postData
        URLSession.shared
            .rx
            .dataTask(request: request)
            .subscribe(onNext: { (result) in
                if result.Error == nil, let data = result.Data {
                    print("postExample:\n" + String(decoding: data, as: UTF8.self))
                }
            }).disposed(by: disposeBag)
    }
    
    func putRequest() {
        let parameters = "This is expected to be sent back as part of response body."
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "https://postman-echo.com/put")!,timeoutInterval: Double.infinity)
        request.httpMethod = "PUT"
        request.httpBody = postData
        URLSession.shared
            .rx
            .dataTask(request: request)
            .subscribe(onNext: { (result) in
                if result.Error == nil, let data = result.Data {
                    print("putExample:\n" + String(decoding: data, as: UTF8.self))
                }
            }).disposed(by: disposeBag)
    }
}

struct ResponseData : Codable {
    var args:[String:String]
    var headers:[String:String]
    var url:String
}
