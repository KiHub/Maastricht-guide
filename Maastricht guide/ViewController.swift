//
//  ViewController.swift
//  Maastricht guide
//
//  Created by  Mr.Ki on 26.04.2022.
//

import UIKit
import GoogleMaps
import GooglePlaces

struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate, UITextFieldDelegate {
    
    let currentLocationMarker = GMSMarker()
    var locationManager = CLLocationManager()
    var chosenPlace: MyPlace?
    
    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70
    
    let previewDemoData = [(title: "The Polar Junction", image: #imageLiteral(resourceName: "Challenge"), type: "⭐️"), (title: "The Nifty Lounge", image: #imageLiteral(resourceName: "Challenge"), type: "⭐️"), (title: "The Lunar Petal", image: #imageLiteral(resourceName: "Challenge"), type: "⭐️")]
    
    let myMapView: GMSMapView = {
        let view = GMSMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textFieldSearch: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.placeholder = "Search new points"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let buttonMyLocation: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setImage(#imageLiteral(resourceName: "Banquet"), for: .normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.tintColor = UIColor.gray
        button.imageView?.tintColor = UIColor.gray
        button.addTarget(self, action: #selector(btnMyLocationAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var previewView: PreviewView = {
        let view = PreviewView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = UIColor.white
        
        myMapView.delegate = self
        locationManager.delegate = self
        textFieldSearch.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        setupViews()
        initGoogleMaps()
        
        
    }
    
    //MARK: textfield
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        let filter = GMSAutocompleteFilter()
        autoCompleteController.autocompleteFilter = filter
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        return false
    }
    
    // MARK: GOOGLE AUTO COMPLETE DELEGATE
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let lat = place.coordinate.latitude
        let long = place.coordinate.longitude
        
        showPartyMarkers(lat: lat, long: long)
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        myMapView.camera = camera
        textFieldSearch.text=place.formattedAddress
        chosenPlace = MyPlace(name: place.formattedAddress!, lat: lat, long: long)
        let marker=GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = place.name
        marker.snippet = "\(place.formattedAddress!)"
        marker.map = myMapView
        
        self.dismiss(animated: true, completion: nil) // dismiss after place selected
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: 28.7041, longitude: 77.1025, zoom: 17.0)
        self.myMapView.camera = camera
        self.myMapView.delegate = self
        self.myMapView.isMyLocationEnabled = true
    }
    
    // MARK: CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        let location = locations.last
        let lat = (location?.coordinate.latitude)!
        let long = (location?.coordinate.longitude)!
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        
        self.myMapView.animate(to: camera)
        
        showPartyMarkers(lat: lat, long: long)
    }
    
    // MARK: GOOGLE MAP DELEGATE
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let customMarkerView = marker.iconView as? CustomPinView else { return false }
        let img = customMarkerView.image!
        let customMarker = CustomPinView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.white, tag: customMarkerView.tag)
        
        marker.iconView = customMarker
        
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        guard let customMarkerView = marker.iconView as? CustomPinView else { return nil }
        let data = previewDemoData[customMarkerView.tag]
        previewView.setData(title: data.title, image: data.image, type: data.type)
        return previewView
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomPinView else { return }
        let tag = customMarkerView.tag
        restaurantTapped(tag: tag)
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomPinView else { return }
        let img = customMarkerView.image!
        let customMarker = CustomPinView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.darkGray, tag: customMarkerView.tag)
        marker.iconView = customMarker
    }
    
    //MARK: - Show markers on map
    
    func showPartyMarkers(lat: Double, long: Double) {
        myMapView.clear()
        for i in 0..<3 {
            let randNum = Double(arc4random_uniform(30))/10000
            let marker = GMSMarker()
            let customMarker = CustomPinView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: previewDemoData[i].image, borderColor: UIColor.darkGray, tag: i)
            marker.iconView=customMarker
            let randInt = arc4random_uniform(4)
            if randInt == 0 {
                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long-randNum)
            } else if randInt == 1 {
                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long+randNum)
            } else if randInt == 2 {
                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long-randNum)
            } else {
                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long+randNum)
            }
            marker.map = self.myMapView
        }
    }
    
    @objc func btnMyLocationAction() {
        let location: CLLocation? = myMapView.myLocation
        if location != nil {
            myMapView.animate(toLocation: (location?.coordinate)!)
        }
    }
    
    @objc func restaurantTapped(tag: Int) {
        let view = DetailViewController()
        view.passedData = previewDemoData[tag]
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func setupTextField(textField: UITextField, img: UIImage){
        textField.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = img
        let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
        paddingView.addSubview(imageView)
        textField.leftView = paddingView
    }
    
    func setupViews() {
        view.addSubview(myMapView)
        NSLayoutConstraint.activate([
        myMapView.topAnchor.constraint(equalTo: view.topAnchor),
        myMapView.leftAnchor.constraint(equalTo: view.leftAnchor),
        myMapView.rightAnchor.constraint(equalTo: view.rightAnchor),
        myMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 60)
        ])
        self.view.addSubview(textFieldSearch)
        NSLayoutConstraint.activate([
        textFieldSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        textFieldSearch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
        textFieldSearch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
        textFieldSearch.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        setupTextField(textField: textFieldSearch, img: #imageLiteral(resourceName: "Share"))
        
        previewView = PreviewView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 190))
        
        self.view.addSubview(buttonMyLocation)
        NSLayoutConstraint.activate([
        buttonMyLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        buttonMyLocation.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        buttonMyLocation.widthAnchor.constraint(equalToConstant: 50),
        buttonMyLocation.heightAnchor.constraint(equalTo: buttonMyLocation.widthAnchor)
        ])
    }
    
   
}
