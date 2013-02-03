//
//  MHViewController.h
//  MHackberrithon
//
//  Created by Lingyong Wang on 2/1/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "HBOverlayView.h"


@interface MHViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, MHOverlayViewDelegate>

@property UIImagePickerController *picker;
@property UIActivityIndicatorView *spinner;

@end
