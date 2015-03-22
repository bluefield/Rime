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
//@synthesize delegate;
@synthesize ip;
@synthesize port;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Connection Set Up";
    



    NSError *error = nil;
    //---------------bind to UDPserver------------
//    self.connection = [[OSCConnection alloc] init];
//    self.connection.delegate = self;
//    //[self.connection bindToAddress:@"206.87.154.16" port:12000 error:&error];
//    
//    if (![self.connection bindToAddress:nil port:12000 error:&error])
//    {
//        NSLog(@"Could not bind UDP connection: %@", error);
//    }

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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([[defaults objectForKey:@"ip"] isEqual:NULL]){
        [defaults setObject:@"192.168.1.1" forKey:@"ip"];
    }
   
    
    ip=[defaults objectForKey:@"ip"];
    iptextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 100, 200, 30)];
    iptextField.borderStyle = UITextBorderStyleRoundedRect;
    iptextField.font = [UIFont systemFontOfSize:15];
    iptextField.placeholder = @"enter IP";
    iptextField.keyboardType=UIKeyboardTypeDecimalPad;       // A number pad including a decimal point
    iptextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    iptextField.delegate = self;
    iptextField.inputAccessoryView = toolbar;
    if ([iptextField.text length] > 0 || iptextField.text != nil || [iptextField.text isEqual:@""] == FALSE)
    {
        iptextField.text=[iptextField.text stringByAppendingString:ip];
    }
   
    if([defaults objectForKey:@"port"]==NULL){
        NSString *temp=@"12000";
        NSNumber *tempDefault;
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        tempDefault=[f numberFromString:temp];
        
        [defaults setObject: tempDefault forKey:@"port"];
    }
    
    port=[defaults objectForKey:@"port"];
    porttextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 130, 200, 30)];
    porttextField.borderStyle = UITextBorderStyleRoundedRect;
    porttextField.font = [UIFont systemFontOfSize:15];
    porttextField.placeholder = @"enter PORT number";
    porttextField.keyboardType=UIKeyboardTypeDecimalPad;
    porttextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    porttextField.delegate = self;
    porttextField.inputAccessoryView = toolbar;
    if ([porttextField.text length] > 0 || porttextField.text != nil || [porttextField.text isEqual:@""] == FALSE)
    {
        NSString *myString = [port stringValue];
        porttextField.text=[porttextField.text stringByAppendingString:myString];
    }
    if([[defaults objectForKey:@"ID"]isEqual:NULL]){
        [defaults setObject:@"David" forKey:@"ID"];
    }
    
    ID=[defaults objectForKey:@"ID"];
    idtextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 160, 200, 30)];
    idtextField.borderStyle = UITextBorderStyleRoundedRect;
    idtextField.font = [UIFont systemFontOfSize:15];
    idtextField.placeholder = @"enter DEVICE ID";
    idtextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    idtextField.delegate = self;
    if ([idtextField.text length] > 0 || idtextField.text != nil || [idtextField.text isEqual:@""] == FALSE)
    {
        idtextField.text=[idtextField.text stringByAppendingString:ID];
    }
    
    
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
    //[[AVAudioSession sharedInstance]
    //setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    //[audioSession setCategory:AVAudioSessionCategoryRecord error: nil];
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
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    port = [f numberFromString:porttextField.text];
    //port= porttextField.text;
    ID =idtextField.text;

    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.06f
                                             target:self
                                           selector:@selector(updateMotionData:)
                                           userInfo:nil
                                            repeats:YES];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:ip forKey:@"ip"];
    [defaults setObject:ID forKey:@"ID"];
    [defaults setObject:port forKey:@"port"];
    
    //iptextField.text=[iptextField.text stringByAppendingString:ip];
    
    self.connection = [[OSCConnection alloc] init];
    self.connection.delegate = self;
    //[self.connection bindToAddress:@"206.87.154.16" port:12000 error:&error];
    NSError *error = nil;
    long tempPort = [port longValue];
    if (![self.connection bindToAddress:nil port:tempPort error:&error])
    {
        NSLog(@"Could not bind UDP connection: %@", error);
    }

    
    //[delegate ConnectViewControllerDidFinish:self];

    
}

//make keyboard dissapear when return is pressed

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

//retrieve sensor data and sends them in OSC formatt
- (void)updateMotionData:(NSTimer *)timer {
    
    //NSLog(@"Sensors: x = %f, y = %f, z = %f.", motionManager.accelerometerData.acceleration.x, motionManager.accelerometerData.acceleration.y, motionManager.accelerometerData.acceleration.z);
    
    
    OSCMutableMessage *message = [[OSCMutableMessage alloc] init];
    message.address = @"/sensors";
    [message addFloat:motionManager.accelerometerData.acceleration.x];
    [message addFloat:motionManager.accelerometerData.acceleration.y];
    [message addFloat:motionManager.accelerometerData.acceleration.z];
    
    
    
    float x=motionManager.deviceMotion.userAcceleration.x;
    float y=motionManager.deviceMotion.userAcceleration.y;
    float z=motionManager.deviceMotion.userAcceleration.z;
    [message addFloat:x];
    [message addFloat:y];
    [message addFloat:z];
    //NSLog(@"User Accel: x = %f, y = %f, z = %f.", x, y, z);
    
    //------orientation-----------------------
    
    float roll=motionManager.deviceMotion.attitude.roll;
    float pitch=motionManager.deviceMotion.attitude.pitch;
    float yaw=motionManager.deviceMotion.attitude.yaw;
    [message addFloat:roll];
    [message addFloat:pitch];
    [message addFloat:yaw];
    //NSLog(@"Orientation: x = %f, y = %f, z = %f.", roll, pitch, yaw);
    //---------Gyroscope----------------------------
    float gyroX=motionManager.gyroData.rotationRate.x;
    float gyroY=motionManager.gyroData.rotationRate.y;
    float gyroZ=motionManager.gyroData.rotationRate.z;
    [message addFloat:gyroX];
    [message addFloat:gyroY];
    [message addFloat:gyroZ];
   // NSLog(@"Gyro: x = %f, y = %f, z = %f.", gyroX, gyroY, gyroZ);
    //----------Gravity--------------------------------
    float gravityX=motionManager.deviceMotion.gravity.x;
    float gravityY=motionManager.deviceMotion.gravity.y;
    float gravityZ=motionManager.deviceMotion.gravity.z;
    [message addFloat:gravityX];
    [message addFloat:gravityY];
    [message addFloat:gravityZ];
    //NSLog(@"Gravity: x = %f, y = %f, z = %f.", gravityX, gravityY, gravityZ);
    
    //------------rotationRate---------------------------
    //gyroData.rotationRate.x;
    float rotationRateX=motionManager.deviceMotion.rotationRate.x;
    float rotationRateY=motionManager.deviceMotion.rotationRate.y;
    float rotationRateZ=motionManager.deviceMotion.rotationRate.z;
    [message addFloat:rotationRateX];
    [message addFloat:rotationRateY];
    [message addFloat:rotationRateZ];
    //NSLog(@"RotationRate: x = %f, y = %f, z = %f.", rotationRateX, rotationRateY, rotationRateZ);
    
    //--------------audioMeter------------------------------
    //uncomment below if need update
    //[audioRecorder updateMeters];
    //[audioRecorder record];
    float averagedBLevel = [audioRecorder averagePowerForChannel:0];
    float peakdBLevel = [audioRecorder peakPowerForChannel:0];
    //NSLog(@"dBLevel: x = %f, y = %f", averagedBLevel, peakdBLevel);
    
    long tempPort = [port longValue];

    [self.connection sendPacket:message toHost:ip port:tempPort];//send final sensor data message here
    
}
//function make numkeyboard dissapear when "DONE" is pressed
- (void)resetView{
    [iptextField resignFirstResponder];
    [porttextField resignFirstResponder];

}








@end
