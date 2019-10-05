//
//  ViewController.swift
//  EpubDownloadSample
//
//  Created by kazuki.morita on 2019/10/05.
//  Copyright © 2019 kz_morita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var fileResources: [FileResource] = []
    private var documentController: UIDocumentInteractionController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Download from epub samples.
        // http://www.ideal-group.org/cris-archives/sample_epub3_ebooks.htm
        fileResources.append(FileResource(title: "famouspaintings.epub",
                                          url: URL(string: "http://files.infogridpacific.com/epub3/famouspaintings.epub")!))
        fileResources.append(FileResource(title: "igpn-28languages-01-EPUB3.epub",
                                          url: URL(string: "http://files.infogridpacific.com/epub3/igpn-28languages-01-EPUB3.epub")!))
        fileResources.append(FileResource(title: "AChristmasCarolAudioBook.epub",
                                          url: URL(string: "http://files.infogridpacific.com/epub3/AChristmasCarolAudioBook.epub")!))
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileResources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "file_resource_cell", for: indexPath)
        cell.textLabel?.text = fileResources[indexPath.row].title
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        Loader.show()
        FileDownloader.download(url: fileResources[indexPath.row].url) { [weak self] downloadUrl, error in
            guard let strongSelf = self else { return }
            
            Loader.hide()
            
            if let error = error {
                print("### Error Occured!!! \(error.localizedDescription))")
                return
            }

            guard let downloadUrl = downloadUrl else {
                print("### File not Downloaded!!!")
                return
            }
            
            strongSelf.documentController = UIDocumentInteractionController(url: downloadUrl)
            strongSelf.documentController?.presentOpenInMenu(from: strongSelf.view.frame, in: strongSelf.view, animated: true)
        }
    }
}
