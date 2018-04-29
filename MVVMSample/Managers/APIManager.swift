import Alamofire
import UIKit


class APIManager {
    static let kilobyte = 1024
    static let megabyte = kilobyte * 1024
    
    static let memoryCacheSize = 2 * megabyte
    static let diskCacheSize = 100 * megabyte
    static let timeoutInterval: TimeInterval = 30
    static let cache = URLCache(memoryCapacity: memoryCacheSize, diskCapacity: diskCacheSize, diskPath: nil)
    static let baseUrl = "https://jsonplaceholder.typicode.com"

    let sessionManager: SessionManager
    
    init(sessionManager: SessionManager = SessionManager()) {
        self.sessionManager = sessionManager
        URLCache.shared = APIManager.cache
        sessionManager.session.configuration.timeoutIntervalForRequest = APIManager.timeoutInterval
    }
    
    func getUsers(handler: @escaping (Data?) -> ()) {
        let url = "\(APIManager.baseUrl)/users"
        sessionManager.request(url).responseData { response in
            handler(response.result.value)
        }
    }
}
