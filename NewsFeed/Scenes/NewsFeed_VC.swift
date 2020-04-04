//
//  ViewController.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 19/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class NewsFeed_VC: NF_DataloadingVC {
    
    let tableView_newsFeed = UITableView()
    
    var articles : [Article] = []
    var tappedIndex = [Int]()
    
    var page = 1
    var searchKeyword = ""
    var languageCode = "en"
    let laguageCodeList = ["ar", "de", "en", "es", "fr", "he", "it", "nl", "no", "pt", "ru", "se", "ud", "zh"]
    
    var hasMoreData = true
    var isLoadingMoreData = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        ConfigureViewController()
        ConfigureTableView()
        GetNewsFeed(keyword: searchKeyword, language: languageCode, page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    init(keyword: String) {
        super.init(nibName: nil, bundle: nil)
        self.searchKeyword = keyword
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ConfigureViewController(){
        view.backgroundColor = .systemBackground
        let languageSelectionButton = UIBarButtonItem(title: languageCode, style: .plain, target: self, action: #selector(Btn_SelectLanguage))
        navigationItem.rightBarButtonItem = languageSelectionButton
    }
    
    func ConfigureTableView(){
        tableView_newsFeed.frame = view.bounds
        tableView_newsFeed.register(NewsCells.self, forCellReuseIdentifier: NewsCells.cellID)
        tableView_newsFeed.dataSource = self
        tableView_newsFeed.delegate = self
        tableView_newsFeed.allowsSelection = false
        tableView_newsFeed.RemoveExcessCells()
        view.addSubview(tableView_newsFeed)
    }
     
    func GetNewsFeed(keyword: String, language: String, page: Int){
        ShowLoadingView()
        isLoadingMoreData = true
        
        NetworkManager.shared.GetNewsFeed(keyword: keyword, language: language, page: page) { [weak self] result in
            guard let self = self else { return }
            self.DismissLoadingView()
            
            switch result {
            case .success(let feed):
                if feed.articles.count < 10 {
                    self.hasMoreData = false
                }
                
                for article in feed.articles {
                    self.articles.append(article)
                }
                
                DispatchQueue.main.async {
                    self.navigationItem.title = "\(self.searchKeyword) (\(feed.totalResults))"
                    self.tableView_newsFeed.reloadData()
                }
                
            case .failure(let error):
                print(error.rawValue)
            }
            
            self.isLoadingMoreData = false
        }
    }
    
    @objc func Btn_SelectLanguage(){
        PresentSelectionScreen(title: "Select Language")
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
        var labelHeight : Int!
        
        if !(articles[indexPath.row].description!).isEmpty {
            if tappedIndex.contains(indexPath.row) {
                labelHeight = (Helper.TotalNumberOfLines(text: articles[indexPath.row].description!) * 20)
            } else {
                if Helper.TotalNumberOfLines(text: articles[indexPath.row].description!) > 1 {
                    labelHeight = 40
                } else {
                    labelHeight = 20
                }
            }
        } else {
            labelHeight = 0
        }
        
        
        return 20 + 44 + 10 + 20 + 10 + 200 + 10 + CGFloat(labelHeight) + 16 + 10
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > (contentHeight - screenHeight) {
            guard hasMoreData, !isLoadingMoreData else {
                return
            }
            page += 1
            GetNewsFeed(keyword: searchKeyword, language: languageCode, page: page)
        }
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
    
    func TitleTapped(selectedIndex: Int) {
        guard let url = URL(string: articles[selectedIndex].url) else { return }
        ShowSafariVC(with: url)
    }
}

