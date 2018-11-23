import Foundation

enum NewsPeriod: String {
    case day = "1"
    case week = "7"
    case month = "30"
}

enum NewsFeedFetchError {
    case unexpected
    case parsing
    case badRequest
    case noInternetConnection
}

class NewsFeedInteractor {
    // MARK: - VIPER Stack
    weak var presenter: NewsFeedInteractorToPresenterInterface!

    // MARK: - Instance Variables

    // MARK: - Operational

}

// MARK: - Presenter To Interactor Interface
extension NewsFeedInteractor: NewsFeedPresenterToInteractorInterface {
    func fetchNewsFeedForPeriod(period: NewsPeriod, section: String) {
        guard let gitUrl = URL(string: APIsURLs.NYTimesAPIBaseURL +
            section + "/" + period.rawValue + ".json?" + APIsParamaeters.NYTimesAPIKey +
            "=" + APIsParamaeters.NYTimesAPIValue) else {
                self.presenter.fetchNewsFailedWithError(fetchError: .unexpected)
                return
        }
        let request = NSMutableURLRequest(url: gitUrl)
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //use shared sesiion as it is a simple web service calling with default configuratins
        _ = session.dataTask(with: request as URLRequest) { data, response, error in
            if let error = error as NSError?, error.domain == NSURLErrorDomain &&
                error.code == NSURLErrorNotConnectedToInternet {
                DispatchQueue.main.async {//call main thread to handle response
                    self.presenter.fetchNewsFailedWithError(fetchError: .noInternetConnection)
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {//call main thread to handle response
                    self.presenter.fetchNewsFailedWithError(fetchError: .unexpected)
                }
                return
            }
            do {//try to parse the response
                let newsFeedEntity = try JSONDecoder().decode(NewsFeedEntity.self, from: data)
                guard let httpURLResponse =  response as? HTTPURLResponse else {
                    self.presenter.fetchNewsFailedWithError(fetchError: .badRequest)
                    return
                }
                if httpURLResponse.statusCode == 200 {
                    DispatchQueue.main.async {//call main thread to handle response
                        self.presenter.fetchNewsSuccess(newsFeedEntity: newsFeedEntity)
                    }
                } else {
                    DispatchQueue.main.async {//call main thread to handle response
                        self.presenter.fetchNewsFailedWithError(fetchError: .badRequest)
                    }
                }
            } catch let err {//This is where we catch the parsing error
                DispatchQueue.main.async { //call main thread to handle response
                    self.presenter.fetchNewsFailedWithError(fetchError: .parsing)
                }
                print("Err", err)
            }
        }.resume()
    }
}
