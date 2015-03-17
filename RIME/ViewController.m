//
//  ViewController.m
//  RIME
//
//  Created by David on 3/8/15.
//  Copyright (c) 2015 David. All rights reserved.
//

#import "ViewController.h"
#import "ConnectViewController.h"
#import <objc/runtime.h>
#import "CocoaOSC.h"
#import "CoreDataHelper.h"
#import "AsyncUdpSocket.h"
#import "Sensors.h"
#import <CoreMotion/CoreMotion.h>



@interface ViewController ()



@end
//-----------------------Control Property----------------------------------
@implementation UIButton(Property)

static char UIB_PROPERTY_KEY;

@dynamic property;

-(void)setProperty:(NSString *)property
{
    objc_setAssociatedObject(self, &UIB_PROPERTY_KEY, property, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString*)property
{
    return (NSString*)objc_getAssociatedObject(self, &UIB_PROPERTY_KEY);
}

@end

@implementation UISlider(Property)

static char UIB_PROPERTY_KEY;

@dynamic property;

-(void)setProperty:(NSString *)property
{
    objc_setAssociatedObject(self, &UIB_PROPERTY_KEY, property, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString*)property
{
    return (NSString*)objc_getAssociatedObject(self, &UIB_PROPERTY_KEY);
}

@end
//-------------------------------------------------------------------------------------

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RIME";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0.0f, 0.0f, 50.0f, 30.0f)];
    [btn setTitle:@"Connect" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];

    [btn addTarget:self action:@selector(gotoConnection) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"blueButton.png"] forState:UIControlStateNormal];
    UIBarButtonItem *eng_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = eng_btn;
    
    
//    UIBarButtonItem *cButton = [[UIBarButtonItem alloc]
//                                   initWithTitle:@"Connect"
//                                   style:UIBarButtonItemStylePlain
//                                   target:self
//                                   action:@selector(gotoConnection)];
//
//    [cButton setImage:[UIImage imageNamed:@"blueButton.png"] ];
   

    //self.navigationItem.rightBarButtonItem = cButton;

   
    //UDP Connection Set Up-------------------
//    self.connection = [[OSCConnection alloc] init];
//    self.connection.delegate = self;
//    
//    NSError *error;
//    if (![self.connection bindToAddress:nil port:12000 error:&error])
//    {
//        NSLog(@"Could not bind UDP connection: %@", error);
//    }
    
    
//------------------------test view setup---------------
    self.textField = [[UITextField alloc]
                      initWithFrame:CGRectMake(10.0f, 30.0f,300.0f, 30.0f)];
    [self.view addSubview:self.textField];
    //button function
    UIButton *button =
    [UIButton buttonWithType:UIButtonTypeCustom];
     button.frame = CGRectMake(110.0f, 200.0f, 100.0f, 40.0f);
     [button setBackgroundImage:[UIImage imageNamed:@"blueButton.png"] forState:UIControlStateNormal];
    

    [button addTarget:self
               action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Press Me!" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[button setBackgroundColor:[UIColor blueColor]];

    
    //label function
    self.label = [[UILabel alloc]
                  initWithFrame:CGRectMake(115.0f, 150.0f, 200.0f, 30.0f)];
    self.label.text = @"Hello World!";
        [self.view addSubview:self.label];
   //self.navigationItem.title= @"ViewController";
   
    //slider function
  
        CGRect frame = CGRectMake(10, 240, 100.0, 50.0);
        UISlider *slider = [[UISlider alloc] initWithFrame:frame];
        [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [slider setBackgroundColor:[UIColor clearColor]];
        slider.minimumValue = 0.0;
        slider.maximumValue = 50.0;
        slider.continuous = YES;
        slider.value = 25.0;
    
    //text field
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 70, 300, 40)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholder = @"enter text";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //textField.delegate = self;
    [self.view addSubview:textField];
    
    
        [self.view addSubview:slider];
        [self.view addSubview:button];
    
   [self createButton: @"button2" xposition:0.0 yposition:(300.0) height:(100.0) width:40.0];
    //----------------------------------------------------------------------------------
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//----------------------------------Controll Actions-------------------------------

- (IBAction)buttontest:(UIButton*)button {
   
    NSLog(@"Button is being Pressed!");
}
//button pressed action-----------------------
- (IBAction)buttonPressed:(UIButton*)button {
    
    //goes to a the Connection Setup Page
    if(button.property==NULL){
//        ConnectViewController *connectView = [[ConnectViewController alloc] init];
//        [self.navigationController pushViewController:connectView animated:NO];
        NSLog(@"Button Pressed!");
        
    }
    
    
   NSLog(@"Button Pressed!");
    [self createButton: @"button1" xposition:0.0 yposition:(350.0) height:(100.0) width:40.0];
    [self createSlider:@"Testslider" xposition:10 yposition:450 height:300 width:20];
    //NSString *id = [button property];
    
    NSLog(@"button ID is:%@", button.property);
    OSCMutableMessage *message = [[OSCMutableMessage alloc] init];
    message.address = @"/button";
    [message addString:@"test0000088888"];
    [self.connection sendPacket:message toHost:@"206.87.157.28" port:12000];
    


}

//slider action---------------------------

- (IBAction)sliderAction:(UISlider *)slider {
    
    NSLog(@"val: %f",slider.value);
    NSLog(@"slider ID is:%@", slider.property);
   
}

//------------------Create Controls functions---------------------------------

- (void) createButton:(NSString*) bnumber xposition:(float) x yposition:(float) y
                height:(float) height width:(float)width {
  
   UIButton *button =
    [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"blackButton.png"] forState:UIControlStateNormal];

    button.frame = CGRectMake(x, y, height, width);
    [button addTarget:self
               action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self
               action:@selector(buttontest:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[button setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:button];
    button.property=bnumber;
    //button.tag=bnumber;
    
    //NSLog(@"button id is: %d", button.tag);
    

}

-(void) createSlider:(NSString *) stitle xposition:(int)x yposition:(int)y height:(int)height width:(int)width{
    
    CGRect frame = CGRectMake(x, y, height, width);
    UISlider *slider = [[UISlider alloc] initWithFrame:frame];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = 0.0;
    slider.maximumValue = 50.0;
    slider.continuous = YES;
    slider.value = 25.0;
    slider.property=stitle;
    [self.view addSubview:slider];
}
-(void)gotoConnection{
    ConnectViewController *connectView = [[ConnectViewController alloc] init];
    [self.navigationController pushViewController:connectView animated:NO];
}







@end
