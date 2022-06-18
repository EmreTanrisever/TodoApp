//
//  ViewController.swift
//  ToDoApp
//
//  Created by Emre Tanrısever on 4.06.2022.
//

import UIKit
import SnapKit

class TaskListController: UIViewController {

    private let taskTableView = UITableView()
    private let fabButton = UIButton()
    private let modelView = ToDoViewModel()
    private var toDos = [ToDoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "To Do"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white

        toDos = modelView.returnData() ?? [ToDoModel]()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        taskTableView.reloadData()
        if navigationItem.hidesBackButton == false {
            navigationItem.hidesBackButton = true
        }
    }
    
    private func configure() {
        view.addSubview(taskTableView)
        view.addSubview(fabButton)
        
        setTableViewDelegate()
        taskTableView.rowHeight = 104
        taskTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskCell")
        setTableViewContraints()
    
        fabButtonDesign()
        setFabButtonContraints()
        fabButton.addTarget(self, action: #selector(fabButtonTapped), for: .touchUpInside)
    }
    
    // MARK:  TABLEVIEW START
    private func setTableViewDelegate() {
        taskTableView.delegate = self
        taskTableView.dataSource = self
    }

    private func setTableViewContraints() {
        taskTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-96)
            make.trailing.equalToSuperview()
        }
    }
    // MARK: TABLEVIEW FINISH
    
    // MARK: FABBUTTON Start
    private func fabButtonDesign() {
        fabButton.setTitle("+", for: .normal)
        fabButton.setTitleColor(.white, for: .normal)
        fabButton.titleLabel?.font = .systemFont(ofSize: 32)
        fabButton.layer.cornerRadius = 16
        fabButton.backgroundColor = .blue
    }
    
    private func setFabButtonContraints() {
        fabButton.snp.makeConstraints { make in
            make.width.equalTo(72)
            make.height.equalTo(72)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.trailing.equalTo(-16)
        }
    }
    
    @objc private func fabButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(TaskAddController(), animated: true)
    }
    // MARK: FABBUTTON FINISH
    
    @objc func taskButtonTapped(sender: UIButton) {
        modelView.delete(index: sender.tag)
        toDos = modelView.returnData() ?? [ToDoModel]()
        taskTableView.reloadData()
    }
}

// MARK: - Extension
extension TaskListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelView.countData()!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskTableViewCell
        cell.setTask(task: toDos[indexPath.row].task)
        cell.setDate(date: toDos[indexPath.row].date)
        cell.setDescription(description: toDos[indexPath.row].description)
        cell.taskButton.addTarget(self, action: #selector(taskButtonTapped(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Update", message: "", preferredStyle: .alert)
        alert.addTextField { UITextField in
            UITextField.text = self.toDos[indexPath.row].task
        }
        alert.addTextField { UITextField in
            UITextField.text = self.toDos[indexPath.row].description
        }
        alert.addTextField { UITextField in
            UITextField.text = self.toDos[indexPath.row].date
        }
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { UIAlertAction in
            let taskTextField = alert.textFields![0]
            let descriptionTextField = alert.textFields![1]
            let dateTextField = alert.textFields![2]
            self.modelView.update(data: ToDoModel(task: taskTextField.text!, description: descriptionTextField.text!, date: dateTextField.text!), index: indexPath.row)
            self.toDos = self.modelView.returnData() ?? [ToDoModel]()
            tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

