//
//  AppDelegate.h
//  RIME
//
//  Created by David on 3/8/15.
//  Copyright (c) 2015 David. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CocoaOSC.h"
#import "CoreDataHelper.h"
#import "AsyncUdpSocket.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationBarDelegate>{

    
    
}

@property (strong, nonatomic) UIWindow *window;
@property OSCConnection *connection;
@property(nonatomic,readonly,retain) UINavigationController *navigationController;






@end

