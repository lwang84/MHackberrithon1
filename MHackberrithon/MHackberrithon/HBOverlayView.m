//
//  OverlayView.m
//  OverlayViewTester
//
//  Created by Jason Job on 09-12-10.
//  Copyright 2009 Jason Job. All rights reserved.
//

#import "HBOverlayView.h"
#import "ScanButton.h"
#import "MHSmileyFace.h"
#import "MHCameraMaskView.h"


@implementation HBOverlayView

@synthesize delegate;
@synthesize staticImageView;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		// Clear the background of the overlay:
		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];
        MHSmileyFace *smiley = [[MHSmileyFace alloc] initWithFrame:CGRectMake(30, 100, 260, 200)];        
		[self addSubview:smiley];
		
		ScanButton *scanButton = [[ScanButton alloc] initWithFrame:CGRectMake(130, 320, 60, 30)];
		
		// Add a target action for the button:
		[scanButton addTarget:self action:@selector(scanButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:scanButton];
        
        
        UIButton *capture = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 50)];
        [capture setTitle:@"aaa" forState:UIControlStateNormal];
        [capture setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [capture addTarget:self action:@selector(captureTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:capture];
        [self bringSubviewToFront:capture];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [self addGestureRecognizer:tapGesture];
        MHCameraMaskView *mask = [[MHCameraMaskView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:mask];
        
    }
    return self;
}

- (void) setStaticImage: (UIImage *) image
{
    staticImageView = [[UIImageView alloc] initWithImage:image];
    staticImageView.frame = CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height);
    [self addSubview:staticImageView];
    
    NSArray * subs = self.subviews;
    for(int i = 0; i < subs.count; i++)
    {
        if([subs objectAtIndex:i] != staticImageView)
        {
            [self bringSubviewToFront:(UIView *)([subs objectAtIndex:i])];
        }
            
    }
    
    NSLog(@"static");
}

- (void) captureTapped: (UIButton *)capture
{
    [self.delegate needTakePicture:self];
}

- (void)clearLabel:(UILabel *)label {
	label.text = @"";
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void) tap: (UIGestureRecognizer *) tapGesture {
    CGPoint location = [tapGesture locationInView:self.superview];
    NSLog(@"%f", location.x);
    
}



@end
