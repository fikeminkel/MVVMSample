import UIKit

class ViewModel {
    
    let buttonText: Observable<String> = Observable("")
    let hasData: Observable<Bool> = Observable(false)
    
    var users: [User]?
    
    var numRows: Int {
        guard let users = users else { return 0 }
        return users.count
    }

    private let dataManager: DataManager
    
    init(dataManager: DataManager = DataManagerImpl()) {
        self.dataManager = dataManager
    }
    
    func initValues() {
        updateButtonText()
    }
    
    func fetchUsers() {
        users = nil
        self.updateHasData()
        dataManager.getUsers { users in
            self.users = users
            self.updateHasData()
            self.updateButtonText()
        }
    }
    
    func textFor(row: Int) -> String? {
        guard let users = users else { return "Something bad happened" }
        let user = users[row]
        return "\(user.username) (\(user.name))"
    }
    
    private func updateHasData() {
        if let users = users {
            hasData.value = !users.isEmpty
        } else {
            hasData.value = false
        }
    }
    
    private func updateButtonText() {
        buttonText.value = {
            if hasData.value {
                return "Reload Data"
            }
            return "Fetch Data"
        }()
    }
}
