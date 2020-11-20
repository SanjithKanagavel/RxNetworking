import Foundation
import RxSwift

public enum URLSessionTaskResponse {
    case success(Data?,URLResponse?)
    case failure(Error?)
}

public enum URLSessionDownloadTaskResponse {
    case success(URL?,URLResponse?)
    case failure(Error?)
}

public enum URLSessionUploadTaskResponse {
    case success(Data?,URLResponse?)
    case failure(Error?)
}

public extension Reactive where Base == URLSession {

    func dataTask(request: URLRequest) -> Observable<URLSessionTaskResponse> {
        Observable<URLSessionTaskResponse>.create { observer in
            let dataTask = self.base.dataTask(with: request) { (data, response, error) in
                self.taskHandler(observer: observer, data: data, response: response, error: error)
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
    
    func dataTask(url: URL) -> Observable<URLSessionTaskResponse> {
        Observable<URLSessionTaskResponse>.create { observer in
            let dataTask = self.base.dataTask(with: url) { (data, response, error) in
                self.taskHandler(observer: observer, data: data, response: response, error: error)
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
    
    fileprivate func taskHandler(observer: AnyObserver<URLSessionTaskResponse>, data: Data?, response: URLResponse?, error: Error?) {
           var res: URLSessionTaskResponse?
           if let data = data, let response = response {
               res = URLSessionTaskResponse.success(data, response)
           } else {
               res = URLSessionTaskResponse.failure(error)
           }
           if let r = res {
               observer.onNext(r)
           }
           observer.onCompleted()
       }
    
    func downloadTask(url: URL) -> Observable<URLSessionDownloadTaskResponse> {
        Observable<URLSessionDownloadTaskResponse>.create { observer in
            let dataTask = self.base.downloadTask(with: url) { (location, response, error) in
                self.downloadTaskHandler(observer: observer, location: location, response: response, error: error)
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
    
    func downloadTask(request: URLRequest) -> Observable<URLSessionDownloadTaskResponse> {
        Observable<URLSessionDownloadTaskResponse>.create { observer in
            let dataTask = self.base.downloadTask(with: request) { (location, response, error) in
                self.downloadTaskHandler(observer: observer, location: location, response: response, error: error)
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
    
    fileprivate func downloadTaskHandler(observer: AnyObserver<URLSessionDownloadTaskResponse>, location: URL?, response: URLResponse?, error: Error?) {
        var res: URLSessionDownloadTaskResponse?
        if let location = location, let response = response {
            res = URLSessionDownloadTaskResponse.success(location, response)
        } else {
            res = URLSessionDownloadTaskResponse.failure(error)
        }
        if let r = res {
            observer.onNext(r)
        }
        observer.onCompleted()
    }
    
    func uploadTask(request: URLRequest, data: Data?) -> Observable<URLSessionUploadTaskResponse> {
        Observable<URLSessionUploadTaskResponse>.create { observer in
            let dataTask = self.base.uploadTask(with: request, from: data) { (data, response, error) in
                self.uploadTaskHandler(observer: observer, data: data, response: response, error: error)
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
    
    func uploadTask(request: URLRequest, fileUrl: URL) -> Observable<URLSessionUploadTaskResponse> {
        Observable<URLSessionUploadTaskResponse>.create { observer in
            let dataTask = self.base.uploadTask(with: request, fromFile: fileUrl) { (data, response, error) in
                self.uploadTaskHandler(observer: observer, data: data, response: response, error: error)
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
    
    fileprivate func uploadTaskHandler(observer: AnyObserver<URLSessionUploadTaskResponse>, data: Data?, response: URLResponse?, error: Error?) {
        var res: URLSessionUploadTaskResponse?
        if let data = data, let response = response {
            res = URLSessionUploadTaskResponse.success(data, response)
        } else {
            res = URLSessionUploadTaskResponse.failure(error)
        }
        if let r = res {
            observer.onNext(r)
        }
        observer.onCompleted()
    }
    
}
