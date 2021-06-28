//
//  Network.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import Alamofire
import SwiftyJSON

class Network
{
    class var base_url: String { return "https://api.themoviedb.org/3" }
    
    class func request(_ service: Services, completion: @escaping (_ data: Data?, _ error: String?) -> ()) {
        AF.request(base_url + service.path, method: service.method, parameters: service.parameter, encoding: URLEncoding.httpBody, headers: service.header)
            .responseJSON { res in
                printResponse(service, res)
                switch res.result {
                case .success:
                    completion(res.data, nil)
                case .failure(let error):
                    let e = error.localizedDescription
                    completion(nil, e)
                }
        }
    }
    
    class func printResponse(_ service: Services, _ response: AFDataResponse<Any>) {
        #if DEBUG
        if let d = response.data, let json = try? JSON(data: d) {
            printRequest(service)
            print(json)
        } else {
            debugPrint(response)
        }
        #endif
    }
    
    class func printRequest(_ sercive: Services) {
        print(base_url + sercive.path)
    }
}
