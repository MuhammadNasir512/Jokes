import Foundation

protocol APIHandlerType: AnyObject {
    func getData(completionHandler: @escaping (Result<Data, Error>) -> Void)
    var urlString: String { get set }
    init(urlString: String)
}

final class APIHandler: APIHandlerType {

    var urlString: String
    init(urlString: String = "http://api.icndb.com/jokes/random/12?exclude=[explicit]") {
        self.urlString = urlString
    }

    func getData(completionHandler: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "URLError", code: 99, userInfo: nil) as Error
            completionHandler(.failure(error))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let error = error else {
                    let dataToSend = data ?? Data()
                    completionHandler(.success(dataToSend))
                    return
                }
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
}

extension APIHandlerType {
    
    func setCustomResultCount(_ count: Int) {
        let format = "http://api.icndb.com/jokes/random/%d?exclude=[explicit]"
        urlString = String(format: format, count)
    }
}
