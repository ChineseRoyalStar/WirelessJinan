//
//  GDNaviPageViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/25.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

enum TransportationMode {
    
    case ByDriving
    
    case OnFoot
    
}

class GDNaviPageViewController: UIViewController,MAMapViewDelegate, AMapSearchDelegate, UITextFieldDelegate, AMapLocationManagerDelegate {
    
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var trafficSelectedSegment: UISegmentedControl!
    
    var mapView: MAMapView!

    
    var locationManager: AMapLocationManager!
    
    var trafficMode: TransportationMode = .ByDriving
    
    var startPoint: AMapGeocode!
    
    var endPoint: AMapGeocode!
    
    var searchStart: AMapSearchAPI = AMapSearchAPI()
    
    var searchEnd: AMapSearchAPI = AMapSearchAPI()
    
    var startAntation: MAAnnotation!
    
    var endAntation: MAAnnotation!
    
    var address = NSMutableDictionary()
    
    var currentCity: String!
    
    var reGeoCodeSearchAPI: AMapSearchAPI = AMapSearchAPI()
    
    var locationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.createLocationManager()
        
        self.createMapView()
        
        self.locationBtn()
        
        self.startTextField.delegate = self
        
        self.endTextField.delegate = self
        
        self.searchStart.delegate = self
        
        self.searchEnd.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.mapView.showsUserLocation = true
        
        self.mapView.userTrackingMode = MAUserTrackingMode.FollowWithHeading
        
    }
    
    func createLocationManager() {
        
        self.locationManager = AMapLocationManager.init()
        
        locationManager.delegate = self
    
        locationManager.startUpdatingLocation()
        
    }
    
    func createMapView() -> Void {
        
        mapView = MAMapView(frame: CGRectMake(0,64,kSCREEN_W,kSCREEN_H-64-49))
        
        mapView.delegate = self
        
        mapView.mapType = .Standard
        
        mapView.pausesLocationUpdatesAutomatically = true
        
        mapView.distanceFilter = 10.0
        
        mapView.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        mapView.customizeUserLocationAccuracyCircleRepresentation = true
        
        self.view.addSubview(mapView)
        
        self.view.sendSubviewToBack(mapView)
        
    }
    
    func locationBtn() {
        
        locationButton = UIButton(frame: CGRectMake(20, CGRectGetHeight(view.bounds) - 120, 40, 40))
        
        locationButton!.autoresizingMask = [UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleTopMargin]
        
        locationButton!.backgroundColor = UIColor.whiteColor()
        
        locationButton!.layer.cornerRadius = 5
        
        locationButton!.layer.shadowColor = UIColor.blackColor().CGColor
        
        locationButton!.layer.shadowOffset = CGSizeMake(5, 5)
        
        locationButton!.layer.shadowRadius = 5
        
        locationButton!.addTarget(self, action: #selector(self.actionLocation(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        locationButton!.setImage(UIImage.init(named: "location_yes.png"), forState: UIControlState.Normal)
        
        self.view.addSubview(locationButton)
        
    }
    
    
    func actionLocation(sender: UIButton) {
        
        mapView!.setUserTrackingMode(MAUserTrackingMode.Follow, animated: true)

    }
    
    func searchGEOCode(string:String, searchAPI:AMapSearchAPI) {
        
        let request = AMapGeocodeSearchRequest.init()
        
        request.city = self.currentCity
        
        request.address = string
        
        searchAPI.AMapGeocodeSearch(request)
        
    }
    
    func searchRegeoCode(location: AMapGeoPoint) -> Void {
        
        reGeoCodeSearchAPI.delegate = self
        
        let regeoRequest = AMapReGeocodeSearchRequest.init()
        
        regeoRequest.location = location
        
        reGeoCodeSearchAPI.AMapReGoecodeSearch(regeoRequest)
    }
    
    //MARK:- ReGeoCode Search

    func onReGeocodeSearchDone(request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        
        self.currentCity = response.regeocode.addressComponent.city
        
        if response.regeocode != nil {
            
            let coordinate = CLLocationCoordinate2D.init(latitude: Double(request.location.latitude), longitude: Double(request.location.longitude))
            
            let annotation = MAPointAnnotation()
            
            annotation.coordinate = coordinate
            
            annotation.title = response.regeocode.formattedAddress
            
            annotation.subtitle = response.regeocode.addressComponent.province
            
            mapView.addAnnotation(annotation)
            
            let overlay = MACircle.init(centerCoordinate: coordinate, radius: 2000)
            
            mapView.addOverlay(overlay)
            
        }
        
    }
    
    func onGeocodeSearchDone(request: AMapGeocodeSearchRequest!, response: AMapGeocodeSearchResponse!) {
        
        for code in response.geocodes {
            
            let annotation = MAPointAnnotation.init()
            
            annotation.coordinate = CLLocationCoordinate2D.init(latitude: Double(code.location.latitude), longitude: Double(code.location.longitude))
            
            if request.address == startTextField.text {
                
                startPoint = code
                
                startPoint.district = request.address
                
                self.address.setObject(startPoint, forKey: "START")
                
                annotation.title = "起点"
                
                if startAntation != nil {
                    
                    mapView.removeAnnotation(startAntation)
                    
                }
                startAntation = annotation
                
            }else {
                
                endPoint = code
                
                endPoint.district = request.address
                
                annotation.title = "终点"
                
                self.address.setObject(endPoint, forKey: "END")
                
                if endAntation != nil {
                    
                    mapView.removeAnnotation(endAntation)
                    
                }
                
                endAntation = annotation
            }
            
            mapView.addAnnotation(annotation)
            
        }
        
    }
    
    //MARK:- UITextField Delegate Methods
    func textFieldDidEndEditing(textField: UITextField) {
        
        if textField == self.startTextField {
            
            self.searchGEOCode(self.startTextField.text!, searchAPI: self.searchStart)
            
        }else {
            
            self.searchGEOCode(self.endTextField.text!, searchAPI: self.searchEnd)
            
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.startTextField.resignFirstResponder()
        
        self.endTextField.resignFirstResponder()
        
        return true
    }
    
    
    //MARK:- AMapView Delegate Methods
    
    func mapView(mapView: MAMapView!, didTouchPois pois: [AnyObject]!) {
        
        self.startTextField.resignFirstResponder()
        
        self.endTextField.resignFirstResponder()
        
    }
    
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        
        if annotation.coordinate.latitude == mapView.userLocation.coordinate.latitude && annotation.coordinate.longitude == mapView.userLocation.coordinate.longitude {
            
           return nil
        }
        
        let id = "Annotation"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(id)
        
        if pinView == nil {
            
            pinView = MAPinAnnotationView.init(annotation: annotation, reuseIdentifier:id)
            
        }
        
        pinView.canShowCallout = true
        
        pinView.annotation = annotation
        
        return pinView
    }
    
    
    
    func mapView(mapView: MAMapView!, regionDidChangeAnimated animated: Bool) {
        
        self.mapView.removeFromSuperview()
        
        self.view.addSubview(mapView)
        
        self.view.sendSubviewToBack(self.mapView)
        
    }

    
    func mapView(mapView: MAMapView!, rendererForOverlay overlay: MAOverlay!) -> MAOverlayRenderer! {
        
        if overlay.isKindOfClass(MACircle) {
            
            let renderer: MACircleRenderer = MACircleRenderer.init(overlay: overlay)
            
            renderer.fillColor = kSKY_BLUE.colorWithAlphaComponent(0.4)
            
            renderer.lineWidth = 2.0
            
            return renderer
            
        }
        
        return  nil
    }
    
    func mapView(mapView: MAMapView!, didChangeUserTrackingMode mode: MAUserTrackingMode, animated: Bool) {
        
        if mode == MAUserTrackingMode.None {
            locationButton?.setImage(UIImage.init(named: "location_yes.png"), forState: UIControlState.Normal)
        }
        else {
            locationButton?.setImage(UIImage.init(named: "location_no.png"), forState: UIControlState.Normal)
        }
        
    }
    
    
    @IBAction func transportationChange(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            
            self.trafficMode = .ByDriving
            
        case 1:
            
            self.trafficMode = .OnFoot
            
        default:
            
            self.trafficMode = .ByDriving
            break
        }
        
    }
    
    @IBAction func startNaviBtnClick(sender: AnyObject) {
        
        if address.allKeys.count == 2 && self.startPoint.district == self.startTextField.text && self.endPoint.district == self.endTextField.text {
            
            if self.trafficMode == .ByDriving {
                
                let driveVC = GDDrivingViewController()
                
                driveVC.startPoint = AMapNaviPoint.locationWithLatitude(startPoint.location.latitude, longitude: startPoint.location.longitude)
                
                driveVC.endPoint = AMapNaviPoint.locationWithLatitude(endPoint.location.latitude, longitude:endPoint.location.longitude)
                
                self.presentViewController(driveVC, animated: true, completion: nil)
                
            }else {
                
                let walkVC = GDWalkingViewController()
                
                walkVC.startPoint = AMapNaviPoint.locationWithLatitude(startPoint.location.latitude, longitude: startPoint.location.longitude)
                
                walkVC.endPoint = AMapNaviPoint.locationWithLatitude(endPoint.location.latitude, longitude:endPoint.location.longitude)
                
                self.presentViewController(walkVC, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        
        mapView.setCenterCoordinate(location.coordinate, animated: false)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
