//
//  MHImagePickerController.m
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHImagePickerController.h"
 #import <MobileCoreServices/UTCoreTypes.h>

@interface MHImagePickerController ()

@end

@implementation MHImagePickerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HBOverlayView *overlay = [[HBOverlayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-200, SCREEN_HEIGTH-200)];
    overlay.delegate = self;
	
	// Create a new image picker instance:
	//UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //picker.delegate = self;
	
	// Set the image picker source:
	self.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    self.mediaTypes = @[(NSString *) kUTTypeImage,(NSString *) kUTTypeMovie];
    
    self.allowsEditing = YES;
	
	// Hide the controls:
	self.showsCameraControls = NO;
	self.navigationBarHidden = NO;
	
	// Make camera view full screen:
	self.wantsFullScreenLayout = NO;
	self.cameraViewTransform = CGAffineTransformScale(self.cameraViewTransform, CAMERA_TRANSFORM_X, CAMERA_TRANSFORM_Y);
	
	// Insert the overlay:
	self.cameraOverlayView = overlay;
    
    
    
    
	// Do any additional setup after loading the view.
}

- (void) needTakePicture: (HBOverlayView *)overlay;
{
    [self takePicture];
    NSLog(@"SDFSD");
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker
{
    
    NSLog(@"did cancel camera");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"picture taken");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
