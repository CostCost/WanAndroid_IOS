//
//  HttpUtils.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/4/2.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

enum MethodType {
    case get
    case post
}

class HttpUtils {

    class func requestData<T: HandyJSON> (
        url : String,
        type : MethodType,
        params : [String: Any]? = nil,
        callBack : @escaping (_ result : T?) -> ()
    ) {
        let method =  type == .get ? HTTPMethod.get :HTTPMethod.post
//        let headers: HTTPHeaders = [
//            "Cookie": ""
//        ]
        print("请求URL-----\(baseUrl+url)")
        // TODO: 这个请求框架能否对请求链路做处理？
        Alamofire.request(
            baseUrl+url,
            method: method,
            parameters: params,
            encoding: URLEncoding.default,
            headers: nil
        ).responseJSON {(response) in
            // TODO: 相应所处的线程是什么？是如何决定的？能否修改？
            // 1。校验结果 response.result.isSuccess
            guard let result = response.result.value else {
                callBack(nil)
                print("请求失败\(response.result.error)")
                return
            }
            //2.结果回调回去
            //                callBack(result)
            let model = JSONDeserializer<BaseResponse<T>>.deserializeFrom(dict: result as? [String : Any])
            callBack(model?.data)
            print("请求成功-----\(String(describing: response.request?.url))")
            //print(response.result.value)
            MyLog(log: response.result.value)
        }
    }
    
    // TODO: 写了两个方法，其实只是返回的数据结构有不同
    class func requestDataArray<T: HandyJSON> (
        url: String,
        type: MethodType,
        params: [String: Any]? = nil,
       callBack: @escaping (_ result : [T]?) -> ()
    ) {
        let method = type == .get ? HTTPMethod.get :HTTPMethod.post
//        let headers: HTTPHeaders = [
//            "Cookie": ""
//        ]
        print("请求URL-----\(baseUrl+url)")
        Alamofire.request(
            baseUrl+url,
            method: method,
            parameters: params,
            encoding: URLEncoding.default,
            headers: nil
        ).responseJSON {(response) in
            //1。校验结果 response.result.isSuccess
            guard let result = response.result.value else {
                callBack(nil)
                print("请求失败\(response.result.error)")
                return
            }
            //2.结果回调回去
            //                callBack(result)
            let model = JSONDeserializer<BaseResponseArray<T>>.deserializeFrom(dict: result as? [String : Any])
            callBack(model?.data)
            print("请求成功-----\(response.request?.url)")
            //print(response.result.value)
            MyLog(log: response.result.value)
        }
    }
}
