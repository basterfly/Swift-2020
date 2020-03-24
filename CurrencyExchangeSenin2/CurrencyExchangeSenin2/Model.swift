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

class Model: NSObject, XMLParserDelegate {
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
    
    var urlForXML: URL {
        return URL(fileURLWithPath: pathForXML)
    }
    
    //загрузка XML c cbr.ru и сохранение его в катологе приложения
    func loadXMLFile(date: Date) {
        
    }//func для загрузки xml
    //распарсить XML и положить его в currencies: [Curruncy], отправить уведомление приложению о том что данные обновились
    func parseXML() {
        let parser = XMLParser(contentsOf: urlForXML)
        //нужно парсеру назначить делегата и модель назначить соответствовать делегату XMLParserDelegate
        parser?.delegate = self
        parser?.parse()
        
        print(currencies)
    }
    
    var currentCurrancy: Curruncy?
    
    //вместо написания extensionа и реализации в нем методов дегата пишем тут
    //данный метод ищет в XMLе данные с : <ИМЯ> (начало строки) и вносит их в словарь attributeDict
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "Valute" { //если элемент имеется то создадим какуюто валюту
            currentCurrancy = Curruncy()
        }
    }
    
    var currentCaracters: String = ""
       //этот метод вызывается когда в XML находятся цифры между началом и концом строки <NAME>098</NAME>
       func parser(_ parser: XMLParser, foundCharacters string: String) {
           currentCaracters = string
       }
    
    //данный метод ищет в XMLе данные с : </ИМЯ> (конец строки) и вызывается когда находит их
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "NumCode" {
            currentCurrancy?.NumCode = currentCaracters
        }
        if elementName == "CharCode" {
            currentCurrancy?.CharCode = currentCaracters
        }
        if elementName == "Nominal" {
            currentCurrancy?.Nominal = currentCaracters
            currentCurrancy?.nominalDouble = Double(currentCaracters.replacingOccurrences(of: ",", with: ".")) // replacingOccurrences применяем для преобразования зяпятой в точку
        }
        if elementName == "Name" {
            currentCurrancy?.Name = currentCaracters
        }
        if elementName == "Value" {
            currentCurrancy?.Value = currentCaracters
            currentCurrancy?.valueDouble = Double(currentCaracters.replacingOccurrences(of: ",", with: ".")) // replacingOccurrences применяем для преобразования зяпятой в точку
        }
        
        if elementName == "Valute" { //если элемент закрылся в XML то мы его добавляем в массив
            currencies.append(currentCurrancy!)
        }
    }
}
