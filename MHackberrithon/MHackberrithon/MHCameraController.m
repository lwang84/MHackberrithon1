//
//  MHCameraController.m
//  MHackberrithon
//
//  Created by Lingyong Wang on 2/1/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHCameraController.h"
#import "OverlayView.h"
#import <MobileCoreServices/UTCoreTypes.h>


@implementation MHCameraController

//@synthesize picker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated {

    OverlayView *overlay = [[OverlayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH)];
    
    
	
	// Create a new image picker instance:
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //picker.delegate = self;
	
	// Set the image picker source:
	picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    picker.mediaTypes = @[(NSString *) kUTTypeImage,(NSString *) kUTTypeMovie];
    
    picker.allowsEditing = YES;
	
	// Hide the controls:
	picker.showsCameraControls = YES;
	picker.navigationBarHidden = YES;
	
	// Make camera view full screen:
	picker.wantsFullScreenLayout = NO;
	picker.cameraViewTransform = CGAffineTransformScale(picker.cameraViewTransform, CAMERA_TRANSFORM_X, CAMERA_TRANSFORM_Y);
	
	// Insert the overlay:
	picker.cameraOverlayView = overlay;
	
	//[self presentModalViewController:picker animated:YES];
    [self presentViewController:picker animated:NO completion:nil];
    [super viewDidAppear:YES];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
