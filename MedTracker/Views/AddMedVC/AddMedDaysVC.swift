//
//  AddMedDaysVC.swift
//  MedTracker
//
//  Created by eyüp köse on 15.07.2024.
//

import UIKit
import Lottie

class AddMedDaysVC: UIViewController, DaysCellDelegate, MonthCellDelegate, UIAdaptivePresentationControllerDelegate {
    
    
    
    private var animationView: LottieAnimationView!
    
    //MARK: View
    @IBOutlet weak var everyDayView: UIView!
    @IBOutlet weak var weekDaysView: UIView!
    @IBOutlet weak var datesView: UIView!
    
    //MARK: Radio Buttons
    @IBOutlet weak var everyDayRadioBtn: UIButton!
    @IBOutlet weak var weekDaysRadioBtn: UIButton!
    @IBOutlet weak var datesRadioBtn: UIButton!
    
    //MARK: Labels
    @IBOutlet weak var weekDaysLbl: UILabel!
    @IBOutlet weak var weekDaysLblHeight: NSLayoutConstraint!
    
    @IBOutlet weak var datesLbl: UITextView!
    @IBOutlet weak var datesLblHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lottieView: UIView!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtn.layer.cornerRadius = 12
        
        setupViewBorders()
        
        everyDayRadioBtn.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        weekDaysRadioBtn.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        datesRadioBtn.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        
        // View'lere tap gesture ekle
        let everyDayTapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        everyDayView.addGestureRecognizer(everyDayTapGesture)
        
        let weekDaysTapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        weekDaysView.addGestureRecognizer(weekDaysTapGesture)
        
        let datesTapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        datesView.addGestureRecognizer(datesTapGesture)
        
        setupAnimationView()
        
    }
    
    // View kapandığında çağrılır
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Eğer bir seçim yapılmadıysa radio button'ları sıfırla
        if weekDaysRadioBtn.isSelected || datesRadioBtn.isSelected {
            weekDaysRadioBtn.isSelected = false
            datesRadioBtn.isSelected = false
            updateRadioButtonImages()
        }
    }
    
    func setupAnimationView() {
        // Initialize the animation view with the Lottie animation name
        animationView = .init(name: "animation6")
        
        // Set the frame to match the lottieView's bounds
        animationView.frame = lottieView.bounds
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        
        // Add the animation view as a subview of lottieView
        lottieView.addSubview(animationView)
        
        // Ensure the animation view resizes properly when the lottieView changes size
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: lottieView.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: lottieView.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: lottieView.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: lottieView.bottomAnchor)
        ])
        
        // Play the animation
        animationView.play()
    }
    
    func setupViewBorders() {
        let borderColor = UIColor(hex: "#D3D3D3", alpha: 1.0)?.cgColor
        let borderWidth: CGFloat = 2.0
        
        everyDayView.layer.borderColor = borderColor
        everyDayView.layer.borderWidth = borderWidth
        everyDayView.layer.cornerRadius = 18
        
        weekDaysView.layer.borderColor = borderColor
        weekDaysView.layer.borderWidth = borderWidth
        weekDaysView.layer.cornerRadius = 18
        
        datesView.layer.borderColor = borderColor
        datesView.layer.borderWidth = borderWidth
        datesView.layer.cornerRadius = 18
    }
    
    
    @objc func radioButtonTapped(_ sender: UIButton) {
        // Önce tüm butonların isSelected özelliğini false yap
        everyDayRadioBtn.isSelected = false
        weekDaysRadioBtn.isSelected = false
        datesRadioBtn.isSelected = false
        
        // Tıklanan butonun isSelected özelliğini true yap
        sender.isSelected = true
        
        // Radio button'ların imajlarını isSelected durumuna göre ayarla
        updateRadioButtonImages()
        
        if sender == everyDayRadioBtn {
            weekDaysLbl.text = ""
            weekDaysLblHeight.constant = 0
            datesLbl.text = ""
            datesLblHeight.constant = 0
        }
        
        // Eğer weekDaysRadioBtn ise, DaysCellViewController'ı göster
        if sender == weekDaysRadioBtn {
            datesLbl.text = ""
            datesLblHeight.constant = 0
            presentDaysCellViewController()
        }
        
        if sender == datesRadioBtn {
            weekDaysLbl.text = ""
            weekDaysLblHeight.constant = 0
            presentDatesCellViewController()
        }
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        // Tap gesture'ın olduğu view'e göre ilgili radio button'u seç
        switch sender.view {
        case everyDayView:
            weekDaysLbl.text = ""
            weekDaysLblHeight.constant = 0
            datesLbl.text = ""
            datesLblHeight.constant = 0
            radioButtonTapped(everyDayRadioBtn)
        case weekDaysView:
            datesLbl.text = ""
            datesLblHeight.constant = 0
            radioButtonTapped(weekDaysRadioBtn)
        case datesView:
            weekDaysLbl.text = ""
            weekDaysLblHeight.constant = 0
            datesLblHeight.constant = 100
            radioButtonTapped(datesRadioBtn)
        default:
            break
        }
    }
    
    func updateRadioButtonImages() {
        everyDayRadioBtn.setImage(UIImage(named: everyDayRadioBtn.isSelected ? "ic_radio_button_selected" : "ic_radio_button_unselected"), for: .normal)
        weekDaysRadioBtn.setImage(UIImage(named: weekDaysRadioBtn.isSelected ? "ic_radio_button_selected" : "ic_radio_button_unselected"), for: .normal)
        datesRadioBtn.setImage(UIImage(named: datesRadioBtn.isSelected ? "ic_radio_button_selected" : "ic_radio_button_unselected"), for: .normal)
        
        //        if (weekDaysRadioBtn.isSelected) == false {
        ////            weekDaysLbl.text = ""
        ////            weekDaysLblHeight.constant = 0
        //            print("false")
        //        }
        
        // Görünümleri güncelle
        everyDayView.layer.borderColor = everyDayRadioBtn.isSelected ?  UIColor(hex: "#3498db", alpha: 1.0)?.cgColor :  UIColor(hex: "#D3D3D3", alpha: 1.0)?.cgColor
        weekDaysView.layer.borderColor = weekDaysRadioBtn.isSelected ? UIColor(hex: "#3498db", alpha: 1.0)?.cgColor :  UIColor(hex: "#D3D3D3", alpha: 1.0)?.cgColor
        datesView.layer.borderColor = datesRadioBtn.isSelected ? UIColor(hex: "#3498db", alpha: 1.0)?.cgColor :  UIColor(hex: "#D3D3D3", alpha: 1.0)?.cgColor
    }
    
    

    
    // DaysCell ve MonthCell ViewController'larını açarken dismiss eventini ekleyelim
    func presentDaysCellViewController() {
        let nibName = "DaysCell"
        let daysCellVC = DaysCell(nibName: nibName, bundle: nil)
        daysCellVC.delegate = self
        daysCellVC.modalPresentationStyle = .pageSheet
        daysCellVC.modalTransitionStyle = .coverVertical
        
        // Dismiss edildiğinde seçimi sıfırla
        daysCellVC.onDismiss = { [weak self] in
            func didSelectDays(_ days: [String]) {
                if days.isEmpty {
                    self?.weekDaysRadioBtn.isSelected = false
                    self?.updateRadioButtonImages()
                    self?.weekDaysLbl.text = ""
                    self?.weekDaysLblHeight.constant = 0
                } else {
                    self?.weekDaysLbl.text = days.joined(separator: " - ")
                    self?.weekDaysLblHeight.constant = 50
                }
            }
        }
        
        present(daysCellVC, animated: true, completion: nil)
    }
    
    func presentDatesCellViewController() {
        let nibName = "monthCell"
        let monthCellVC = monthCell(nibName: nibName, bundle: nil)
        monthCellVC.delegate = self
        monthCellVC.modalPresentationStyle = .pageSheet
        monthCellVC.modalTransitionStyle = .coverVertical
        
        // Dismiss edildiğinde seçimi sıfırla
        monthCellVC.onDismiss = { [weak self] in
            func didSelectDates(_ dates: [DateComponents]) {
                if dates.isEmpty {
                    self?.datesRadioBtn.isSelected = false
                    self?.updateRadioButtonImages()
                    self?.datesLbl.text = ""
                    self?.datesLblHeight.constant = 0
                } else {
                    var dateDict = [String: [String]]()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MMM"
                    
                    for date in dates {
                        if let date = Calendar.current.date(from: date) {
                            let month = formatter.string(from: date)
                            let day = String(Calendar.current.component(.day, from: date))
                            if dateDict[month] != nil {
                                dateDict[month]?.append(day)
                            } else {
                                dateDict[month] = [day]
                            }
                        }
                    }
                    
                    let monthFormatter = DateFormatter()
                    monthFormatter.dateFormat = "MMM"
                    let sortedMonths = dateDict.keys.sorted {
                        guard let date1 = monthFormatter.date(from: $0),
                              let date2 = monthFormatter.date(from: $1) else {
                            return false
                        }
                        return date1 < date2
                    }
                    
                    var datesText = ""
                    for month in sortedMonths {
                        if let days = dateDict[month] {
                            datesText += "\(month) : \(days.joined(separator: " - "))\n"
                        }
                    }
                    
                    self?.datesLbl.text = datesText.trimmingCharacters(in: .whitespacesAndNewlines)
                    self?.datesLbl.isScrollEnabled = true
                    self?.datesLbl.isEditable = false
                    self?.datesLblHeight.constant = 100
                }
            }
        }
        
        present(monthCellVC, animated: true, completion: nil)
    }
    
    // DaysCellDelegate metodu
    func didSelectDays(_ days: [String]) {
        if days.isEmpty {
            weekDaysRadioBtn.isSelected = false
            updateRadioButtonImages()
            weekDaysLbl.text = ""
            weekDaysLblHeight.constant = 0
        } else {
            weekDaysLbl.text = days.joined(separator: " - ")
            weekDaysLblHeight.constant = 50
        }
    }
    
    
    // MonthCellDelegate metodu
    func didSelectDates(_ dates: [DateComponents]) {
        if dates.isEmpty {
            datesRadioBtn.isSelected = false
            updateRadioButtonImages()
            datesLbl.text = ""
            datesLblHeight.constant = 0
        } else {
            var dateDict = [String: [String]]()
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            
            for date in dates {
                if let date = Calendar.current.date(from: date) {
                    let month = formatter.string(from: date)
                    let day = String(Calendar.current.component(.day, from: date))
                    if dateDict[month] != nil {
                        dateDict[month]?.append(day)
                    } else {
                        dateDict[month] = [day]
                    }
                }
            }
            
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMM"
            let sortedMonths = dateDict.keys.sorted {
                guard let date1 = monthFormatter.date(from: $0),
                      let date2 = monthFormatter.date(from: $1) else {
                    return false
                }
                return date1 < date2
            }
            
            var datesText = ""
            for month in sortedMonths {
                if let days = dateDict[month] {
                    datesText += "\(month) : \(days.joined(separator: " - "))\n"
                }
            }
            
            datesLbl.text = datesText.trimmingCharacters(in: .whitespacesAndNewlines)
            datesLbl.isScrollEnabled = true
            datesLbl.isEditable = false
            datesLblHeight.constant = 100
        }
    }
    
    
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        // Herhangi bir seçenek seçilmedi mi?
        if !everyDayRadioBtn.isSelected && !weekDaysRadioBtn.isSelected && !datesRadioBtn.isSelected {
            // Uyarı oluştur
            let alert = UIAlertController(title: "Seçim Yapılmadı", message: "Lütfen bir seçenek seçin: Her gün, haftanın belirli günleri veya tarihleri.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // 'AddViews' adındaki storyboard'u yüklüyoruz
        let storyboard = UIStoryboard(name: "AddViews", bundle: nil)
        
        // 'AddMed' storyboard identifier'ı ile view controller'ı instantiate ediyoruz
        guard let addMedOftenVC = storyboard.instantiateViewController(withIdentifier: "AddMedOften") as? AddMedOftenVC else {
            print("Bu, view controller identifier'ınızı doğru ayarlamadığınız anlamına gelir.")
            return
        }
        
        // Eğer navigation controller yoksa, bir navigation controller oluştur ve addMedVC'yi kök view controller olarak ayarla
        if self.navigationController == nil {
            let navController = UINavigationController(rootViewController: addMedOftenVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        } else {
            // Mevcut Navigation Controller'ı alıyoruz
            self.navigationController?.pushViewController(addMedOftenVC, animated: true)
        }
    }
    
    
    
}
