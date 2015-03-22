//
//  ViewController.h
//  RIME
//
//  Created by David on 3/8/15.
//  Copyright (c) 2015 David. All rights reserved.
//
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "OSCConnectionDelegate.h"
#import "ConnectViewController.h"

//#import "ConnectivityInfo.h"
@class OSCConnection;

@interface ViewController : UIViewController <UITextFieldDelegate, OSCConnectionDelegate>{
    NSString *ip;
    long port;
    
    
    //ConnectViewController *appDel;
}


@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, retain) IBOutlet UIView *mrView;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) NSString *stringID;
@property OSCConnection *connection;



-(IBAction)buttonReleased:(id)sender;
-(IBAction)buttonPressing:(id)sender;
- (IBAction)TbuttonReleased:(UIButton*)button withEvent:(UIEvent *)event;

- (IBAction)sliderAction:(UISlider *)slider;
- (void) createButton:(NSString *) bnumber xposition:(float) x yposition:(float) y
                height:(float) height width:(float)width addressPat: (NSString *) addressPat;
- (void) createTButton:(NSString*) bname xposition:(float) x yposition:(float) y
                height:(float) height width:(float)width addressPat: (NSString *) addressPat;
-(void) createHSlider:(NSString *) stitle xposition:(int)x yposition:(int)y height:(int)height width:(int)width to:(int)to from:(int)from addressPat: (NSString *) addressPat;
-(void) createVSlider:(NSString *) stitle xposition:(int)x yposition:(int)y height:(int)height width:(int)width to:(int)to from:(int)from addressPat: (NSString *) addressPat;
-(void)gotoConnection;
-(void)getControls;
-(void) saveControls:(CGFloat) debtAmount forName:(NSString *) ControlName;
-(void)readJSON:(NSString *) jsonString;
-(void)loadUI;
-(void)writeJSON;
-(void)readtest;
-(void)resetView;
-(void)portBind;

@end


@interface UIButton(Property)

@property (nonatomic, retain) NSString *property;

@end

@interface UISlider(Property)

@property (nonatomic, retain) NSString *property;

@end
@interface UISwitch(Property)

@property (nonatomic, retain) NSString *property;

@end


//@interface ConnectViewController : UIViewController <UINavigationControllerDelegate> {
//    //UIButton *UIButton *gotoAnotherView;;
//    //AnotherViewController *anotherView;
//    ConnectViewController *connectView;
//   
//}

