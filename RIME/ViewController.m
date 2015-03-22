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

@implementation UISwitch(Property)

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

    ConnectViewController *appDel;

- (void)viewDidLoad {
    [super viewDidLoad];
   // NSError *error = nil;
    [self portBind];
    [self loadUI];
  
    
    
    
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
    
    UIButton *lbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lbtn setFrame:CGRectMake(0.0f, 0.0f, 50.0f, 30.0f)];
    [lbtn setTitle:@"Load UI" forState:UIControlStateNormal];
    lbtn.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [lbtn addTarget:self action:@selector(loadUI) forControlEvents:UIControlEventTouchUpInside];
    [lbtn setBackgroundImage:[UIImage imageNamed:@"blueButton.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leng_btn = [[UIBarButtonItem alloc] initWithCustomView:lbtn];
    self.navigationItem.leftBarButtonItem = leng_btn;


    
//------------------------test view setup---------------
   
    //button function
//    UIButton *button =
//    [UIButton buttonWithType:UIButtonTypeCustom];
//     button.frame = CGRectMake(110.0f, 200.0f, 100.0f, 40.0f);
//     [button setBackgroundImage:[UIImage imageNamed:@"blueButton.png"] forState:UIControlStateNormal];
//    
//    button.property=@"button0";
//    [button addTarget:self
//               action:@selector(buttonReleased:)
//     forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"button0" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    button.property=@"/pushButton";
    //[button setBackgroundColor:[UIColor blueColor]];

    
    //label function
//    self.label = [[UILabel alloc]
//                  initWithFrame:CGRectMake(115.0f, 150.0f, 200.0f, 30.0f)];
//    self.label.text = @"Hello World!";
//        [self.view addSubview:self.label];
   //self.navigationItem.title= @"ViewController";
   
    //slider function
  
//        CGRect frame = CGRectMake(10, 240, 100.0, 50.0);
//        UISlider *slider = [[UISlider alloc] initWithFrame:frame];
//        [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
//        [slider setBackgroundColor:[UIColor clearColor]];
//        slider.minimumValue = 0.0;
//        slider.maximumValue = 50.0;
//        slider.continuous = YES;
//        slider.value = 25.0;
//    
    //text field
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 70, 300, 40)];
//    textField.borderStyle = UITextBorderStyleRoundedRect;
//    textField.font = [UIFont systemFontOfSize:15];
//    textField.placeholder = @"enter text";
//    textField.autocorrectionType = UITextAutocorrectionTypeNo;
//    textField.keyboardType = UIKeyboardTypeDefault;
//    textField.returnKeyType = UIReturnKeyDone;
//    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //textField.delegate = self;
    
//    UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(10, 110, 0, 0)];
//    [mySwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
//    mySwitch.property=@"Switch0";
//    [self.view addSubview:mySwitch];
    //[self.view addSubview:textField];
    
    
        //[self.view addSubview:slider];
        //[self.view addSubview:button];
    
   //[self createButton: @"button2" xposition:0.0 yposition:(300.0) height:(40.0) width:100.0];
    //[self createTButton: @"/Tbutton1" xposition:0.0 yposition:(350.0) height:(100.0) width:40.0 addressPat:@"/toggleButton"];
    //----------------------------------------------------------------------------------
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//----------------------------------Controll Actions-------------------------------

- (IBAction)buttonPressing:(UIButton*)button {
    OSCMutableMessage *message = [[OSCMutableMessage alloc] init];
    message.address = button.property;
    //[message addString:button.property];
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
    //[self createButton: @"button1" xposition:0.0 yposition:(350.0) height:(100.0) width:40.0];
    //[self createVSlider:@"Testslider" xposition:10 yposition:450 height:300 width:20];
    //[self createHSlider:@"Testslider2" xposition:10 yposition:400 height:300 width:20];
    //[self createSwitch:@"switch1" xposition:0 yposition: 150 height:0 width:0];
 
    NSLog(@"button ID is:%@", button.property);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    ip=[defaults objectForKey:@"ip"];
    NSNumber *tempPort=[defaults objectForKey:@"port"];
    port = [tempPort longValue];
  
    OSCMutableMessage *message = [[OSCMutableMessage alloc] init];
    message.address = button.property;
    //[message addString:button.property];
    [message addInt:0];
    [self.connection sendPacket:message toHost:ip port:port];
    NSLog(@"ip:%@ port:%ld", ip, port);

}
- (IBAction)TbuttonReleased:(UIButton*)button withEvent:(UIEvent *)event {
    OSCMutableMessage *message = [[OSCMutableMessage alloc] init];
    message.address = button.property;
    //[message addString:button.property];
    
    
    if(button.selected==YES){
        [message addInt:0];
        NSLog(@"0");
    }
    else{
        [message addInt:1];
         NSLog(@"1");
    }
    [self.connection sendPacket:message toHost:ip port:port];
    
    button.selected = !button.selected;
    
}

//slider action---------------------------

- (IBAction)sliderAction:(UISlider *)slider {
    
    NSLog(@"val: %f",slider.value);
    NSLog(@"slider ID is:%@", slider.property);
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    ip=[defaults objectForKey:@"ip"];
//    NSNumber *tempPort=[defaults objectForKey:@"port"];
//    port = [tempPort longValue];
    
    
    OSCMutableMessage *message = [[OSCMutableMessage alloc] init];
    message.address = slider.property;
    //[message addString:@"testslider"];
    [message addFloat:slider.value];

    [self.connection sendPacket:message toHost:ip port:port];
   
}
- (IBAction)changeSwitch:(UISwitch *)Switch{
    
    if([Switch isOn]){
        // Execute any code when the switch is ON
        OSCMutableMessage *message = [[OSCMutableMessage alloc] init];
        message.address = Switch.property;
        //[message addString:Switch.property];
        [message addInt:1];
        [self.connection sendPacket:message toHost:ip port:port];
        NSLog(@"%@: Switch is ON", Switch.property);
    } else{
        // Execute any code when the switch is OFF
        OSCMutableMessage *message = [[OSCMutableMessage alloc] init];
        message.address = Switch.property;
        //[message addString:Switch.property];
        [message addInt:0];
        [self.connection sendPacket:message toHost:ip port:port];
        NSLog(@"Switch is OFF");
    }
}

//------------------Create Controls functions---------------------------------

- (void) createTButton:(NSString*) bname xposition:(float) x yposition:(float) y
               height:(float) height width:(float)width addressPat: (NSString *) addressPat{
    
    UIButton *button =
    [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:[UIImage imageNamed:@"greyButton.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"blackButton.png"] forState:UIControlStateSelected];
    
    button.frame = CGRectMake(x, y, width, height);
    [button addTarget:self
               action:@selector(TbuttonReleased:withEvent:)
     forControlEvents:UIControlEventTouchUpInside];

    [button setTitle:bname forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    button.property=addressPat;
    
    
    //NSLog(@"button id is: %d", button.property);
    
    
}




- (void) createButton:(NSString*) bname xposition:(float) x yposition:(float) y
                height:(float) height width:(float)width addressPat: (NSString *) addressPat {
  
   UIButton *button =
    [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"blueButton.png"] forState:UIControlStateNormal];

    button.frame = CGRectMake(x, y, width, height);
    [button addTarget:self
               action:@selector(buttonReleased:)
     forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self
               action:@selector(buttonPressing:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:bname forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    [self.view addSubview:button];
    button.property=addressPat;

    
    //NSLog(@"button id is: %d", button.property);
    

}

-(void) createVSlider:(NSString *) stitle xposition:(int)x yposition:(int)y height:(int)height width:(int)width to:(int)to from:(int)from addressPat: (NSString *) addressPat{
    
    CGRect frame = CGRectMake(x, y, height, width);
    UISlider *slider = [[UISlider alloc] initWithFrame:frame];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = from;
    slider.maximumValue = to;
    slider.continuous = YES;
    slider.value = to/2;
    slider.property=addressPat;
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * 0.5);
    slider.transform = trans;
    [self.view addSubview:slider];
}
-(void) createHSlider:(NSString *) stitle xposition:(int)x yposition:(int)y height:(int)height width:(int)width to:(int)to from:(int)from addressPat: (NSString *) addressPat{
    
    CGRect frame = CGRectMake(x, y, width, height);
    UISlider *slider = [[UISlider alloc] initWithFrame:frame];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = from;
    slider.maximumValue = to;
    slider.continuous = YES;
    slider.value = to/2;
    slider.property=addressPat;
   
    [self.view addSubview:slider];
}
-(void) createSwitch:(NSString *) stitle xposition:(int)x yposition:(int)y height:(int)height width:(int)width addressPat: (NSString *) addressPat{
        UISwitch *Switch = [[UISwitch alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [Switch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
        Switch.property=addressPat;
        [self.view addSubview:Switch];


}


-(void)gotoConnection{
    ConnectViewController *connectView = [[ConnectViewController alloc] init];
    [self.navigationController pushViewController:connectView animated:NO];
}

- (void)oscConnection:(OSCConnection *)con didReceivePacket:(OSCPacket *)packet fromHost:(NSString *)host port:(UInt16)port
{
    
    NSLog(@"Received Data:%@", [packet.arguments description]);
    NSLog(@"address Pattern: %@", packet.address);
    //NSLog(@"From:%@", packet.address);
    if([packet.address  isEqual:@"/sync"]){
        [self resetView];
        //NSLog(@"detected");
        NSString *receivedJSON=[packet.arguments objectAtIndex:0];
        NSLog(@"detected:%@", receivedJSON);
        [self readJSON:receivedJSON];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:receivedJSON forKey:@"JSON"];

    }
  
}


#define DEBTS_LIST_KEY @"listOfAllDebts"
#define DEBTOR_NAME_KEY @"debtorName"
#define DEBT_AMOUNT_KEY @"amountOfDebt"


-(void)readJSON:(NSString *) jsonString{
    
    NSError *error=nil;
    //NSString *str=[[NSBundle mainBundle] pathForResource:@"JSON" ofType:@"JSON"];
    
    NSData *jsonData=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    //[NSData dataWithContentsOfFile:str];
    //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.json-generator.com/api/json/get/bGHMXnmbAO?indent=2"]];
    //NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    //NSData *jsonData=[NSKeyedUnarchiver unarchiveObjectWithData:jsonarray];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (!JSON) {
        NSLog(@"Error parsing JSON: %@", error);
    } else {
        for(NSDictionary *item in JSON) {
            //NSArray *addressPatArr = [item objectForKey:@"addressPattern"];
            NSString *addressPatArr = (NSString *)[item objectForKey:@"addressPattern"];
            NSInteger widthArr = [[item objectForKey:@"width"]integerValue];
            NSArray *typeArr = [item objectForKey: @"type"];
            NSInteger fromVArr = [[item objectForKey: @"fromValue"] integerValue];
            NSInteger toVArr = [[item objectForKey: @"toValue"] integerValue];
            NSInteger xArr = [[item objectForKey: @"x"] integerValue];
            NSInteger yArr = [[item objectForKey: @"y"] integerValue];
            NSString *titleArr=(NSString *) [item objectForKey:@"title"];
            NSInteger heightArr = [[item objectForKey: @"height"] integerValue];
            
            if([typeArr isEqual:@"Push Button"]){
                //temp=xArr;
                //NSInteger xValue = [[temp objectAtIndex:0] integerValue];
                [self createButton: titleArr xposition:xArr yposition:yArr+70 height:heightArr width:widthArr addressPat:addressPatArr];
                NSLog(@"hurray: %ld", (long)fromVArr);
            }
            else if([typeArr isEqual:@"Toggle"]){
                
                [self createTButton: titleArr xposition:xArr yposition:yArr+70 height:heightArr width:widthArr addressPat:addressPatArr];
                
                //[self createSwitch:addressPatArr xposition:(int)xArr yposition: (int)yArr+70 height:(int)heightArr width:(int)widthArr];

            }
            else if([typeArr isEqual:@"SliderH"]){
                [self createHSlider:titleArr xposition:(int)xArr yposition:(int)yArr+70 height:(int)heightArr width:(int)widthArr to:(int)toVArr from:(int)fromVArr addressPat:addressPatArr];
                
            }
            else if([typeArr isEqual:@"SliderV"]){
                [self createVSlider:titleArr xposition:(int)xArr-50 yposition:(int)yArr+110 height:(int)heightArr width:(int)widthArr to:(int)toVArr from:(int)fromVArr addressPat:addressPatArr];
                
            }
            else{
                NSLog(@"No Compatible Command Found");
            }
            NSLog(@"addressPattern: %@", addressPatArr);
            NSLog(@"title: %@", titleArr);
            NSLog(@"width: %ld", (long)widthArr);
            NSLog(@"type: %@", typeArr);
            NSLog(@"from: %ld", (long)fromVArr);
            NSLog(@"to: %ld", (long)toVArr);
            NSLog(@"x: %ld", (long)xArr);
            NSLog(@"y: %ld", (long)yArr);
            NSLog(@"height: %ld", (long)heightArr);
        }
    }


}
-(void)loadUI{
    
//    NSError *error = nil;
//    self.connection = [[OSCConnection alloc] init];
//    self.connection.delegate = self;
//    self.connection.continuouslyReceivePackets = YES;
//    
//    
//    if (![self.connection bindToAddress:nil port:11000 error:&error])
//    {
//        NSLog(@"Could not bind UDP connection: %@", error);
//    }
//    [self.connection receivePacket];
    [self resetView];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSObject* object=[defaults objectForKey:@"JSON"];
    NSString *temp;
    if(object==nil){
        
        NSString* emptyJSON=@"[]";
        [defaults setObject:emptyJSON forKey:@"JSON"];
    }
        temp=[defaults objectForKey:@"JSON"];
        [self readJSON:temp];
    

    //[self readJSON];
    
    //[self writeJSON];
    //[self readtest];

}
-(void)portBind{
    NSError *error = nil;
    self.connection = [[OSCConnection alloc] init];
    self.connection.delegate = self;
    self.connection.continuouslyReceivePackets = YES;
    
    
    if (![self.connection bindToAddress:nil port:11000 error:&error])
    {
        NSLog(@"Could not bind UDP connection: %@", error);
    }
    [self.connection receivePacket];


}
-(void)writeJSON{
//    NSString *str =@"hello"; //Your text or XML
//    [str writeToFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"JSON"] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"function is called");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.JSON"];
    //NSLog(@"filePath %@", filePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) { // if file is not exist, create it.
        NSString *helloStr = @"hello world";
        NSError *error;
        [helloStr writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    
    if ([[NSFileManager defaultManager] isWritableFileAtPath:filePath]) {
        NSLog(@"Writable");
    }else {
        NSLog(@"Not Writable");
    }


}

-(void)readtest{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.JSON"];
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    
    
    NSLog(@"Value written is: %@", content);



}
-(void)resetView{
NSArray *viewsToRemove = [self.view subviews];
for (UIView *v in viewsToRemove) {
    [v removeFromSuperview];
}
}






@end
