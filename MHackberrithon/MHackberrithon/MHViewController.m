//
//  MHViewController.m
//  MHackberrithon
//
//  Created by Lingyong Wang on 2/1/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHViewController.h"
#import "MHSmileyFace.h"
#import "Tesseract.h"

#import "HBOverlayView.h"

@interface MHViewController ()

@end

@implementation MHViewController

@synthesize picker;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *capture = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 50)];
    [capture setTitle:@"aaa" forState:UIControlStateNormal];
    [capture setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [capture addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:capture];
}

- (void) buttonTapped: (UIButton *)capture
{
    HBOverlayView *overlay = [[HBOverlayView alloc] initWithFrame:CGRectMake(0, 0, 300,300)];
	
	// Create a new image picker instance:
	picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
	
	// Set the image picker source:
	picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	
	// Hide the controls:
	picker.showsCameraControls = NO;
	picker.navigationBarHidden = YES;
	
	// Make camera view full screen:
	picker.wantsFullScreenLayout = YES;
	picker.cameraViewTransform = CGAffineTransformScale(picker.cameraViewTransform, 1, 1.24299);
	
	// Insert the overlay:
	picker.cameraOverlayView = overlay;
	
	// Show the picker:
	[self presentModalViewController:picker animated:YES];
    [self performSelector:@selector(showTime) withObject:nil afterDelay:3.0];
    
}

- (void) showTime{
    NSLog(@"time up");
    
    [picker takePicture];
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker
{
    
    NSLog(@"did cancel camera");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSLog(@"picture taken");
    
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    //[tesseract setVariableValue:@"0123456789" forKey:@"tessedit_char_whitelist"];
    
    CGSize size = [image size];
    [tesseract setImage:image];
    //[tesseract recognize];
    
    [tesseract getWordBoxes];
    int n = [tesseract getBoxesCount];
    
    for (int i = 0; i < n; i++) {
        NSLog(@"%d", [tesseract getBoxes:i]);
    }
    
    NSLog(@"box count = %d", n);
    //NSLog(@"%@", [tesseract recognizedText]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
