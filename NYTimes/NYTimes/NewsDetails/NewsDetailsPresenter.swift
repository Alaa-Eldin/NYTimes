import Foundation

class NewsDetailsPresenter {
    // MARK: - VIPER Stack
    weak var interactor: NewsDetailsPresenterToInteractorInterface!
    weak var view: NewsDetailsPresenterToViewInterface!
    weak var wireframe: NewsDetailsPresenterToWireframeInterface!

    // MARK: - Instance Variables
    var newsFeedInfo: NewsFeedData?
    weak var delegate: NewsDetailsDelegate?
    var moduleWireframe: NewsDetails {
        let wireframe = (self.wireframe as? NewsDetails)!
        return wireframe
    }
    // MARK: - Operational
}

// MARK: - Interactor to Presenter Interface
extension NewsDetailsPresenter: NewsDetailsInteractorToPresenterInterface {

}

// MARK: - View to Presenter Interface
extension NewsDetailsPresenter: NewsDetailsViewToPresenterInterface {
    func viewDidLoad() {
        guard newsFeedInfo != nil else {
            return
        }
        view.showNewsTitle(title: newsFeedInfo!.title)
        view.showNewsDetails(newsDetails: newsFeedInfo!.abstract)
        if let jumboImageURL = newsFeedInfo!.jumboImageURL {
            view.showNewsImageFrom(imageURL: jumboImageURL)
        }
    }
}

// MARK: - Wireframe to Presenter Interface
extension NewsDetailsPresenter: NewsDetailsWireframeToPresenterInterface {
}
