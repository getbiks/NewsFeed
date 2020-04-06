//
//  NF_NewsCells.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 20/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

protocol NewsCellDelegate {
    func ReadMoreTapped(isTapped: Bool,selectedIndex : Int)
    func TitleTapped(selectedIndex : Int)
}

class NewsCells: UITableViewCell {
    
    static let cellID = "NewsCell"
    
    let label_title         = NF_Label_Title(fontSize: 20, fontWeight: .medium, lines: 2, textAlignment: .left)
    let label_author        = NF_Label_Title(fontSize: 16, fontWeight: .light, lines: 1, textAlignment: .left)
    let label_published     = NF_Label_Title(fontSize: 16, fontWeight: .light, lines: 1, textAlignment: .right)
    let label_description   = NF_Label_Body(fontSize: 16, fontWeight: .regular, textAlignment: .left)
    let button_readMore     = NF_Button_ReadMore(title: "ReadMore", fontSize: 12)
    let imageView_image     = NF_ImageView(frame: .zero)
    
    var delegate            : NewsCellDelegate?
    var currentIndex        : Int!
    var isTappedReadMore    : Bool!
    var totalNumOfLines     : Int!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        Configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func Set(article: Article){
        label_author.text       = article.author ?? "Author not available"
        label_title.text        = article.title ?? "Title not available"
        label_published.text    = article.publishedAt!.ConvertToDisplayFormat()
        label_description.text  = article.description ?? ""
        let imgUrl = article.urlToImage ?? ""
        if !imgUrl.isEmpty {
            NetworkManager.shared.DownloadImage(urlString: imgUrl, hashString: label_title.text!) { [weak self] image in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.imageView_image.image = image
                }
            }
        }
        totalNumOfLines = Helper.TotalNumberOfLines(text: label_description.text!.removeSpecialCharacters)
        ConfigureDescriptionHeight()
    }
    
    @objc func Btn_ReadMoreTapped() {
        isTappedReadMore.toggle()
        AdjustButtonTitleAndLines()
        delegate?.ReadMoreTapped(isTapped: isTappedReadMore, selectedIndex: currentIndex)
    }
    
    @objc func Btn_Title() {
        delegate?.TitleTapped(selectedIndex: currentIndex)
    }
    
    private func ConfigureDescriptionHeight() {
        button_readMore.isHidden = true
        if totalNumOfLines == 1 {
            label_description.numberOfLines = 1
        } else if totalNumOfLines == 2 {
            label_description.numberOfLines = 2
        } else if totalNumOfLines > 2 {
            AdjustButtonTitleAndLines()
        } else {
            label_description.numberOfLines = 1
        }
    }
    
    private func AdjustButtonTitleAndLines(){
        button_readMore.isHidden = false
        if isTappedReadMore {
            label_description.numberOfLines = 0
            button_readMore.setTitle("ReadLess", for: .normal)
        } else {
            label_description.numberOfLines = 2
            button_readMore.setTitle("ReadMore", for: .normal)
        }
    }
    
    private func Configure(){
        AddSubViews(label_title, label_author, label_published, label_description, button_readMore, imageView_image)
        
        button_readMore.addTarget(self, action: #selector(Btn_ReadMoreTapped), for: .touchUpInside)
        
        label_title.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(Btn_Title))
        label_title.addGestureRecognizer(tap)
        
        let topPadding  : CGFloat = 10
        let sidePadding : CGFloat = 20
        
        NSLayoutConstraint.activate([
            label_title.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: topPadding*2),
            label_title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding),
            label_title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
            label_title.heightAnchor.constraint(equalToConstant: 44),
            
            label_author.topAnchor.constraint(equalTo: label_title.bottomAnchor, constant: topPadding),
            label_author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding),
            label_author.trailingAnchor.constraint(equalTo: label_published.leadingAnchor, constant: -sidePadding),
            label_author.heightAnchor.constraint(equalToConstant: 20),
            
            label_published.centerYAnchor.constraint(equalTo: label_author.centerYAnchor),
            label_published.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
            label_published.widthAnchor.constraint(equalToConstant: 120),
            label_published.heightAnchor.constraint(equalToConstant: 20),
            
            imageView_image.topAnchor.constraint(equalTo: label_author.bottomAnchor, constant: topPadding),
            imageView_image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding),
            imageView_image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
            imageView_image.heightAnchor.constraint(equalToConstant: 200),

            button_readMore.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -topPadding),
            button_readMore.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding),
            button_readMore.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
            button_readMore.heightAnchor.constraint(equalToConstant: 16),

            label_description.topAnchor.constraint(equalTo: imageView_image.bottomAnchor, constant: topPadding),
            label_description.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding),
            label_description.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding)
        ])
    }
}
