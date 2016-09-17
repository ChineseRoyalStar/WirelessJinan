//
//  GDDrivingViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class GDDrivingViewController: UIViewController, AMapNaviDriveViewDelegate, AMapNaviDriveManagerDelegate, AMapNaviDriveDataRepresentable {

    var drivingView: AMapNaviDriveView!
    
    var drivingManager: AMapNaviDriveManager!
    
    var startPoint: AMapNaviPoint!
    
    var endPoint: AMapNaviPoint!
    
    var speech = SpeechSynthesizer.sharedSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createDriveView()
        
        self.createDrivingManager()
        
        self.calculateRoute()
        
    }
    
    func createDriveView() -> Void {
        
        drivingView = AMapNaviDriveView.init(frame: self.view.bounds)
        
        drivingView.delegate = self
        
        self.view.addSubview(self.drivingView)
        
    }
    
    func createDrivingManager() -> Void {
        
        drivingManager = AMapNaviDriveManager.init()
        
        drivingManager.delegate = self
        
        drivingManager.addDataRepresentative(drivingView)
        
        drivingManager.addDataRepresentative(self)
    }
    
    func calculateRoute() {
        
        drivingManager.calculateDriveRouteWithStartPoints([self.startPoint], endPoints: [self.endPoint], wayPoints: nil, drivingStrategy: AMapNaviDrivingStrategy.DefaultAndFastest)
    }
    
    func driveManagerOnCalculateRouteSuccess(driveManager: AMapNaviDriveManager) {
        
        //driveManager.startEmulatorNavi()
        
        driveManager.startGPSNavi()
        
    }
    
    func driveManager(driveManager: AMapNaviDriveManager, onCalculateRouteFailure error: NSError) {
        
        
    }
    
    func driveManager(driveManager: AMapNaviDriveManager, didStartNavi naviMode: AMapNaviMode) {
        
    }
    
    func driveManager(driveManager: AMapNaviDriveManager, playNaviSoundString soundString: String, soundStringType: AMapNaviSoundType) {
        
        if soundStringType == AMapNaviSoundType.PassedReminder {
            
            AudioServicesPlayAlertSound(1009)
            
        }else {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { 
                self.speech.speakString(soundString)
            })
        }
    }
    
    func driveViewCloseButtonClicked(driveView: AMapNaviDriveView) {
        
        self.speech.stopSpeak()
        
        self.dismissViewControllerAnimated(true , completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
