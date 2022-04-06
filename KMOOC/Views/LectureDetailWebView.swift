//
//  LectureDetailWebView.swift
//  KMOOC
//
//  Created by MacBook on 2022/04/06.
//

import Foundation
import SwiftUI
import WebKit

struct LectureDetailWebView: UIViewRepresentable {
    let htmlStringToLoad: String
    @Binding var webViewHeight: CGFloat
    
    func makeUIView(context: Context) -> some UIView {
        print(htmlStringToLoad)
        let webView = WKWebView()
        webView.loadHTMLString(htmlStringToLoad.replacingOccurrences(of: "height=\"100%\"", with: "height=\"500px\""), baseURL: nil)
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = context.coordinator
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: LectureDetailWebView
        
        init(_ webView: LectureDetailWebView) {
            self.parent = webView
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            DispatchQueue.main.async {
//                self.parent.webViewHeight = webView.scrollView.contentSize.height
//            }
            webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
                DispatchQueue.main.async {
                    self.parent.webViewHeight = height as! CGFloat
                }
            })
        }
    }
}
