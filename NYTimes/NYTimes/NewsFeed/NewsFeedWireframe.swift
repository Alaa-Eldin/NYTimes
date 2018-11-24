import UIKit

class NewsFeedWireframe {
    // MARK: - VIPER Stack
    lazy var moduleInteractor = NewsFeedInteractor()

    lazy var moduleNavigationController: UINavigationController = {
            let storyboard = NewsFeedWireframe.storyboard()
            let navigationController = (storyboard.instantiateViewController(withIdentifier:
                NewsFeedConstants.navigationControllerIdentifier) as? UINavigationController)!
            return navigationController
    }()
    lazy var modulePresenter = NewsFeedPresenter()
    lazy var moduleView: NewsFeedView = {
            let view = self.moduleNavigationController.viewControllers[0] as? NewsFeedView
            return view!
    }()

    // MARK: - Computed VIPER Variables
    lazy var presenter: NewsFeedWireframeToPresenterInterface = self.modulePresenter
    lazy var view: NewsFeedNavigationInterface = self.moduleView

    // MARK: - Instance Variables
    var newsDetailsWireframe: NewsDetailsWireframe?
    // MARK: - Initialization
    init() {
        let interactor = moduleInteractor
        let presenter = modulePresenter
        let view = moduleView

        interactor.presenter = presenter

        presenter.interactor = interactor
        presenter.view = view
        presenter.wireframe = self

        view.presenter = presenter
    }

    class func storyboard() -> UIStoryboard {
            return UIStoryboard(name: NewsFeedConstants.storyboardIdentifier,
                                bundle: Bundle(for: NewsFeedWireframe.self))
    }

    // MARK: - Operational

}

// MARK: - Module Interface
extension NewsFeedWireframe: NewsFeed {
}

// MARK: - Presenter to Wireframe Interface
extension NewsFeedWireframe: NewsFeedPresenterToWireframeInterface {
    func navigateToNewsDetails(newsFeedData: NewsFeedData) {
        if newsDetailsWireframe != nil {
            newsDetailsWireframe = nil
        }
        newsDetailsWireframe = NewsDetailsWireframe(newsFeedInfo: newsFeedData)
        moduleView.navigationController?.pushViewController(newsDetailsWireframe!.moduleView, animated: true)
    }
}
