//
//  ViewController.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 19/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class NewsFeed_VC: UIViewController {
    
    let tableView_newsFeed = UITableView()
    
    var articles : [Article]    = []
    var tappedIndex             = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()

        ConfigureTableView()
        GetNewsFeed()
    }
    
    func ConfigureTableView(){
        tableView_newsFeed.frame = view.bounds
        tableView_newsFeed.register(NewsCells.self, forCellReuseIdentifier: NewsCells.cellID)
        tableView_newsFeed.dataSource = self
        tableView_newsFeed.delegate = self
        tableView_newsFeed.allowsSelection = false
        view.addSubview(tableView_newsFeed)
    }
    
    func GetNewsFeed(){
        NetworkManager.shared.GetNewsFeed(language: "en", page: 1) { [weak self] (feed, errorMessage) in
            guard let self = self else { return }
            guard let feed = feed else {
                print(errorMessage!)
                return
            }
            
            for article in feed.articles {
                self.articles.append(article)
            }
            
            DispatchQueue.main.async {
                self.tableView_newsFeed.reloadData()
            }
        }
    }
}

extension NewsFeed_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCells.cellID) as! NewsCells
        cell.delegate = self
        cell.currentIndex = indexPath.row
        if tappedIndex.contains(indexPath.row) {
            cell.isTappedReadMore = true
        } else {cell.isTappedReadMore = false }
        let article = articles[indexPath.row]
        cell.Set(article: article)
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let thisCell = tableView.cellForRow(at: indexPath)
        //let thisHeight = thisCell?.bounds.height
        //print("\(String(describing: thisHeight))")
        
        let currentImage = Images.img_1
        let imgHeight = CalculateImageHeight(image: currentImage!)
        
        var labelHeight : Int!
        if tappedIndex.contains(indexPath.row) {
            labelHeight = (TotalNumberOfLines(text: articles[indexPath.row].content) * 20)
        } else {
            if TotalNumberOfLines(text: articles[indexPath.row].content) > 1 {
                labelHeight = 40
            } else {
                labelHeight = 20
            }
        }
        
        return 20 + 44 + 10 + 20 + 10 + imgHeight + 10 + CGFloat(labelHeight) + 16 + 10
    }
}

extension NewsFeed_VC : NewsCellDelegate {
    func ReadMoreTapped(isTapped: Bool, selectedIndex: Int) {
        if isTapped {
            tappedIndex.append(selectedIndex)
        } else {
            tappedIndex.removeAll(where: { $0 == selectedIndex })
        }
        tableView_newsFeed.beginUpdates()
        tableView_newsFeed.endUpdates()
        
    }
}

