import Foundation
import RxSwift

public extension Reactive where Base == URLSession {
    
    /**
    A task that retrieves the contents of the specified URLRequest
    - parameter request: URLRequest for URLSessionDataTask
    - returns: An instance of `Observable<Data?,URLResponse?,Error?>`
     */
    func dataTask(request: URLRequest) -> Observable<(Data: Data?, URLResponse: URLResponse?,Error: Error?)> {
        Observable<(Data: Data?, URLResponse: URLResponse?,Error: Error?)>.create { observer in
            let dataTask = self.base.dataTask(with: request) { (data, response, error) in
                observer.onNext((data,response,error))
                observer.onCompleted()
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }

    /**
    A task that retrieves the contents of the specified URLRequest
    - parameter request: URLRequest for URLSessionDataTask
    - parameter returnType: Return type for Data
    - returns: An instance of `Observable<T?,URLResponse?,Error?>`
    */
    func dataTask <T> (request: URLRequest, returnType: T.Type)-> Observable<(Data: T?, URLResponse: URLResponse?,Error: Error?)> where T:Decodable {
        Observable<(Data: T?, URLResponse: URLResponse?,Error: Error?)>.create { observer in
            let dataTask = self.base.dataTask(with: request) { (data, response, error) in
                var convData: T?
                if let d = data {
                    convData = try? JSONDecoder().decode(returnType, from: d)
                }
                observer.onNext((convData,response,error))
                observer.onCompleted()
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
        
    /**
    A task that retrieves the contents of the specified URL
    - parameter url: URL for URLSessionDataTask
    - returns: An instance of `Observable<Data?,URLResponse?,Error?>`
    */
    func dataTask(url: URL) -> Observable<(Data: Data?, URLResponse: URLResponse?,Error: Error?)> {
        Observable<(Data: Data?, URLResponse: URLResponse?,Error: Error?)>.create { observer in
            let dataTask = self.base.dataTask(with: url) { (data, response, error) in
                observer.onNext((data,response,error))
                observer.onCompleted()
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }

    /**
    A task that retrieves the contents of the specified URL
    - parameter url: URL for URLSessionDataTask
    - parameter returnType: Return type for Data
    - returns: An instance of `Observable<T?,URLResponse?,Error?>`
    */
    func dataTask <T> (url: URL, returnType: T.Type) -> Observable<(Data: T?, URLResponse: URLResponse?,Error: Error?)> where T:Decodable {
        Observable<(Data: T?, URLResponse: URLResponse?,Error: Error?)>.create { observer in
            let dataTask = self.base.dataTask(with: url) { (data, response, error) in
                var convData: T?
                if let d = data {
                    convData = try? JSONDecoder().decode(returnType, from: d)
                }
                observer.onNext((convData,response,error))
                observer.onCompleted()
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }

    /**
    Download task that retrieves the contents of the specified URL
    - parameter url: URL for URLSessionDataTask
    - returns: An instance of `Observable<URL?,URLResponse?,Error?>`
    */
    func downloadTask(url: URL) -> Observable<(URL: URL?, URLResponse: URLResponse?, Error: Error?)> {
        Observable<(URL: URL?, URLResponse: URLResponse?, Error: Error?)>.create { observer in
            let dataTask = self.base.downloadTask(with: url) { (location, response, error) in
                observer.onNext((location,response,error))
                observer.onCompleted()
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }

    /**
    Download task that retrieves the contents of the specified URLRequest
    - parameter request: URLRequest for URLSessionDataTask
    - returns: An instance of `Observable<URL?,URLResponse?,Error?>`
    */
    func downloadTask(request: URLRequest) -> Observable<(URL: URL?, URLResponse: URLResponse?, Error: Error?)> {
        Observable<(URL: URL?, URLResponse: URLResponse?, Error: Error?)>.create { observer in
            let dataTask = self.base.downloadTask(with: request) { (location, response, error) in
                observer.onNext((location, response, error))
                observer.onCompleted()
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }

    /**
    A task that performs an HTTP request for the specified URL request object, uploads the provided data
    - parameter request: URLRequest for URLSessionDataTask
    - parameter data: The body data for the request
    - returns: An instance of `Observable<Data?,URLResponse?,Error?>`
    */
    func uploadTask(request: URLRequest, data: Data?) -> Observable<(Data: Data?, URLResponse: URLResponse?, Error: Error?)> {
        Observable<(Data: Data?, URLResponse: URLResponse?, Error: Error?)>.create { observer in
            let dataTask = self.base.uploadTask(with: request, from: data) { (data, response, error) in
                observer.onNext((data, response, error))
                observer.onCompleted()
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }

    /**
    A task that performs an HTTP request for the specified URL request object, uploads the provided data
    - parameter request: URLRequest for URLSessionDataTask
    - parameter fileUrl: The URL of the file to upload.
    - returns: An instance of `Observable<Data?,URLResponse?,Error?>`
    */
    func uploadTask(request: URLRequest, fileUrl: URL) -> Observable<(Data: Data?, URLResponse: URLResponse?, Error: Error?)> {
        Observable<(Data: Data?, URLResponse: URLResponse?, Error: Error?)>.create { observer in
            let dataTask = self.base.uploadTask(with: request, fromFile: fileUrl) { (data, response, error) in
                observer.onNext((data, response, error))
                observer.onCompleted()
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
    
}
