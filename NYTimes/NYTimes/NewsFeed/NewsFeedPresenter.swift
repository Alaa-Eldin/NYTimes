import Foundation

class NewsFeedPresenter {
    // MARK: - VIPER Stack
    weak var interactor: NewsFeedPresenterToInteractorInterface!
    weak var view: NewsFeedPresenterToViewInterface!
    weak var wireframe: NewsFeedPresenterToWireframeInterface!

    // MARK: - Instance Variables
    weak var delegate: NewsFeedDelegate?
    var moduleWireframe: NewsFeed {
            let wireframe = (self.wireframe as? NewsFeed)!
            return wireframe
    }
    lazy var sections = {
        return NewsFeedSectionsManager().newsFeedSections
    }
    // MARK: - Operational
    func fetchNewsFeed() {
        let allSections = sections()?[0]
        if  allSections != nil {
            view.showLoadingIndicator()
            interactor.fetchNewsFeedForPeriod(period: .day, section: allSections!.key)
        }
    }
}

// MARK: - Interactor to Presenter Interface
extension NewsFeedPresenter: NewsFeedInteractorToPresenterInterface {
    func fetchNewsFailedWithError(fetchError: NewsFeedFetchError) {
        view.hideLoadingIndicator()
        var errorMessage = ""
        switch fetchError {
        case .badRequest, .parsing, .unexpected:
            errorMessage = "Something went wrong, please try again"
        case .noInternetConnection:
            errorMessage = "Please make sure you have good internet connection and try again"
        }
        view.showPopup(title: "Ops!", message: errorMessage, cancelTitle: "Ok") {
            //try to fetch again
            self.view.showLoadingIndicator()
            self.fetchNewsFeed()
        }
    }
    func fetchNewsSuccess(newsFeedEntity: NewsFeedEntity) {
        if let newsFeedData = newsFeedEntity.results {
            view.hideLoadingIndicator()
            view.showMostPopularNews(newsFeedData: newsFeedData)
        }
    }
}

// MARK: - View to Presenter Interface
extension NewsFeedPresenter: NewsFeedViewToPresenterInterface {
    func viewDidLoad() {
        fetchNewsFeed()
    }
    func newsFeedSelected(selectedNewsFeed: NewsFeedData) {
        wireframe.navigateToNewsDetails(newsFeedData: selectedNewsFeed)
    }
}
// MARK: - Wireframe to Presenter Interface
extension NewsFeedPresenter: NewsFeedWireframeToPresenterInterface {
        func set(delegate newDelegate: NewsFeedDelegate?) {
                delegate = newDelegate
        }
}
