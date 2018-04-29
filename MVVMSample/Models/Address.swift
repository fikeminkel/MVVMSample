import UIKit

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    
    init(street: String, suite: String, city: String, zipcode: String) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
    }
}
