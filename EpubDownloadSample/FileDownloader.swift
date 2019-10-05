//
//  FileDownloader.swift
//  EpubDownloadSample
//
//  Created by kazuki.morita on 2019/10/05.
//

import Foundation
import Alamofire

class FileDownloader {
    
    static func download(url: URL, completion: @escaping (URL?, Error?) -> Void) {
        let filename = url.lastPathComponent
        let documentsURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(filename)

        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        Alamofire.download(url, to: destination).response { response in
            if let error = response.error {
                completion(nil, error)
                return
            }

            if FileManager.default.fileExists(atPath: fileURL.path) {
                completion(fileURL, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
}
