//
//  GDTrafficSituationViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/9/5.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class GDTrafficSituationViewController: UIViewController, MAMapViewDelegate, AMapLocationManagerDelegate{
    
    var mapView: MAMapView!
    
    var locationManager: AMapLocationManager!
    
    var locationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.createMapView()
        
        self.createLocationManager()
        
        self.locationBtn()
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
        
        mapView = MAMapView(frame: CGRectMake(0,64,kSCREEN_W,kSCREEN_H-64))
        
        mapView.delegate = self
        
        mapView.mapType = .Standard
        
        mapView.pausesLocationUpdatesAutomatically = true
        
        mapView.showTraffic = true
        
        mapView.distanceFilter = 10.0
        
        mapView.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        mapView.customizeUserLocationAccuracyCircleRepresentation = true
        
        self.view.addSubview(mapView)
        
        self.view.sendSubviewToBack(mapView)
    }
    
    func locationBtn() {
        
        locationButton = UIButton(frame: CGRectMake(20, CGRectGetHeight(view.bounds) - 80, 40, 40))
        
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
        
        mapView!.setUserTrackingMode(MAUserTrackingMode.Follow, animated: false)
        
    }
    
    func mapView(mapView: MAMapView!, didChangeUserTrackingMode mode: MAUserTrackingMode, animated: Bool) {
        
        if mode == MAUserTrackingMode.None {
            locationButton?.setImage(UIImage.init(named: "location_yes.png"), forState: UIControlState.Normal)
        }
        else {
            locationButton?.setImage(UIImage.init(named: "location_no.png"), forState: UIControlState.Normal)
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
