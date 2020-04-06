//
//  ViewController.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 19/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

enum SelectionType {
    case language, date
}

enum CustomDateType {
    case fromDate, toDate
}

class NewsFeed_VC: NF_DataloadingVC {
    
    let tableView_newsFeed = UITableView()
    
    var articles : [Article] = []
    var tappedIndex = [Int]()
    
    var page = 1
    var searchKeyword = ""
    var languageCode : String!
    var fromDate = ""
    var toDate = ""
    
    var hasMoreData = true
    var isLoadingMoreData = false
    var isUpdateData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConfigureViewController()
        ConfigureTableView()
        GetNewsFeed(keyword: searchKeyword, page: page)
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
        let barTitleLanguage = PersistenceManager.RetrieveLanguage(type: .languageName)
        let barTitledate = "Date"
        let languageSelectionButton = UIBarButtonItem(title: barTitleLanguage, style: .plain, target: self, action: #selector(Btn_SelectLanguage))
        let dateButton = UIBarButtonItem(title: barTitledate, style: .plain, target: self, action: #selector(Btn_SelectLDate))
        navigationItem.rightBarButtonItems = [languageSelectionButton, dateButton]
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
    
    func GetNewsFeed(keyword: String, page: Int){
        languageCode = PersistenceManager.RetrieveLanguage(type: .languageCode)
        ShowLoadingView()
        isLoadingMoreData = true
        
        NetworkManager.shared.GetNewsFeed(keyword: keyword, language: languageCode, fromDate: fromDate, toDate: toDate, page: page) { [weak self] result in
            guard let self = self else { return }
            self.isUpdateData = false
            self.DismissLoadingView()
            
            switch result {
            case .success(let feed):
                if feed.articles.count == 0 {
                    let message = "No news to show. Please go back and try again with different keywords."
                    DispatchQueue.main.async {
                        self.ShowEmptyStateView(message: message, view: self.view)
                        return
                    }
                }
                
                if feed.articles.count < 10 { self.hasMoreData = false }
                for article in feed.articles { self.articles.append(article) }
                DispatchQueue.main.async {
                    self.navigationItem.title = "\(self.searchKeyword) (\(feed.totalResults))"
                    self.tableView_newsFeed.reloadData()
                }
                
            case .failure(let error):
                self.ShowAlertScreen(title: "Error", message: error.rawValue, buttonTitle: "OK", appUpdate: false)
            }
            
            self.isLoadingMoreData = false
        }
    }
    
    @objc func Btn_SelectLanguage(){
        ShowOptionSelectionVC(selectType: .language, title: "Select Language", optionList: Options.languageList, delegate: self)
    }
    
    @objc func Btn_SelectLDate(){
        ShowOptionSelectionVC(selectType: .date, title: "Select Date", optionList: Options.dateList, delegate: self)
    }
        
    func RefreshTableViewData(){
        isUpdateData = true
        tableView_newsFeed.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        articles.removeAll()
        tappedIndex.removeAll()
        page = 1
        GetNewsFeed(keyword: searchKeyword, page: page)
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
        if !isUpdateData {
            let article = articles[indexPath.row]
            cell.Set(article: article)
            cell.layoutIfNeeded()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var labelHeight = 0
        let imgHeight = 200
                
        if !isUpdateData {
            let str = articles[indexPath.row].description ?? ""
            if !str.isEmpty {
                if tappedIndex.contains(indexPath.row) {
                    labelHeight = (Helper.TotalNumberOfLines(text: str.removeSpecialCharacters) * 20)
                } else {
                    if Helper.TotalNumberOfLines(text: str.removeSpecialCharacters) > 1 {
                        labelHeight = 40
                    } else {
                        labelHeight = 20
                    }
                }
            }
        }
        
        return 20 + 44 + 10 + 20 + 10 + CGFloat(imgHeight) + 10 + CGFloat(labelHeight) + 16 + 10
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > (contentHeight - screenHeight) {
            guard hasMoreData, !isLoadingMoreData else { return }
            page += 1
            if toDate.isEmpty { fromDate = ""}
            GetNewsFeed(keyword: searchKeyword, page: page)
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
        guard let url = URL(string: articles[selectedIndex].url!) else {
            ShowAlertScreen(title: "Error", message: "Invalid link", buttonTitle: "OK", appUpdate: false)
            return
        }
        ShowSafariVC(with: url)
    }
}

extension NewsFeed_VC: SelectOptionDelegate {
    func SelectOptionResponse(type: SelectionType,selectedValue: String) {
        switch type {
        case .language:
            let ind = Options.languageList.firstIndex(of: selectedValue)
            let code = Options.languageCodeList[ind!]
            if languageCode == code { return } else {
                PersistenceManager.SaveLanguage(language: selectedValue, languageCode: code)
                navigationItem.rightBarButtonItems![0].title = PersistenceManager.RetrieveLanguage(type: .languageName)
            }
        case .date:
            let ind = Options.dateList.firstIndex(of: selectedValue)
            let days = Options.dateListCode[ind!]
            if days > 0 {
                navigationItem.rightBarButtonItems![1].title = selectedValue
                toDate = toDate.ConvertDays(from: 0)
                fromDate = fromDate.ConvertDays(from: days)
            } else if days == -1 {
                ShowDatePickerVC(dateType: .fromDate, title: "From Date", delegate: self)
                return
            } else {
                navigationItem.rightBarButtonItems![1].title = "Date"
                toDate = ""
                fromDate = ""
            }
        }
        RefreshTableViewData()
    }
}

extension NewsFeed_VC : DatePickerDelegate {
    func DateResponse(type: CustomDateType, date: Date) {
        switch type {
        case .fromDate:
            fromDate = date.ConvertToYearMonthFormat()
            ShowDatePickerVC(dateType: .toDate, title: "To Date", delegate: self)
        case .toDate:
            toDate = date.ConvertToYearMonthFormat()
            navigationItem.rightBarButtonItems![1].title = "Custom Date"
            RefreshTableViewData()
        }
    }
}

