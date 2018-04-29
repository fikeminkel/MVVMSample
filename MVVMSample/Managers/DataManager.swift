import UIKit

protocol DataManager {
    typealias UsersHandler = ([User]?) -> ()
    func getUsers(handler: @escaping UsersHandler)
}

class DataManagerImpl: DataManager {
    private let apiManager: APIManager
    
    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }

    func getUsers(handler: @escaping UsersHandler) {
        apiManager.getUsers { result in
            guard let data = result else {
                handler(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let users = try decoder.decode([User].self, from: data)
                // TODO: write users to local data store
                handler(users)
            } catch let error as NSError {
                print("Error fetching users: \(error)")
                handler(nil)
            }
        }
    }
}
