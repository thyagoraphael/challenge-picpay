import Foundation

protocol ListContactsViewModelProtocol: AnyObject {
    func setupOnErrorReceived()
}

final class ListContactsViewModel {
    var model: [ContactModel]
    private let service: ListContactService
    
    var reloadData: (() -> Void)?
    var showServiceError: ((Error?) -> Void)?
    
    init(model: [ContactModel] = [], service: ListContactService = ListContactService()) {
        self.model = model
        self.service = service
    }
    
    func fetchData() {
        service.fetchContacts { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let model):
                self.model.append(contentsOf: model)
                self.reloadData?()
            case .failure(let error):
                self.showServiceError?(error)
            }
        }
    }
    
    func getContactBased(on index: IndexPath) -> ContactModel {
        return model[index.row]
    }
    
    func showCounter() -> Int {
        return model.count
    }
    
    func isLegacy(indexPath: IndexPath) -> Bool {
        UserIdsLegacy.isLegacy(id: model[indexPath.row].id)
    }
}
