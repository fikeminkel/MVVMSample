import UIKit
@testable import MVVMSample

class DataManagerSpy: DataManager {
    var users: [User]?
    
    func getUsers(handler: @escaping UsersHandler) {
        handler(users)
    }
}
