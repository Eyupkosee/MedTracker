//
//  AddMedOftenVC.swift
//  MedTracker
//
//  Created by eyüp köse on 20.07.2024.
//

import UIKit
import Lottie

class AddMedOftenVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, selectTimeMedicineDelegate {
    
    private var animationView: LottieAnimationView!

    @IBOutlet weak var lottieView: UIView!
    
    @IBOutlet weak var oftenView: UIView!
    @IBOutlet weak var hourLbl: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var selectedHourCount: Int = 2  // Varsayılan olarak 2 saat
    private var selectedTimes: [Date?] = Array(repeating: nil, count: 12)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtn.layer.cornerRadius = 12
        
        oftenView.layer.borderWidth = 2.0
        oftenView.layer.borderColor = UIColor(hex: "#3498db", alpha: 1.0)?.cgColor
        oftenView.layer.cornerRadius = 12
        
        setupAnimationView()
        
        let oftenViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        oftenView.addGestureRecognizer(oftenViewTapGesture)
        
        // CollectionView Ayarları
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "HourCell")
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        let nibName = "HoursCell"
        let hoursCellVC = HoursCell(nibName: nibName, bundle: nil)
        
        hoursCellVC.onDone = { [weak self] selectedValue in
            self?.selectedHourCount = selectedValue
            self?.selectedTimes = Array(repeating: nil, count: selectedValue) // Seçilen saat sayısına göre array'i yeniden boyutlandırın
            self?.collectionView.reloadData()  // CollectionView'i güncelleyin
        }
        
        hoursCellVC.modalPresentationStyle = .pageSheet
        hoursCellVC.modalTransitionStyle = .coverVertical
        present(hoursCellVC, animated: true, completion: nil)
    }
    
    func setupAnimationView() {
        animationView = .init(name: "animation3")
        animationView.frame = lottieView.bounds
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        lottieView.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: lottieView.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: lottieView.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: lottieView.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: lottieView.bottomAnchor)
        ])
        
        animationView.play()
    }
    
    // CollectionView Delegate ve DataSource Metodları
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedHourCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourCell", for: indexPath)
        
        // Hücreyi temizle
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // UITextField ekleyin
        let textField = UITextField(frame: cell.contentView.bounds)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Saat \(indexPath.item + 1)"
        textField.textAlignment = .center
        textField.tag = indexPath.item
        
        // TextField'ı sadece seçilen saati göstermek için kullanıyoruz
        textField.isUserInteractionEnabled = false // Kullanıcı yazı yazamasın
        
        // Önceden seçilen zamanı göstermek için
        if let selectedDate = selectedTimes[indexPath.item] {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            textField.text = formatter.string(from: selectedDate)
        }
        
        cell.contentView.addSubview(textField)
        
        return cell
    }

    // Hücre seçildiğinde selectTimeMedicine ekranını aç
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nibName = "selectTimeMedicine"
        let timeCellVC = selectTimeMedicine(nibName: nibName, bundle: nil)
        timeCellVC.delegate = self // Delegate'i ayarla
        timeCellVC.indexPath = indexPath // Seçilen hücrenin indexPath'ini ilet
        
        timeCellVC.modalPresentationStyle = .pageSheet
        timeCellVC.modalTransitionStyle = .coverVertical
        present(timeCellVC, animated: true, completion: nil)
    }
    
    // Delegate metodunu uygulayın
    func didSelectTime(_ time: Date, for indexPath: IndexPath) {
        selectedTimes[indexPath.item] = time
        
        // CollectionView'daki ilgili hücreyi güncelle
        if let cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewCell, let textField = cell.contentView.subviews.first as? UITextField {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            textField.text = formatter.string(from: time)
        }
    }
    
    // UICollectionViewDelegateFlowLayout Metodu - Hücre Boyutu
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 20
        return CGSize(width: width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
