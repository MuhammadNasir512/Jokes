import Foundation

protocol APIHandlerType: AnyObject {
    func getData(completionHandler: @escaping (Result<Data, Error>) -> Void)
    init(urlString: String)
}

final class APIHandler: APIHandlerType {

    let urlString: String
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
