//
//  MHRetakeCameraButton.m
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHRetakeCameraButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation MHRetakeCameraButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 10;
        self.clipsToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 0;
        self.layer.shadowOpacity = 0.3;
        
        [self setBackgroundColor:[UIColor colorWithRed:255.0/255 green:63.0/255 blue:56.0/255 alpha:1]];
        [self setTitleColor:[UIColor whiteColor]
                   forState:UIControlStateNormal];
        
        [self setTitle:@"Retake" forState:UIControlStateNormal];
        self.alpha = 0.85;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
