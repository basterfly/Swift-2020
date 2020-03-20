//
//  ViewController.swift
//  SeninTableViewFirstApp
//
//  Created by Yegor Kozlovskiy on 01.03.2020.
//  Copyright © 2020 Yegor Kozlovskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func addAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add New Element", message: "Write a name", preferredStyle: UIAlertController.Style.alert) //создали алерт он может выезжать снизу или выскакивать на экране окошком
        //добавим поле для ввода имени в алерт
        alert.addTextField { (textField) in
            textField.placeholder = "Ведите имя сюда"
        }
        //создадим кнопки в alert`e
        let alertAddActionButton = UIAlertAction(title: "Добавить", style: UIAlertAction.Style.default) { (alertAction) in
            //тут нужно обратиться к текст филду когда мы нажали кнопку
            self.dataArray.append(alert.textFields![0].text!) //полей может быть несколько поэтому массив
            self.tableView.reloadData() //после добавления перегружаем таблицу
        }
        
        let alertCancelActionButton = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil)
        //добавляем кнопки в алерт
        alert.addAction(alertAddActionButton)
        alert.addAction(alertCancelActionButton)
        //теперь нужно показать алерт
        present(alert, animated: true, completion: nil)
    }
    
    var dataArray = ["Marina", "Masha", "Maria", "Larisa", "Valentina", "Lisa"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    //здесь мы можем сделать какие то действия и передать данные на другой конторллер
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedCelIndexRow = tableView.indexPathForSelectedRow!.row
        (segue.destination as! SecondViewController).strData = dataArray[selectedCelIndexRow]
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    } // возвращаем значение стиля для свайпа

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    } // Возвращаем текст который будет появлятся на свайпе когда мы хотим удалить объект

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count //возвращаем кол-во строк в таблице
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) // создаем ячейку
        cell.textLabel?.text = dataArray[indexPath.row] //присваиваем значение ячейке
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataArray.remove(at: indexPath.row) //удаление данных
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade) // удаление ячейки
    } //в данном методе нам нужно произвести удаление выбранной ячейки и данных
}
