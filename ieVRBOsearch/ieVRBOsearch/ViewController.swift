//
//  ViewController.swift
//  ieVRBOsearch
//
//  Created by Dustin Mahone on 2/25/20.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var townPicker: UIPickerView!
    @IBOutlet weak var bedroomPicker: UIPickerView!
    @IBOutlet weak var arrivalPicker: UIDatePicker!
    @IBOutlet weak var departurePicker: UIDatePicker!
    
    let dateFormatter = DateFormatter()
    
    var destination = "eleuthera"
    var minBed = "1"
    var arrivalDate: String = ""
    var departureDate: String = ""
    
    var destinationData: [String] = [String]()
    var bedroomData: [String] = [String]()
    var arrivalData: [String] = [String]()
    var departureData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.townPicker.delegate = self
        self.townPicker.dataSource = self
        
        self.bedroomPicker.delegate = self
        self.bedroomPicker.dataSource = self
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        arrivalPicker.datePickerMode = .date
        departurePicker.datePickerMode = .date
        
        arrivalPicker.date = Date()
        arrivalPicker.minimumDate = Date()
        
        destinationData = ["All Eleuthera", "North Eleuthera", "Spanish Wells", "Harbour Island", "Gregory Town", "Rainbow Bay", "Central Eleuthera", "Governors Harbour", "North Palmetto Point", "South Palmetto Point", "Savannah Sound", "Windermere Island", "South Eleuthera", "Tarpum Bay", "Rock Sound"]
        
        bedroomData = ["1", "2", "3", "4", "5", "6"]
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == townPicker {
            return destinationData.count //+ 1 //works with titleForRow update
        } else { //pickerView == bedroomPicker {
            return bedroomData.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == townPicker {
            //return row == 0 ? "" : destinationData[row - 1] //this works
            return destinationData[row]
        } else {
            return bedroomData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == townPicker {
            let selectedArea = destinationData[row]
            destination = selectedArea.replacingOccurrences(of: "All Eleuthera", with: "eleuthera")
            destination = selectedArea.replacingOccurrences(of: " ", with: "-")
            print(destination)
            //return row == 0 ? "" : destinationData[row - 1] //this works
            return
        } else {
            minBed = bedroomData[row]
            return
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var dayComponent = DateComponents()
        dayComponent.day = 1
        let theCalendar = Calendar.current
        let nextDate = theCalendar.date(byAdding: dayComponent, to: Date())
        
        departurePicker.minimumDate = theCalendar.date(byAdding: dayComponent, to: arrivalPicker.date)
        print("villa search value is \(villaSearchValues.searchValues.destination)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "vrboSegue" {
            guard let controller = segue.destination as? VrboWeb else { return }
            
            print("prepare for segue called")
            arrivalDate = dateFormatter.string(from: arrivalPicker.date)
            departureDate = dateFormatter.string(from: departurePicker.date)
            
            villaSearchValues.searchValues.destination = destination
            villaSearchValues.searchValues.minBed = minBed
            villaSearchValues.searchValues.arrivalDate = arrivalDate
            villaSearchValues.searchValues.departureDate = departureDate
            
            print("prepare villa search value is \(villaSearchValues.searchValues.destination)")
            
            controller.webSearch = villaSearchValues.Endpoints.villaSearch.stringValue
            print("controller websearch is \(controller.webSearch)")
        }
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "vrboSegue", sender: self)
        
    }
}

