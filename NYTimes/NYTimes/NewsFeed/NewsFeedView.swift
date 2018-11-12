import UIKit

class NewsFeedView: UIViewController {
    // MARK: - VIPER Stack
    weak var presenter: NewsFeedViewToPresenterInterface!

    // MARK: - Instance Variables

    // MARK: - Outlets

    // MARK: - Operational
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - Navigation Interface
extension NewsFeedView: NewsFeedNavigationInterface { }

// MARK: - Presenter to View Interface
extension NewsFeedView: NewsFeedPresenterToViewInterface {

}
