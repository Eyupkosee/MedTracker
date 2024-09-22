//
//  MyCustomTabbarController.swift
//  MedTracker
//
//  Created by eyüp köse on 13.07.2024.
//

import UIKit
import Foundation

class MyCustomTabBarController: UITabBarController {
    let btnMiddle: UIButton = {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            btn.setTitle("", for: .normal)
        btn.backgroundColor = UIColor(hex: "#59B4E4", alpha: 1.0)
            btn.layer.cornerRadius = 30
            btn.layer.shadowColor = UIColor.black.cgColor
            btn.layer.shadowOpacity = 0.2
            btn.layer.shadowOffset = CGSize(width: 4, height: 4)
            let config = UIImage.SymbolConfiguration(pointSize: 36, weight: .regular)
            let image = UIImage(systemName: "plus", withConfiguration: config)
            btn.setImage(image, for: .normal)
            btn.tintColor = .black
            
            // Button action
            btn.addTarget(self, action: #selector(didTapMiddleButton), for: .touchUpInside)
            
            return btn
        }()
    
    @objc func didTapMiddleButton() {
        // 'AddViews' adındaki storyboard'u yüklüyoruz
        let storyboard = UIStoryboard(name: "AddViews", bundle: nil)
        
        // 'AddMed' storyboard identifier'ı ile view controller'ı instantiate ediyoruz
        guard let addMedVC = storyboard.instantiateViewController(withIdentifier: "AddMed") as? AddMedVC else {
            print("Bu, view controller identifier'ınızı doğru ayarlamadığınız anlamına gelir.")
            return
        }
        
        // Eğer navigation controller yoksa, bir navigation controller oluştur ve addMedVC'yi kök view controller olarak ayarla
        if self.navigationController == nil {
            let navController = UINavigationController(rootViewController: addMedVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        } else {
            // Mevcut Navigation Controller'ı alıyoruz
            self.navigationController?.pushViewController(addMedVC, animated: true)
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSomeTabItems()
        btnMiddle.frame = CGRect(x: Int(self.tabBar.bounds.width) / 2 - 30, y: -20, width: 60, height: 60)
    }
    
    override func loadView() {
        super.loadView()
        self.tabBar.addSubview(btnMiddle)
        setupCustomTabBar()
    }
    
    func setupCustomTabBar() {
        let path: UIBezierPath = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor(hex: "#59B4E4", alpha: 1.0)?.cgColor
        shape.fillColor = UIColor(hex: "#59B4E4", alpha: 1.0)?.cgColor
        self.tabBar.layer.insertSublayer(shape, at: 0)
        self.tabBar.itemWidth = 40
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemSpacing = 180
        self.tabBar.tintColor = UIColor(hex: "#55ebc1", alpha: 1.0)
    }
    
    func addSomeTabItems() {
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: SettingVC())
        vc1.title = "Home"
        vc2.title = "Setting"
        setViewControllers([vc1, vc2], animated: false)
        guard let items = tabBar.items else { return }
        items[0].image = UIImage(systemName: "house.fill")
        items[1].image = UIImage(systemName: "gear.circle.fill")
    }
    
    func getPathForTabBar() -> UIBezierPath {
        let frameWidth = self.tabBar.bounds.width
        let frameHeight = self.tabBar.bounds.height + 20
        let holeWidth = 150
        let holeHeight = 50
        let leftXUntilHole = Int(frameWidth / 2) - Int(holeWidth / 2)
        
        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: leftXUntilHole, y: 0)) // 1.Line
        path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth / 3), y: holeHeight / 2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth / 3) / 8) * 6, y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth / 3) / 8) * 8, y: holeHeight / 2)) // part I
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + (2 * holeWidth) / 3, y: holeHeight / 2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth / 3) + (holeWidth / 3) / 3 * 2 / 5, y: (holeHeight / 2) * 6 / 4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth / 3) + (holeWidth / 3) / 3 * 2 + (holeWidth / 3) / 3 * 3 / 5, y: (holeHeight / 2) * 6 / 4)) // part II
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2 * holeWidth) / 3, y: holeHeight / 2), controlPoint2: CGPoint(x: leftXUntilHole + (2 * holeWidth) / 3 + (holeWidth / 3) * 2 / 8, y: 0)) // part III
        path.addLine(to: CGPoint(x: frameWidth, y: 0)) // 2. Line
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight)) // 3. Line
        path.addLine(to: CGPoint(x: 0, y: frameHeight)) // 4. Line
        path.addLine(to: CGPoint(x: 0, y: 0)) // 5. Line
        path.close()
        return path
    }
}



extension UIColor {
    public convenience init?(hex: String, alpha: Double = 1.0) {
        var pureString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (pureString.hasPrefix("#")) {
            pureString.remove(at: pureString.startIndex)
        }
        if ((pureString.count) != 6) {
            return nil
        }
        let scanner = Scanner(string: pureString)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            self.init(
                red: CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(hexNumber & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0))
            return
        }
        return nil
    }
}
