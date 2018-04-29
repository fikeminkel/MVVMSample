import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ViewModel? {
        didSet {
            setupObservers()
        }
    }
    
    override func viewDidLoad() {
        print("viewDidLoad()")
        super.viewDidLoad()
        setupViews()
        guard let viewModel = viewModel else { return }
        viewModel.initValues()
    }

    private func setupObservers() {
        guard let viewModel = viewModel else { return }
        viewModel.buttonText.bind { buttonText in
            self.button.setTitle(buttonText, for: UIControlState.normal)
        }
        viewModel.hasData.bind { hasData in
            print("hasData: \(hasData)")
            self.tableView.reloadData()
        }
    }
    
    private func setupViews() {
        button.addTarget(self, action: .fetchUsersButtonSelector, for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc fileprivate func buttonTapped(_ sender: AnyObject?) {
        guard let viewModel = viewModel else { return }
        viewModel.fetchUsers()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numRows
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        guard let viewModel = viewModel else { return tableViewCell }
        tableViewCell.textLabel?.text = viewModel.textFor(row: indexPath.row)
        return tableViewCell
    }
}


private extension Selector {
    static let fetchUsersButtonSelector = #selector(ViewController.buttonTapped(_:))
}
