//
//  MHViewController.m
//  MHackberrithon
//
//  Created by Lingyong Wang on 2/1/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHViewController.h"
#import "Tesseract.h"
#import "MHImageEditorViewController.h"

@interface MHViewController ()

@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property UIImage* image;
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
    HBOverlayView *overlay = [[HBOverlayView alloc] initWithFrame:CGRectMake(0, 0, self.view.superview.superview.frame.size.width,self.view.superview.superview.frame.size.height)];
    overlay.delegate = self;
	
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
    //[self performSelector:@selector(showTime) withObject:nil afterDelay:3.0];
    
}


- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker
{
    
    NSLog(@"did cancel camera");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSLog(@"picture taken");

    
    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"%f,%f", self.image.size.width, self.image.size.height);

    self.image = [self scaleAndRotateImage:self.image];

    NSLog(@"%f,%f", self.image.size.width, self.image.size.height);
    
    Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self.image CGImage], CGRectMake(0, self.image.size.height*1.0/3, self.image.size.width, self.image.size.height*1.0/3));
    
    //CGImageRef imageRef = CGImageCreateWithImageInRect([self.image CGImage], CGRectMake(self.image.size.width*1.0/3, 0, self.image.size.width*1.0/3, self.image.size.height));
    
    UIImage *nImage = [[UIImage alloc] initWithCGImage:imageRef scale:1 orientation:self.image.imageOrientation ];// scale:1 orientation:self.image.imageOrientation];
    
    //UIImage *nImage = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);

    CGSize size = [nImage size];
    [tesseract setImage:nImage];
    //[tesseract recognize];
    NSLog(@"start");
    [tesseract recognizeByWord];
    NSLog(@"end");
    [tesseract getWordBoxes];
    [tesseract getBlockBoxes];
    
    int n = [tesseract getBoxesCount];
    //int n = [tesseract getBlockCount];
    
    NSMutableArray *boxes = [[NSMutableArray alloc] initWithCapacity:n];
    for (int i = 0; i < n; i++) {
        CGRect box =  [tesseract getBoxes:i];
        //CGRect box =  [tesseract getBoxes:i];
        [boxes addObject:[NSValue valueWithCGRect:box]];
    }
    
    [[(HBOverlayView *)(picker.cameraOverlayView) boxesLayer] setBoxesWithBoxes:boxes imageSize:size];
    //[(HBOverlayView *)(picker.cameraOverlayView) boxesLayer].boxes = boxes;

    NSLog(@"box count = %d", n);
    //NSLog(@"%@", [tesseract recognizedText]);

    //UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [(HBOverlayView *)(picker.cameraOverlayView) setStaticImage:self.image];
    
//    MHImageEditorViewController *imageEditor = [[MHImageEditorViewController alloc] initWithNibName:@"MHImageEditorViewController" bundle:nil];
//    imageEditor.image = self.image;
//    
//    UIViewController *modalViewController = [self modalViewController];
//
//    if ([modalViewController isKindOfClass:[UIImagePickerController class]]) {
//        [self dismissModalViewControllerAnimated:NO];
//    }
//    [self presentModalViewController:imageEditor animated:NO];
}

- (void) needTakePicture: (HBOverlayView *)overlay
{
    
    [picker takePicture];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)scaleAndRotateImage:(UIImage *)image
{
    int kMaxResolution = 1000; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();  
    
    return imageCopy;  
}
@end
