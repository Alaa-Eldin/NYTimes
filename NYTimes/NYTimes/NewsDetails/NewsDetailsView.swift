import UIKit

class NewsDetailsView: UIViewController {
        // MARK: - VIPER Stack
        weak var presenter: NewsDetailsViewToPresenterInterface!

        // MARK: - Instance Variables

        // MARK: - Outlets

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsUpdateDateLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDetailsTextView: UITextView!
    // MARK: - Operational
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - Navigation Interface
extension NewsDetailsView: NewsDetailsNavigationInterface { }

// MARK: - Presenter to View Interface
extension NewsDetailsView: NewsDetailsPresenterToViewInterface {
    func showNewsImageFrom(imageURL: String) {
        newsImageView.loadImageUsingCache(withUrl: imageURL)
    }
    func showNewsTitle(title: String) {
        newsTitleLabel.text = title
    }
    func showNewsDetails(newsDetails: String) {
        newsDetailsTextView.text = newsDetails
    }
}
