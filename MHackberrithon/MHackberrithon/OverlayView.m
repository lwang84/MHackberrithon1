//
//  OverlayView.m
//  OverlayViewTester
//
//  Created by Jason Job on 09-12-10.
//  Copyright 2009 Jason Job. All rights reserved.
//

#import "OverlayView.h"
#import "ScanButton.h"
#import "MHSmileyFace.h"


@implementation OverlayView

@synthesize delegate;


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
    }
    return self;
}

- (void) captureTapped: (UIButton *)capture
{
    [self.delegate needTakePicture:self];
}

- (void) scanButtonTouchUpInside {
	UILabel *scanningLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 120, 30)];
	scanningLabel.backgroundColor = [UIColor clearColor];
	scanningLabel.font = [UIFont fontWithName:@"Courier" size: 18.0];
	scanningLabel.textColor = [UIColor redColor]; 
	scanningLabel.text = @"Scanning...";
	
	[self addSubview:scanningLabel];
	
	[self performSelector:@selector(clearLabel:) withObject:scanningLabel afterDelay:2];
	
}

- (void)clearLabel:(UILabel *)label {
	label.text = @"";
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}





@end
