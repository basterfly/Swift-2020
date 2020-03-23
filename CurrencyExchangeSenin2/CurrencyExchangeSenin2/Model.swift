//
//  Model.swift
//  CurrencyExchangeSenin2
//
//  Created by Yegor Kozlovskiy on 22.03.2020.
//  Copyright © 2020 Yegor Kozlovskiy. All rights reserved.
//

import UIKit

class Curruncy {
    //создаем набор свойств из файла xml необходимые для работы
    var NumCode: String?
    var CharCode: String?
    
    var Nominal: String?
    var nominalDouble: Double?
    
    var Name: String?
    
    var Value: String?
    var valueDouble: Double?

}

class Model: NSObject {
    static let shared = Model() //sharedInstance - создаем синглтон класса модель, т.е. инстанс класса Модель. Будем обращаться к нему и с ним всегда работать, а не плодить новые, тем самым не расходуем память.
    var currencies: [Curruncy] = []
    
    //если файл будет загружен то будем брать данные из него!, если файл не загружен то данные будем брать из файла data.xml
    var pathForXML: String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/date.xml"
        if FileManager.default.fileExists(atPath: path) { //если файл существует то обращаемся к нему
            print(path)
            return path
        }
        //если файл не существует
        return Bundle.main.path(forResource: "data", ofType: "xml")!
    }
    
    var urlForXML: URL? {
        return URL(fileURLWithPath: pathForXML)
    }
    
    //загрузка XML c cbr.ru и сохранение его в катологе приложения
    func loadXMLFile(date: Date) {
        
    }//func для загрузки xml
    //распарсить XML и положить его в currencies: [Curruncy], отправить уведомление приложению о том что данные обновились
    func parseXML() {
        
    }
}
