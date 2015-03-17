//
//  AppDelegate.m
//  RIME
//
//  Created by David on 3/8/15.
//  Copyright (c) 2015 David. All rights reserved.
//

#import "AppDelegate.h"
#import "Sensors.h"
#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@import Foundation;

@interface AppDelegate ()


@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ViewController *viewController = [[ViewController alloc] init];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
  

    

    self.window.rootViewController=navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setBarTintColor:[UIColor grayColor]];

    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
  
    
    
//-------------------translate JSON string----------------------------------------------
    
    NSError *error=nil;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.json-generator.com/api/json/get/bGHMXnmbAO?indent=2"]];
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (!JSON) {
        NSLog(@"Error parsing JSON: %@", error);
    } else {
        for(NSDictionary *item in JSON) {
            NSArray *fetchedArr = [item objectForKey:@"gender"];
            NSArray *idArr = [item objectForKey:@"_id"];
            NSArray *nameArr = [item objectForKey: @"name"];
            NSArray *friendArr = [item objectForKey: @"friends"];

            //gender= [item objectForKey:@"gender"];
            //NSLog(@"Item: %@", item);
//            NSLog(@"id: %@", idArr);
//            NSLog(@"name: %@", nameArr);
//            NSLog(@"gender: %@", fetchedArr);
//            NSLog(@"friends: %@", friendArr);
        }
    }

    return YES;
//------------------------------------------------------------------------
    
    
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
