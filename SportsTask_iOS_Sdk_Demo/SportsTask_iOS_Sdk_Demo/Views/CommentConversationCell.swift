//
//  CommentConversationCell.swift
//  SportsTask_iOS_Sdk_Demo
//
//  Created by Admin on 14/04/20.
//  Copyright © 2020 krishna41. All rights reserved.
//

import Foundation
import UIKit
class CommentConversationCell: UICollectionViewCell{
    
    var model: CommentConversation!{
        didSet{
            conversationTitle.text = model.title.isEmpty ? "No Title" : model.title
            numberOfComments.text = "Comments: \(model.commentcount)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        backgroundColor = .white
        [conversationTitle,numberOfComments,rightArrow,divider].forEach{addSubview($0)}
        setupConstraints()
    }
    
    func setupConstraints(){
        let constraints = [
            
            rightArrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            rightArrow.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightArrow.widthAnchor.constraint(equalToConstant: 20),
            rightArrow.heightAnchor.constraint(equalToConstant: 20),
            
            conversationTitle.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            conversationTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            conversationTitle.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor, constant: -10),
            
            numberOfComments.topAnchor.constraint(equalTo: conversationTitle.bottomAnchor, constant: 2),
            numberOfComments.leadingAnchor.constraint(equalTo: conversationTitle.leadingAnchor),
            numberOfComments.trailingAnchor.constraint(equalTo: conversationTitle.trailingAnchor),
            
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    public let conversationTitle: UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let numberOfComments: UILabel = {
        let v = UILabel()
        v.numberOfLines = 1
        v.font = UIFont.systemFont(ofSize: 12, weight: .light)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let rightArrow: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(systemName: "chevron.right")
        v.tintColor = .black
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let divider: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(r: 211, g: 211, b: 211)
        return v
    }()
}
