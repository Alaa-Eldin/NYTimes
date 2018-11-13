import Foundation

class NewsFeedPresenter {
    // MARK: - VIPER Stack
    weak var interactor: NewsFeedPresenterToInteractorInterface!
    weak var view: NewsFeedPresenterToViewInterface!
    weak var wireframe: NewsFeedPresenterToWireframeInterface!

    // MARK: - Instance Variables
    weak var delegate: NewsFeedDelegate?
    var moduleWireframe: NewsFeed {
            get {
                    let mw = (self.wireframe as? NewsFeed)!
                    return mw
            }
    }
    
    lazy var sections = {
        return NewsFeedSectionsManager().newsFeedSections
    }
    
    // MARK: - Operational
    func fetchNewsFeed(){
        let allSections = sections()?[0]
        if let _ = allSections {
            interactor.fetchNewsFeedForPeriod(period: .Day, section: allSections!.key)
        }
    }
}

// MARK: - Interactor to Presenter Interface
extension NewsFeedPresenter: NewsFeedInteractorToPresenterInterface {
    func fetchNewsFailedWithError(fetchError: NewsFeedFetchError) {
        view.showPopup(title: "Ops!", message: "Something went wrong, please try again", cancelTitle: "Ok") {
            //try to fetch again
            self.fetchNewsFeed()
        }
    }
    
    func fetchNewsSuccess(newsFeedEntity: NewsFeedEntity) {
        if let newsFeedData = newsFeedEntity.results {
            view.showMostPopularNews(_newsFeedData:newsFeedData)
        }
    }
}

// MARK: - View to Presenter Interface
extension NewsFeedPresenter: NewsFeedViewToPresenterInterface {
    func viewDidLoad(){
        fetchNewsFeed()
    }
    
    func newsFeedSelected(selectedNewsFeed:NewsFeedData){
        wireframe.navigateToNewsDetails(newsFeedData: selectedNewsFeed)
    }
}


// MARK: - Wireframe to Presenter Interface
extension NewsFeedPresenter: NewsFeedWireframeToPresenterInterface {
        func set(delegate newDelegate: NewsFeedDelegate?) {
                delegate = newDelegate
        }
}
