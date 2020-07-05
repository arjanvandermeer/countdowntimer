import Foundation

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}

let group = DispatchGroup()
group.enter()

let url = URL(string:"http://www.americanexpress.com/")!
print ("Loading \(url)")

let req = URLRequest.init(url: url)
let task  = URLSession.shared.dataTask(with: req) {(data, response, error) in
    if let error = error {
         // Handle Error
        print("Error : \(error)")
        group.leave()
         return
     }
    guard let httpResponse = response as? HTTPURLResponse else {
        print("Error : Not a valid HTTP Response")
        group.leave()
         return
    }
    let statusCode = httpResponse.statusCode
    print ("status : \(statusCode)")
    if statusCode == 200 {
        print("OK!!!")
    }
    if let data = String(data:data!, encoding: .utf8) {
        print ("data received: \(data.count/1024) Kb")
    }
    httpResponse.allHeaderFields.forEach { (arg0) in
       let (key, value) = arg0
          print("\(key): \(value)")
    }
    group.leave()
}
task.resume()
group.wait()
