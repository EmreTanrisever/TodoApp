//
//  TaskAddController.swift
//  ToDoApp
//
//  Created by Emre Tanrısever on 6.06.2022.
//

import UIKit
import SnapKit

class TaskAddController: UIViewController, UITextViewDelegate {

    private let taskTextView = UITextView()
    private let descriptionTextView = UITextView()
    private let datePicker = UIDatePicker()
    private let addButton = UIButton()
    
    private let viewModel = ToDoViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Add A Task"
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        configure()
    }
    
    private func configure() {
        view.addSubview(taskTextView)
        view.addSubview(descriptionTextView)
        view.addSubview(datePicker)
        view.addSubview(addButton)
        
        setTaskTextViewConstraints()
        taskTextViewDesign()
        
        setDescriptionTextViewConstraints()
        descriptionTextViewDesign()
        
        setDatePickerConstraints()
        datePickerDesign()
        
        setAddButtonConstraints()
        addButtonDesign()
    }
    
    private func taskTextViewDesign() {
        taskTextView.layer.borderColor = UIColor.black.cgColor
        taskTextView.layer.borderWidth = 1
        taskTextView.layer.cornerRadius = 8
        taskTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        taskTextView.alignTextVerticallyInContainer()
        taskTextView.isScrollEnabled = false
        taskTextView.text = "Add a task title"
        taskTextView.textColor = .lightGray
        taskTextView.returnKeyType = .done
        taskTextView.delegate = self
    }
    
    private func setTaskTextViewConstraints() {
        taskTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(42)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        textView.text = ""
        textView.textColor = .black
    }

    private func setDescriptionTextViewConstraints() {
        descriptionTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(taskTextView.snp_bottomMargin).offset(16)
        }
    }
    
    private func descriptionTextViewDesign() {
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 8
        descriptionTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        descriptionTextView.alignTextVerticallyInContainer()
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.text = "Add a task description"
        descriptionTextView.textColor = .lightGray
        descriptionTextView.returnKeyType = .done
        descriptionTextView.delegate = self
    }
    
    private func setDatePickerConstraints() {
        datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionTextView.snp_bottomMargin).offset(16)
            make.height.equalTo(42)
        }
    }
    
    private func datePickerDesign() {
        datePicker.datePickerMode = .date
    }
    
    private func addButtonDesign() {
        addButton.backgroundColor = .blue
        addButton.layer.cornerRadius = 8
        addButton.setTitle("Add Task", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private func setAddButtonConstraints() {
        addButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(datePicker.snp_bottomMargin).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(42)
        }
    }
    
    @objc private func addButtonTapped(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        if !taskTextView.text.isEmpty {
            let task = ToDoModel(task: taskTextView.text, description: descriptionTextView.text, date: dateFormatter.string(from: datePicker.date))
            viewModel.add(data: [task])
            navigationController?.pushViewController(ViewController(), animated: true)
        }
    }
}

// MARK: EXTENSİON
extension UITextView {
    func alignTextVerticallyInContainer() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        self.contentInset.top = topCorrect
    }
}
