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



@interface ConnectViewController : UIViewController <UITextFieldDelegate, OSCConnectionDelegate > {
    
    
    NSString *ip;
    NSNumber *port;
    NSString *ID;
    CMMotionManager *motionManager;
   
    AVAudioRecorder *audioRecorder;
    AVAudioSession *audioSession;
    UITextField *iptextField;
    UITextField *porttextField;
    UITextField *idtextField;
  

}


@property (nonatomic, retain) NSString* ip;
@property (nonatomic, retain) NSNumber* port;

@property OSCConnection *connection;
@property (nonatomic, retain) NSTimer *timer;


- (IBAction)cbuttonPressed:(UIButton *)button;
- (IBAction)dbuttonPressed:(UIButton *)button;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (void)resetView;

- (NSString *)getIPAddress;




@end



