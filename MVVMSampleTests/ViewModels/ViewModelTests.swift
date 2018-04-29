import XCTest
@testable import MVVMSample

class ViewModelTests: XCTestCase {

    var viewModel: ViewModel!
    var dataManager: DataManagerSpy!
    
    override func setUp() {
        super.setUp()
        dataManager = DataManagerSpy()
        viewModel = ViewModel(dataManager: dataManager)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialState() {
        viewModel.initValues()
        XCTAssertEqual(viewModel.buttonText.value, "Fetch Data")
        XCTAssertFalse(viewModel.hasData.value)
        XCTAssertEqual(viewModel.numRows, 0)
    }
    
    func testFetchUsers() {
        setupUsers()
        viewModel.fetchUsers()
        
        XCTAssertEqual(viewModel.buttonText.value, "Reload Data")
        XCTAssertTrue(viewModel.hasData.value)
        XCTAssertEqual(viewModel.numRows, 2)
        
        XCTAssertEqual(viewModel.textFor(row: 0), "Bret (Leanne Graham)")
        XCTAssertEqual(viewModel.textFor(row: 1), "Antonette (Ervin Howell)")
    }
    
    private func setupUsers() {
        var users: [User] = []
        var address = Address(street: "Kulas Light", suite: "Apt. 556", city: "Gwenborough", zipcode: "92998-3874")
        var user = User(id: 1, name: "Leanne Graham", username: "Bret", email: "Sincere@april.biz", phone: "1-770-736-8031 x56442", address: address)
        users.append(user)
        
        address = Address(street: "Victor Plains", suite: "Suite 879", city: "Wisokyburgh", zipcode: "90566-7771")
        user = User(id: 2, name: "Ervin Howell", username: "Antonette", email: "Shanna@melissa.tv", phone: "010-692-6593 x09125", address: address)
        users.append(user)
        dataManager.users = users
    }
}
