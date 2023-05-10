import UIKit

final class ContactCell: UITableViewCell {
    // MARK: - Properties
    static let identifier: String = ContactCell.self.description()
    
    // MARK: UI Components
    private lazy var contactImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyViewCode()
    }
    
    override func prepareForReuse() {
        fullnameLabel.text = nil
        contactImage.image = nil
    }
    
    required init?(coder: NSCoder) { nil }
}

extension ContactCell {
    func setupCell(from viewModel: ContactCellViewModel) {
        fullnameLabel.text = viewModel.showName()
        DispatchQueue.global().async {
            // TODO: - Usar guard let
            if let photo = viewModel.showPhotoURL() {
                do {
                    let data = try Data(contentsOf: photo)
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.contactImage.image = image
                    }
                } catch _ { }
            }
        }
    }
}

extension ContactCell: ViewCodeProtocol {
    func buildHierarchy() {
        contentView.addSubview(contactImage)
        contentView.addSubview(fullnameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contactImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contactImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contactImage.heightAnchor.constraint(equalToConstant: 100),
            contactImage.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            fullnameLabel.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: 16),
            fullnameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            fullnameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            fullnameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
