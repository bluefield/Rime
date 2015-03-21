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
#import <GCDAsyncUdpSocket.h>



//@synthesize connectView;

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

//- (void)ConnectViewControllerDidFinish:(ConnectViewController*)connectViewController
//{
//    //NSArray* someArray = secondViewController.someArray
//    // Do something with the array
//    //ip= connectViewController.ip;
//    ip=appDel.ip;
//    
//    long tempPort =[appDel.port longValue];
//    //[connectViewController.port longValue];
//    port=tempPort;
//    NSLog(@"back to main page and ip:%@ port:%ld", ip, port);
//    
//}
    ConnectViewController *appDel;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error = nil;
    [self saveControls:200 forName:@"David"];
    [self getControls];

    
    
    appDel=(ConnectViewController *)[[UIApplication sharedApplication]delegate];
    
  
   
    
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
    self.connection = [[OSCConnection alloc] init];
    self.connection.delegate = self;
   self.connection.continuouslyReceivePackets = YES;
    
    
    if (![self.connection bindToAddress:nil port:11000 error:&error])
    {
        NSLog(@"Could not bind UDP connection: %@", error);
    }
    [self.connection receivePacket];

    
    
//------------------------test view setup---------------
    self.textField = [[UITextField alloc]
                      initWithFrame:CGRectMake(10.0f, 30.0f,300.0f, 30.0f)];
    [self.view addSubview:self.textField];
    //button function
    UIButton *button =
    [UIButton buttonWithType:UIButtonTypeCustom];
     button.frame = CGRectMake(110.0f, 200.0f, 100.0f, 40.0f);
     [button setBackgroundImage:[UIImage imageNamed:@"blueButton.png"] forState:UIControlStateNormal];
    
    button.property=@"button0";
    [button addTarget:self
               action:@selector(buttonReleased:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"button0" forState:UIControlStateNormal];
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
    
    UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(10, 110, 0, 0)];
    [mySwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mySwitch];
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

- (IBAction)buttonPressing:(UIButton*)button {
    OSCMutableMessage *message = [[OSCMutableMessage alloc] init];
    message.address = @"/button";
    [message addString:button.property];
    [message addInt:1];
    [self.connection sendPacket:message toHost:ip port:port];
    NSLog(@"Button is being Pressed!");
    
}
//button pressed action-----------------------
- (IBAction)buttonReleased:(UIButton*)button {
    
    //goes to a the Connection Setup Page
    if(button.property==NULL){

        NSLog(@"Button Pressed!");
        
    }
    
    
   NSLog(@"Button Pressed!");
    [self createButton: @"button1" xposition:0.0 yposition:(350.0) height:(100.0) width:40.0];
    [self createVSlider:@"Testslider" xposition:10 yposition:450 height:300 width:20];
    [self createHSlider:@"Testslider2" xposition:10 yposition:400 height:300 width:20];

 
    NSLog(@"button ID is:%@", button.property);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    ip=[defaults objectForKey:@"ip"];
    NSNumber *tempPort=[defaults objectForKey:@"port"];
    port = [tempPort longValue];
  
    OSCMutableMessage *message = [[OSCMutableMessage alloc] init];
    message.address = @"/button";
    [message addString:button.property];
    [message addInt:0];
    [self.connection sendPacket:message toHost:ip port:port];
    NSLog(@"ip:%@ port:%ld", ip, port);

}

//slider action---------------------------

- (IBAction)sliderAction:(UISlider *)slider {
    
    NSLog(@"val: %f",slider.value);
    NSLog(@"slider ID is:%@", slider.property);
    OSCMutableMessage *message = [[OSCMutableMessage alloc] init];
    message.address = @"/slider";
    [message addString:@"testslider"];
    [message addFloat:slider.value];

    [self.connection sendPacket:message toHost:ip port:port];
   
}
- (void)changeSwitch:(id)sender{
    if([sender isOn]){
        // Execute any code when the switch is ON
        NSLog(@"Switch is ON");
    } else{
        // Execute any code when the switch is OFF
        NSLog(@"Switch is OFF");
    }
}

//------------------Create Controls functions---------------------------------

- (void) createButton:(NSString*) bname xposition:(float) x yposition:(float) y
                height:(float) height width:(float)width {
  
   UIButton *button =
    [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"blueButton.png"] forState:UIControlStateNormal];

    button.frame = CGRectMake(x, y, height, width);
    [button addTarget:self
               action:@selector(buttonReleased:)
     forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self
               action:@selector(buttonPressing:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:bname forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[button setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:button];
    button.property=bname;
    //button.tag=bnumber;
    
    //NSLog(@"button id is: %d", button.tag);
    

}

-(void) createVSlider:(NSString *) stitle xposition:(int)x yposition:(int)y height:(int)height width:(int)width{
    
    CGRect frame = CGRectMake(x, y, height, width);
    UISlider *slider = [[UISlider alloc] initWithFrame:frame];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = 0.0;
    slider.maximumValue = 50.0;
    slider.continuous = YES;
    slider.value = 25.0;
    slider.property=stitle;
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * 0.5);
    slider.transform = trans;
    [self.view addSubview:slider];
}
-(void) createHSlider:(NSString *) stitle xposition:(int)x yposition:(int)y height:(int)height width:(int)width{
    
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

//ConnectViewController *connectView = [[ConnectViewController alloc] init];
-(void)gotoConnection{
    ConnectViewController *connectView = [[ConnectViewController alloc] init];
    [self.navigationController pushViewController:connectView animated:NO];
}

- (void)oscConnection:(OSCConnection *)con didReceivePacket:(OSCPacket *)packet fromHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"Received Data:%@", [packet.arguments description]);
    NSLog(@"From:%@", packet.address);
   // ((UITextField *)[window viewWithTag:kTagReceivedValue]).text = [packet.arguments description];
    //((UITextField *)[window viewWithTag:kTagLocalAddress]).text = packet.address;
}


#define DEBTS_LIST_KEY @"listOfAllDebts"
#define DEBTOR_NAME_KEY @"debtorName"
#define DEBT_AMOUNT_KEY @"amountOfDebt"

-(void) saveControls:(CGFloat) debtAmount forName:(NSString *) ControlName
{
    // pointer to standart user defaults
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    // the mutalbe array of all debts
    NSMutableArray * alldebtRecords = [[defaults objectForKey:DEBTS_LIST_KEY] mutableCopy];
    // create new record
    // to save CGFloat you need to wrap it into NSNumber
    NSNumber * amount = [NSNumber numberWithFloat:debtAmount];
    
    NSDictionary * newRecord = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:amount,ControlName, nil] forKeys:[NSArray arrayWithObjects:DEBT_AMOUNT_KEY, DEBTOR_NAME_KEY, nil]];
    [alldebtRecords addObject:newRecord];
    [defaults setObject:alldebtRecords forKey:DEBTS_LIST_KEY];
    // do not forget to save changes
    [defaults synchronize];
}
-(void)getControls{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * test=[[defaults objectForKey:DEBTS_LIST_KEY] mutableCopy];
    NSLog(@"array: %@", test);
    

}







@end
