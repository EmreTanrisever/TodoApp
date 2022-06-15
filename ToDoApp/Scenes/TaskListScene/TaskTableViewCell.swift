//
//  TaskTableViewCell.swift
//  ToDoApp
//
//  Created by Emre Tanrısever on 4.06.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    private let taskLabel = UILabel()
    let taskButton = UIButton()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()
    private let modelView = ToDoViewModel()
    private let tableView = ViewController().taskTableView

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    private func configure() {
        addSubview(taskLabel)
        contentView.addSubview(taskButton)
        addSubview(descriptionLabel)
        addSubview(dateLabel)
        
        taskButtonDesign()
        setTaskButtonConstraint()
        taskButton.addTarget(self, action: #selector(taskButtonTapped(sender:)), for: .touchUpInside)
        
        taskLabelDesign()
        setTaskLabelConstraint()
        
        descriptionLabelDesign()
        setDescriptionLabelConstraints()
        
        dateLabelDesign()
        setDateLabelDesignConstraints()
    }
    
    func setTask(task: String) {
        taskLabel.text = task
    }
    
    func setDescription(description: String) {
        descriptionLabel.text = description
    }
    
    func setDate(date: String) {
        dateLabel.text = date
    }
    
    private func taskLabelDesign() {
        taskLabel.textColor = .black
        taskLabel.font = UIFont.systemFont(ofSize: 20)
    }
    
    private func setTaskLabelConstraint() {
        taskLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(48)
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview()
        }
    }
    
    // MARK: TASKBUTTON
    private func taskButtonDesign() {
        taskButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        taskButton.backgroundColor = .white
        taskButton.layer.borderColor = UIColor.red.cgColor
        taskButton.layer.borderWidth = 2
        taskButton.layer.cornerRadius = 8
    }
    
    private func setTaskButtonConstraint() {
        taskButton.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.leading.equalTo(16)
            make.centerY.equalToSuperview()
        }
    }
    
    private func descriptionLabelDesign() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.preferredMaxLayoutWidth = 350
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        descriptionLabel.sizeToFit()
        descriptionLabel.textColor = .lightGray
    }
    
    private func setDescriptionLabelConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(taskLabel.snp_bottomMargin).offset(8)
            make.leading.equalToSuperview().offset(48)
        }
    }
    
    private func dateLabelDesign() {
        dateLabel.text = "27.06.1999"
    }
    
    private func setDateLabelDesignConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    @objc func taskButtonTapped(sender: UIButton) {
        modelView.delete(index: sender.tag)
        taskButton.layer.borderColor = UIColor.green.cgColor
        tableView.deleteRows(at: [IndexPath(row: sender.tag, section: sender.tag)], with: .fade)
        tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
