//
//  ViewController.swift
//  Atlantis-Example
//
//  Created by Nghia Tran on 10/22/20.
//  Copyright © 2020 Nghia Tran. All rights reserved.
//

import UIKit


class ViewController: UIViewController, URLSessionDataDelegate {

    lazy var session: URLSession = {
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        return session
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func makeSimpleRequest() {
        let url = URL(string: "https://httpbin.org/post?name=proxyman&id=\(UUID().uuidString)&randon=\(Int.random(in: 0..<10000))")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "it's raw text".data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }

            if let response = response as? HTTPURLResponse {
                print(response)

                if let data = data {
                    print("------ Body")
                    let dict = try? JSONSerialization.jsonObject(with: data, options: [])
                    print(dict)
                }
            }
        }
        task.resume()
    }

    func makeRequestWithDelegate() {
        let url = URL(string: "https://httpbin.org/get?name=proxyman&id=\(UUID().uuidString)&randon=\(Int.random(in: 0..<10000))")!
        var request = URLRequest(url: url)
        request.addValue(UUID().uuidString, forHTTPHeaderField: "X-Proxyman-Example")
        let task = session.dataTask(with: request)
        task.resume()
    }

    @IBAction func sendMessageBtnOnTap(_ sender: Any) {
        makeSimpleRequest()
    }
    
    @IBAction func sendMessageByDeleteOnTap(_ sender: Any) {
        makeRequestWithDelegate()
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print("didReceive response \(response)")
        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {

    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
    }
}
