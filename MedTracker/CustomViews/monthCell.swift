//
//  monthCell.swift
//  MedTracker
//
//  Created by eyüp köse on 18.07.2024.
//

import UIKit

protocol MonthCellDelegate: AnyObject {
    func didSelectDates(_ dates: [DateComponents])
}


class monthCell: UIViewController, UICalendarSelectionMultiDateDelegate {
    
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calenderImg: UIImageView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    
    weak var delegate: MonthCellDelegate?
    var selectedDates: [DateComponents] = []
    
    // onDismiss closure'ı ekliyoruz
    var onDismiss: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UICalendarView'i ekleyin ve calenderView'in frame'ine uygun hale getirin
        let calenderSubview = UICalendarView(frame: calenderView.bounds)
        let graCalender = Calendar(identifier: .gregorian)
        let selection = UICalendarSelectionMultiDate(delegate: self)
        calenderSubview.selectionBehavior = selection
        calenderSubview.calendar = graCalender
        calenderSubview.tintColor = UIColor(hex: "#59B4E4", alpha: 1.0)
        
        // Otomatik yerleşim kısıtlamalarını kapatın
        calenderSubview.translatesAutoresizingMaskIntoConstraints = false
        
        self.calenderView.addSubview(calenderSubview)
        
        // UICalendarView için kısıtlamaları ayarlayın
        NSLayoutConstraint.activate([
            calenderSubview.leadingAnchor.constraint(equalTo: calenderView.leadingAnchor),
            calenderSubview.trailingAnchor.constraint(equalTo: calenderView.trailingAnchor),
            calenderSubview.topAnchor.constraint(equalTo: calenderView.topAnchor),
            calenderSubview.bottomAnchor.constraint(equalTo: calenderView.bottomAnchor)
        ])
        
        
        // Kapatma işlemi olduğunda tetiklenecek
        self.isModalInPresentation = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Dismiss edilirken onDismiss closure'ını çağırıyoruz
        delegate?.didSelectDates(selectedDates)
        onDismiss?()
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        delegate?.didSelectDates(selectedDates)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnClicked(_ sender: Any) {
        delegate?.didSelectDates(selectedDates)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        selectedDates.append(dateComponents)
        print(dateComponents)
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        if let index = selectedDates.firstIndex(of: dateComponents) {
            selectedDates.remove(at: index)
        }
        print(dateComponents)
    }

    
}
