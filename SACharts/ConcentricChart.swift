//
//  ConcentricView.swift
//  CEOApp
//
//  Created by michelle on 2019/12/16.
//  Copyright © 2019 michelle. All rights reserved.
//

import UIKit

public class ConcentricChart: UIView {
    private let tableView = UITableView()
    var contents = [String]()
    private var numbersForDisplay = [String?]()
    private var colors = [[UIColor]]()
    private var labelColors = [UIColor]()
    private var rowHeight:CGFloat?
    private var circlesView: CirclesView!
    
    private func commonInit(){
        self.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        let bundle = Bundle(for: self.classForCoder)
        let cellNib = UINib(nibName: "ClassPointCell", bundle: bundle)
        tableView.register(cellNib, forCellReuseIdentifier: "ClassPointCell")
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
        self.addSubview(tableView)
        
        circlesView = CirclesView(frame: bounds)
        self.addSubview(circlesView)
    }
    
    public override init(frame: CGRect) {
       super.init(frame: frame)
       commonInit()
     }

     public required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       commonInit()
     }
    
    public func setItems(contents: [String], colors: [[UIColor]]){
        guard contents.count == colors.count else {
            print("label text count doesn't match color count")
            return }
        self.contents = contents.reversed()
        self.colors = colors.reversed()
        self.labelColors = (colors.map{($0.first ?? .white)}).reversed()
        self.numbersForDisplay = Array(repeating: 0, count: contents.count).map{ (String($0))}
        let adjustment:CGFloat = 4.0
         
        let height = circlesView.frame.height / 2
        let center = CGPoint(x:circlesView.bounds.midX + adjustment, y: circlesView.bounds.midX + adjustment * 2)
        tableView.frame = CGRect(origin: center, size: CGSize(width: height*1.3, height: height))
        rowHeight = height / 5
        
        circlesView.setValues(contents, colors: colors)
    }
    
    public func draw(numbers:[Float]){
        //draw circlesView
        circlesView.updateValues(values: numbers)
        //draw LabelsTableView
        self.numbersForDisplay = numbers.map{ String($0)}.reversed()
        let adjustment:CGFloat = 4.0

        let height = circlesView.frame.height / 2
        let center = CGPoint(x:circlesView.bounds.midX + adjustment, y: circlesView.bounds.midX + adjustment * 2)
        tableView.frame = CGRect(origin: center, size: CGSize(width: height*1.3, height: height))
        rowHeight = height / CGFloat(numbers.count)
        tableView.reloadData()
    }
}


extension ConcentricChart: UITableViewDelegate, UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassPointCell", for: indexPath) as? ClassPointCell
        cell?.classLabel.text = contents[indexPath.row]
        cell?.numberLabel.text = numbersForDisplay[indexPath.row]
        cell?.classLabel.textColor = labelColors[indexPath.row]
        cell?.classLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        cell?.numberLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        // remove seperator line
        cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        cell?.directionalLayoutMargins = .zero
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight ?? 1.0
    }
    
    
}
