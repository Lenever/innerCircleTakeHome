import UIKit

struct GifAPIClient {
    // TODO: Implement
    var urlSession = URLSession.shared
    var baseUrl = "https://api.giphy.com/v1/gifs"
    
    enum HttpMethodType: String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
        case put = "PUT"
    }
    
    enum EndPointType {
        case gifId(String)
        case trending, search
        
        var value: String {
            switch self {
            case .trending:
                return "trending"
            case .search:
                return "search"
            case .gifId(let id):
                return id
            }
        }
    }
    
    func request <ResponseBody: Decodable> (requestType: HttpMethodType = .get, endpointType: EndPointType, params: [String: Any] = [:], success: @escaping (ResponseBody) -> (), failure: @escaping (String) -> ()) {
        
        var components = URLComponents(string: "\(baseUrl)/\(endpointType.value)")!
        
        var parameters = params
        
        parameters["api_key"] = Constants.giphyApiKey
        
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value as? String)
        }
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        var request = URLRequest(url: components.url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = requestType.rawValue
        
        let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                failure(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      print("Error with the response, unexpected status code: \(response ?? URLResponse())")
                      return
                  }
            
            if let data = data,
               let result = try? JSONDecoder().decode(ResponseBody.self, from: data) {
                success(result)
            }
        })
        task.resume()
    }
}
