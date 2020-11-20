# RxNetworking

Networking library using RxSwift 

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RxNetworking is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxNetworking'
```


## Usage

DataTask with URL : 

```swift

if let url = URL(string: "<url>") {
    URLSession.shared
        .rx
        .dataTask(url: url)
        .subscribe(onNext: { (result) in
            if result.Error == nil, let data = result.Data {
                print("urlDataTaskExample:\n" + String(decoding: data, as: UTF8.self))
            }
        }).disposed(by: disposeBag)
}   
```

DataTask with URLRequest :

```swift

var request = URLRequest(url: URL(string: "<url>")!,timeoutInterval: Double.infinity)
request.httpMethod = "GET"
URLSession.shared
    .rx
    .dataTask(request: request)
    .subscribe(onNext: { (result) in
        if result.Error == nil, let data = result.Data {
            print("getRequest:\n" + String(decoding: data, as: UTF8.self))
        }
    }).disposed(by: disposeBag)
```

Inbuilt decode with dataTask :

```swift
if let url = URL(string: "<url>") {
    URLSession.shared
        .rx
        .dataTask(url: url,returnType: YourCodableStruct.self)
        .subscribe(onNext: { (result) in
            if result.Error == nil, let data = result.Data,
                let jsonData = try? JSONEncoder().encode(data),
                let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
            }
        }).disposed(by: disposeBag)
}
```

`returnType`  should extend Codable Protocol

  `downloadTask`, `uploadTask` methods are added for download and uploading files  


## Requirements

* iOS 9.0+
* Xcode 7.0+

## Author

SanjithKanagavel, sanjithkanagavel@gmail.com

## License

RxNetworking is available under the MIT license. See the LICENSE file for more info.
