//
//  MHAppDelegate.h
//  MHackberrithon
//
//  Created by Lingyong Wang on 2/1/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MHLoginViewController.h"
#import "MHViewController.h"

@interface MHAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UINavigationController* navController;
@property (strong, nonatomic) MHViewController *mainViewController;
@property (strong, nonatomic) UIWindow *window;
- (void)openSession;

@end
