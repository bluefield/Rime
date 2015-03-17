//
//  ConnectViewController.h
//  RIME
//
//  Created by David on 3/8/15.
//  Copyright (c) 2015 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AppDelegate.h>
#import "CocoaOSC.h"
#import "CoreDataHelper.h"
#import "AsyncUdpSocket.h"
#import <AudioToolbox/AudioServices.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAudioSession.h>
#import <CoreMotion/CoreMotion.h>

@interface ConnectViewController : UIViewController <UITextFieldDelegate, OSCConnectionDelegate> {
    
    
    NSString *ip;
    long port;
    NSString *ID;
    CMMotionManager *motionManager;
    NSTimer *timer;
    AVAudioRecorder *audioRecorder;
    AVAudioSession *audioSession;
    UITextField *iptextField;
    UITextField *porttextField;
    UITextField *idtextField;
   

}

@property OSCConnection *connection;

- (IBAction)cbuttonPressed:(UIButton *)button;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (void)resetView;

@end


