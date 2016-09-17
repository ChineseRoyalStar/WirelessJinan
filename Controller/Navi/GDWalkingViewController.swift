//
//  GDWalkingViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class GDWalkingViewController: UIViewController, AMapNaviWalkViewDelegate, AMapNaviWalkManagerDelegate, AMapNaviWalkDataRepresentable {

    var walkingView: AMapNaviWalkView!
    
    var walkingManager: AMapNaviWalkManager!
    
    var startPoint: AMapNaviPoint!
    
    var endPoint: AMapNaviPoint!
    
    var speech = SpeechSynthesizer.sharedSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createWalkView()
        
        self.createWalkingManager()
        
        self.calculateRoute()

    }

    func createWalkView() -> Void {
        
        walkingView = AMapNaviWalkView.init(frame: self.view.bounds)
        
        walkingView.delegate = self
        
        self.view.addSubview(walkingView)
        
    }
    
    func createWalkingManager() -> Void {
        
        walkingManager = AMapNaviWalkManager.init()
        
        walkingManager.delegate = self
        
        walkingManager.addDataRepresentative(walkingView)
        
        walkingManager.addDataRepresentative(self)
        
    }
    
    func calculateRoute() -> Void {
        
        walkingManager.calculateWalkRouteWithStartPoints([self.startPoint], endPoints: [self.endPoint])
        
    }
    
    func walkManagerOnCalculateRouteSuccess(walkManager: AMapNaviWalkManager) {
        
        walkingManager.startGPSNavi()
        
    }
    
    func walkManager(walkManager: AMapNaviWalkManager, onCalculateRouteFailure error: NSError) {
        
    }
    
    func walkManager(walkManager: AMapNaviWalkManager, didStartNavi naviMode: AMapNaviMode) {
        
    }
    
    func walkManager(walkManager: AMapNaviWalkManager, playNaviSoundString soundString: String, soundStringType: AMapNaviSoundType) {
        
        if soundStringType == AMapNaviSoundType.PassedReminder {
            
            AudioServicesPlayAlertSound(1009)
        }else {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { 
                self.speech.speakString(soundString)
            })
        }
    }
    
    func walkViewCloseButtonClicked(walkView: AMapNaviWalkView) {
        
        self.speech.stopSpeak()
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
