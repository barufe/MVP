//
//  ViewController.swift
//  ListOfTask
//
//  Created by Germain Seijas on 29/01/24.
//

import UIKit

class TaskViewController: UIViewController, TaskNavigationDelegate {
    var presenter = TaskPresenter()
    
    
    //Creamos las vistas
    private let taskTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textView.backgroundColor = .systemGray6
        textView.textColor = .label
        textView.layer.cornerRadius = 12
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.borderWidth = 1
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var goToCalcButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ir a Calculadora", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapOnGoToCalc), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var createTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Crear", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapOnCreateTask), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
        
    private lazy var taskCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 340, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.register(TasksCollectionViewCell.self, forCellWithReuseIdentifier: "TasksCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Configuramoe el navigation
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Borrar Todos",
                                                                 style: .done,
                                                                 target: presenter,
                                                                 action: #selector(presenter.removeAllTasks))
        [taskTextView, createTaskButton,goToCalcButton, taskCollectionView].forEach(view.addSubview)
        
        //Configuramos los constrains
        NSLayoutConstraint.activate([
            taskTextView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            taskTextView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            taskTextView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            taskTextView.heightAnchor.constraint(equalToConstant: 60),
            
            createTaskButton.topAnchor.constraint(equalTo: taskTextView.bottomAnchor, constant: 60),
            createTaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createTaskButton.heightAnchor.constraint(equalToConstant: 40),
            createTaskButton.widthAnchor.constraint(equalToConstant: 80),
            
            goToCalcButton.topAnchor.constraint(equalTo: createTaskButton.bottomAnchor, constant: 60),
            goToCalcButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToCalcButton.heightAnchor.constraint(equalToConstant: 40),
            goToCalcButton.widthAnchor.constraint(equalToConstant: 80),
            
            taskCollectionView.topAnchor.constraint(equalTo: goToCalcButton.bottomAnchor, constant: 12),
            taskCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            taskCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        //Implementamos los delegados
        taskCollectionView.dataSource = self
        presenter.delegate = self
        presenter.navigationDelegate = self
    }
    
    @objc func didTapOnCreateTask(){
        print("Create task")
        //Le avisamos al presenter que se pulso el boton de create
        presenter.create(task: taskTextView.text)
    }
    @objc func didTapOnGoToCalc(){
        print("Ir a calculadora")
        presenter.goToCalc()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func navigateToCalculator() {
            let calculatorViewController = CalculatorViewController()
            navigationController?.pushViewController(calculatorViewController, animated: true)
        }
}

extension TaskViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TasksCollectionViewCell", for: indexPath) as! TasksCollectionViewCell
        
        //Validamos a traves del modelo que tiene el presenter que id pulsamos
        let task = presenter.tasks[indexPath.row]
        cell.configure(id: task.id, text: task.text, isFavorite: task.isFavorite)
        
        //Le avisamos al presenter que pulsamos el boton de favorito con el id "pulsado"
        cell.tapOnFavorite = { [weak self] taskId in
            self?.presenter.updateFavorite(taskId: taskId)
        }
        //Le avisamos al presenter que pulsamos el boton de remove con el id "pulsado"
        cell.tapOnRemove = { [weak self] taskId in
            self?.presenter.removeTasks(taskId: taskId)
        }
        return cell
    }
}

extension TaskViewController: UI{
    //Se actualiza la informacion que le envio el dataBase al presenter y el presenter a la vista
    func update() {
        taskTextView.text = ""
        taskCollectionView.reloadData()
    }
}
