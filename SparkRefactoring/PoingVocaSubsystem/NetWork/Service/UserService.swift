//
//  UserService.swift
//  PoingVocaSubsystem
//
//  Created by Hanteo on 2021/01/29.
//

import Foundation
import Moya

enum UserService {
    case getUserInfo
    case signup(credential: String, name: String)
    case deleteUser
    case editUser(name: String, photo: Data?)
    case login(credential: String)
}

extension UserService: TargetType {
    var baseURL: URL {
        URL(string: ServerURL.base.rawValue)!
    }
    
    var path: String {
        switch self {
        case .getUSerInfo, .editUser, .deleteUser:
            return "/v1/users"
        case .login:
            return "/v1/users/login"
        case .signup:
            return "/v1/users/sign-up"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserInfo:
            return .get
        case .signup, .login:
            return .post
        case .deleteUser:
            return .delete
        case .editUser:
            return .patch
        }
    }
    
    var sampleData: Data {
        Data()
    }

    var task: Task {
        switch self {
        case .getUserInfo:
            return .requestPlain
        case .signup(let credential, let name):
            let param: [String : Any] = [
                "credential": credential,
                "name": name
            ]
            return .requestParameters(parameters: param, encoding: JsonEncoding.default)
        case .deleteUser:
            return .requestPlain
        case .editUser(let name, let photo):
            var formData = [MultipartFormData]()
            if let photo = photo {
                formData.append(MultipartFormData(provider: .data(photo), name: "photo", fileName: "\(name).jpg", mimeType: "image/jpg"))
            }
            formData.append(MultipartFormData(provider: .data(name.data(using: .utf8)!), name: "name"))
            
            return .uploadMultipart(formData)
        case .login(let credential):
            let param: [String : Any] = [
                "credential": credential
            ]
            return .requestParameters(parameters: param, encoding: JsonEncoding.default)
        }
    }

    var headers: [String : String]? {
        nil
    }
    
    
}
/// Json encoding을 위해서 아래의 인코딩을 사용할것
struct JsonEncoding: Moya.ParameterEncoding {

    public static var `default`: JsonEncoding { return JsonEncoding() }


    /// Creates a URL request by encoding parameters and applying them onto an existing request.
    ///
    /// - parameter urlRequest: The request to have parameters applied.
    /// - parameter parameters: The parameters to apply.
    ///
    /// - throws: An `AFError.parameterEncodingFailed` error if encoding fails.
    ///
    /// - returns: The encoded request.
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var req = try urlRequest.asURLRequest()
        let json = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
        req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        req.httpBody = json
        return req
    }

}
