//
//  MHCameraController.h
//  MHackberrithon
//
//  Created by Lingyong Wang on 2/1/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import <UIKit/UIKit.h>

// Transform values for full screen support:
#define CAMERA_TRANSFORM_X 1
//#define CAMERA_TRANSFORM_Y 1.12412 // this was for iOS 3.x
#define CAMERA_TRANSFORM_Y 1.24299 // this works for iOS 4.x

// iPhone screen dimensions:
#define SCREEN_WIDTH  320
#define SCREEN_HEIGTH 480

@interface MHCameraController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//@property (nonatomic, strong) UIImagePickerController *picker;

@end