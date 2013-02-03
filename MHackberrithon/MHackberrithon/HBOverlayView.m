//
//  OverlayView.m
//  OverlayViewTester
//
//  Created by Jason Job on 09-12-10.
//  Copyright 2009 Jason Job. All rights reserved.
//

#import "HBOverlayView.h"
#import "MHCameraMaskView.h"

@implementation HBOverlayView

@synthesize delegate;
@synthesize staticImageView;
@synthesize freezeButton;
@synthesize retakeButton;
@synthesize boxesLayer;
@synthesize wordLabel;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		// Clear the background of the overlay:
		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];
		
        //boxesLayer = [[MHBoxesView alloc] initWithFrame:CGRectMake(self.frame.size.width*1.0/3, 0, self.frame.size.width*1.0/3, self.frame.size.height)];
        boxesLayer = [[MHBoxesView alloc] initWithFrame:CGRectMake(0, self.frame.size.height*1.0/3, self.frame.size.width, self.frame.size.height*1.0/3)];
        boxesLayer.delegate = self;
        [self addSubview:boxesLayer];
        [self bringSubviewToFront:boxesLayer];
        
        freezeButton = [[MHFreezeCameraButton alloc] initWithFrame:CGRectMake(self.frame.size.width*1.5/5, self.frame.size.height*4.5/6, self.frame.size.width*2.0/5, self.frame.size.height*1.0/10)];
        [freezeButton addTarget:self action:@selector(captureTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:freezeButton];
        [self bringSubviewToFront:freezeButton];
        
        retakeButton = [[MHRetakeCameraButton alloc] initWithFrame:CGRectMake(self.frame.size.width*1.5/5, self.frame.size.height*4.5/6, self.frame.size.width*2.0/5, self.frame.size.height*1.0/10)];
        [retakeButton addTarget:self action:@selector(retakeTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        
        wordLabel = [[MHWordLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height *1.0/3)];
        wordLabel.text = @"test";
        [self addSubview:wordLabel];
        [self bringSubviewToFront:wordLabel];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tapGesture];
        
        MHCameraMaskView *mask = [[MHCameraMaskView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:mask];
        [self rearrangeSubviews];
        
    }
    return self;
}

- (void) setStaticImage: (UIImage *) image
{
    staticImageView = [[UIImageView alloc] initWithImage:image];
    staticImageView.frame = CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height);
    [self addSubview:staticImageView];
    
    [self rearrangeSubviews];
}

- (void) removeStaticImage
{

    [staticImageView removeFromSuperview];
    
}

- (void) rearrangeSubviews {
    
    NSArray * subs = self.subviews;
    for(int i = 0; i < subs.count; i++)
    {
        if([subs objectAtIndex:i] != nil && [subs objectAtIndex:i] != staticImageView)
        {
            [self bringSubviewToFront:(UIView *)([subs objectAtIndex:i])];
        }
        
    }
    [self bringSubviewToFront:boxesLayer];
    [self bringSubviewToFront:freezeButton];
    
}

- (void) captureTapped: (UIButton *)capture
{
    [self.delegate needTakePicture:self];
    [(MHFreezeCameraButton *)capture disableButton];
    //[capture removeFromSuperview];
    //[self addSubview:retakeButton];
    //[self bringSubviewToFront:retakeButton];
}

- (void) retakeTapped: (UIButton *)retake
{
    //[self.delegate needResumeCamera:self];
    [self removeStaticImage];
    [retake removeFromSuperview];
    [self addSubview:freezeButton];
    [self bringSubviewToFront:freezeButton];
}

- (void) changeToRetakeButton
{
    [freezeButton removeFromSuperview];
    [self addSubview:retakeButton];
    [self bringSubviewToFront:retakeButton];
}

- (void)clearLabel:(UILabel *)label {
	label.text = @"";
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void) tap: (UIGestureRecognizer *) tapGesture {
    CGPoint location = [tapGesture locationInView:self.superview];
    //self.wordLabel.text = [NSString stringWithFormat:@"%f, %f", location.x, location.y];
}

-(void) needChangeLabel:(NSString *)word {
    self.wordLabel.text = word;
}

@end
