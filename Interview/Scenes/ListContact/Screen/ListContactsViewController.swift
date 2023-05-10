import UIKit

final class ListContactsViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: ListContactsViewModel
//    var alert: Alert?
    
    // MARK: - Elements
    private lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 120
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    init(viewModel: ListContactsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCile
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewCode()
        makeBiding()
    }

    // MARK: - Methods
    private func makeBiding() {
        viewModel.fetchData()
        viewModel.reloadData = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - ViewCodeImplementation
extension ListContactsViewController: ViewCodeProtocol {
    func buildHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    func applyAdditionalChanges() {
        view.backgroundColor = .white
        navigationItem.title = "Lista de contatos"
    }
}

extension ListContactsViewController: ListContactsViewModelProtocol {
    func setupOnErrorReceived() {
        viewModel.showServiceError = { [weak self] error in
            guard let self else { return }
            DispatchQueue.main.async {
                self.showAlert(
                    title: "Ops, ocorreu um erro",
                    message: "\(String(describing: error?.localizedDescription))"
                )
            }
        }
    }
}

// MARK: - UITableViewDataSourceProtocol
extension ListContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.showCounter()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.setupCell(from: .init(model: viewModel.getContactBased(on: indexPath)))
        return cell
    }
}

// MARK: - UITableViewDelegateProtocol
extension ListContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isLegacy = viewModel.isLegacy(indexPath: indexPath)
        
        showAlert(
            title: isLegacy ? "Atenção" : "Você tocou em",
            message: isLegacy ? "Você tocou no contato sorteado" : viewModel.getContactBased(on: indexPath).name
        )
    }
}

extension ListContactsViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(addAction)
        self.present(alertController, animated: true)
    }
}
