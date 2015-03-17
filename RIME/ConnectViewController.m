//
//  ConnectViewController.m
//  RIME
//
//  Created by David on 3/8/15.
//  Copyright (c) 2015 David. All rights reserved.
//

#import "ConnectViewController.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "Sensors.h"



@import Foundation;


@interface ConnectViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *labelip;
@property (nonatomic, strong) UILabel *labelport;
@property (nonatomic, strong) UILabel *labelid;



@end

@implementation ConnectViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Connection Set Up";
 

    NSError *error = nil;
    //---------------bind to UDPserver------------
    self.connection = [[OSCConnection alloc] init];
    self.connection.delegate = self;
    //[self.connection bindToAddress:@"206.87.154.16" port:12000 error:&error];
    
    if (![self.connection bindToAddress:nil port:12000 error:&error])
    {
        NSLog(@"Could not bind UDP connection: %@", error);
    }

    //------------------------------------------------
    
    
    
    //-------Connect View content------------------------------------------------
//    self.label = [[UILabel alloc]
//                  initWithFrame:CGRectMake(90.0f, 60.0f, 200.0f, 30.0f)];
//    self.label.text = @"Connection Setup";
    
    self.labelip = [[UILabel alloc]
                  initWithFrame:CGRectMake(10.0f, 100.0f, 200.0f, 30.0f)];
    self.labelip.text = @"IP Address:";
    self.labelport = [[UILabel alloc]
                    initWithFrame:CGRectMake(10.0f, 130.0f, 200.0f, 30.0f)];
    self.labelport.text = @"Port:";
    
    self.labelid = [[UILabel alloc]
                      initWithFrame:CGRectMake(10.0f, 160.0f, 200.0f, 30.0f)];
    self.labelid.text = @"Device ID:";
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 35.0f)];
    toolbar.barStyle=UIBarStyleBlackOpaque;
    
    // Create a flexible space to align buttons to the right
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    // Create a cancel button to dismiss the keyboard
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resetView)];
    
    // Add buttons to the toolbar
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpace, barButtonItem, nil]];
    
    // Set the toolbar as accessory view of an UITextField object
    
    
    
    iptextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 100, 200, 30)];
    iptextField.borderStyle = UITextBorderStyleRoundedRect;
    iptextField.font = [UIFont systemFontOfSize:15];
    iptextField.placeholder = @"enter IP";
    iptextField.keyboardType=UIKeyboardTypeDecimalPad;       // A number pad including a decimal point
    iptextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    iptextField.delegate = self;
    iptextField.inputAccessoryView = toolbar;
    
    
    porttextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 130, 200, 30)];
    porttextField.borderStyle = UITextBorderStyleRoundedRect;
    porttextField.font = [UIFont systemFontOfSize:15];
    porttextField.placeholder = @"enter PORT number";
    porttextField.keyboardType=UIKeyboardTypeDecimalPad;
    porttextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    porttextField.delegate = self;
    porttextField.inputAccessoryView = toolbar;
    
    
    idtextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 160, 200, 30)];
    idtextField.borderStyle = UITextBorderStyleRoundedRect;
    idtextField.font = [UIFont systemFontOfSize:15];
    idtextField.placeholder = @"enter DEVICE ID";
    idtextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    idtextField.delegate = self;
    
    
    UIButton *connectbutton =
    [UIButton buttonWithType:UIButtonTypeCustom];
    
    connectbutton.frame = CGRectMake(90.0f, 210.0f, 100.0f, 40.0f);
    [connectbutton addTarget:self
               action:@selector(cbuttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [connectbutton setTitle:@"Connect" forState:UIControlStateNormal];
    [connectbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[connectbutton setBackgroundColor:[UIColor blackColor]];
    [connectbutton setBackgroundImage:[UIImage imageNamed:@"blackButton.png"] forState:UIControlStateNormal];
    
    [self.view addSubview:idtextField];
    [self.view addSubview:iptextField];
    [self.view addSubview:porttextField];
    [self.view addSubview:self.labelid];
    [self.view addSubview:self.labelport];
    [self.view addSubview:self.labelip];

    [self.view addSubview:self.label];
    [self.view addSubview:connectbutton];
   //---------------------------------------------------------------------------------------
    
    
    
    
    
    //-----------------------------Sensors Initialization ---------------------
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"sound.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    
    
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    
    
    audioRecorder = [[AVAudioRecorder alloc]
                     initWithURL:soundFileURL
                     settings:recordSettings
                     error:&error];
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        [audioRecorder prepareToRecord];
    }
    audioRecorder.meteringEnabled = YES;
    
    audioSession = [AVAudioSession sharedInstance];
    
    [audioSession setCategory:AVAudioSessionCategoryRecord error: nil];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: nil];
    [audioSession setActive:YES error: nil];
    [audioRecorder updateMeters];
    [audioRecorder record];
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 0.01;
    [motionManager startAccelerometerUpdates];
    [motionManager startGyroUpdates];
    [motionManager startDeviceMotionUpdates];
    [motionManager startMagnetometerUpdates];
    motionManager.gyroUpdateInterval = 0.01;
    motionManager.magnetometerUpdateInterval =0.01;
    //---------------------------------------------------------------------------------------
    
    

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//connect button action
- (IBAction)cbuttonPressed:(UIButton *)button {
   
     NSLog(@"ConnectButton Pressed!");
    ip= iptextField.text;
    port= [porttextField.text integerValue];
    ID =idtextField.text;

    
    //[AppDelegate timer];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.2f
                                             target:self
                                           selector:@selector(updateMotionData:)
                                           userInfo:nil
                                            repeats:YES];


    
}

//make keyboard dissapear when return is pressed

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

//retrieve sensor data and sends them in OSC formatt
- (void)updateMotionData:(NSTimer *)timer {
    
    NSLog(@"Accel: x = %f, y = %f, z = %f.", motionManager.accelerometerData.acceleration.x, motionManager.accelerometerData.acceleration.y, motionManager.accelerometerData.acceleration.z);
    
    
    OSCMutableMessage *message = [[OSCMutableMessage alloc] init];
    message.address = @"/Accel:";
    [message addFloat:motionManager.accelerometerData.acceleration.x];
    [message addFloat:motionManager.accelerometerData.acceleration.y];
    
    
    
    float x=motionManager.deviceMotion.userAcceleration.x;
    float y=motionManager.deviceMotion.userAcceleration.y;
    float z=motionManager.deviceMotion.userAcceleration.z;
    NSLog(@"User Accel: x = %f, y = %f, z = %f.", x, y, z);
    
    //------orientation-----------------------
    
    float roll=motionManager.deviceMotion.attitude.roll;
    [message addFloat:roll];
    float pitch=motionManager.deviceMotion.attitude.pitch;
    float yaw=motionManager.deviceMotion.attitude.yaw;
    NSLog(@"Orientation: x = %f, y = %f, z = %f.", roll, pitch, yaw);
    //---------Gyroscope----------------------------
    float gyroX=motionManager.gyroData.rotationRate.x;
    float gyroY=motionManager.gyroData.rotationRate.y;
    float gyroZ=motionManager.gyroData.rotationRate.z;
    NSLog(@"Gyro: x = %f, y = %f, z = %f.", gyroX, gyroY, gyroZ);
    //----------Gravity--------------------------------
    float gravityX=motionManager.deviceMotion.gravity.x;
    float gravityY=motionManager.deviceMotion.gravity.y;
    float gravityZ=motionManager.deviceMotion.gravity.z;
    NSLog(@"Gravity: x = %f, y = %f, z = %f.", gravityX, gravityY, gravityZ);
    
    //------------rotationRate---------------------------
    //gyroData.rotationRate.x;
    float rotationRateX=motionManager.deviceMotion.rotationRate.x;
    float rotationRateY=motionManager.deviceMotion.rotationRate.y;
    float rotationRateZ=motionManager.deviceMotion.rotationRate.z;
    NSLog(@"RotationRate: x = %f, y = %f, z = %f.", rotationRateX, rotationRateY, rotationRateZ);
    
    //--------------audioMeter------------------------------
    
    float averagedBLevel = [audioRecorder averagePowerForChannel:0];
    float peakdBLevel = [audioRecorder peakPowerForChannel:0];
    NSLog(@"dBLevel: x = %f, y = %f", averagedBLevel, peakdBLevel);
    
    
    [self.connection sendPacket:message toHost:ip port:port];//send final sensor data message here
    
}
//function make numkeyboard dissapear when "DONE" is pressed
- (void)resetView{
    [iptextField resignFirstResponder];
    [porttextField resignFirstResponder];

}








@end
