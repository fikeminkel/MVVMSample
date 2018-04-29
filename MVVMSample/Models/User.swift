import UIKit

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let address: Address
    
    init(id: Int, name: String, username: String, email: String, phone: String, address: Address) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.address = address
    }
}
