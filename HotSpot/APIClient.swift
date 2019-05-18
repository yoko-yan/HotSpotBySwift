import UIKit
import Alamofire

struct APIClient{
    
    static let manager = Alamofire.SessionManager.default
    
    static func request<T: RequestProtocol>(api: T, success: @escaping ([Photo]) -> Void, failure: @escaping () -> Void) {
        manager.request("https://omypcjxj6j.execute-api.us-east-2.amazonaws.com/default",
                        method: api.method,
                        parameters: api.parameters)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    do {
                        guard let data = response.data else { return }
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try decoder.decode([Photo].self, from: data)
                        success(result)
                    } catch {
                        print("suceess catch")
                        failure()
                    }
                case .failure(_):
                    print("failure")
                    failure()
                }
        }
    }
    
}
