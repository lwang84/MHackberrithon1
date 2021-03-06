//
//  MHFreezeCameraButton.m
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHFreezeCameraButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation MHFreezeCameraButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 10;
        self.clipsToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 0;
        self.layer.shadowOpacity = 0.3;
        
        [self setBackgroundColor:[UIColor colorWithRed:0.0/255 green:164.0/255 blue:248.0/255 alpha:1]];
        [self setTitleColor:[UIColor whiteColor]
                   forState:UIControlStateNormal];
        
        [self setTitle:@"Capture" forState:UIControlStateNormal];
        self.alpha = 0.85;
    }
    return self;
}

- (void)disableButton
{
    [self setBackgroundColor:[UIColor colorWithRed:0.0/255 green:85.0/255 blue:126.0/255 alpha:1]];
}

- (void)activateButton
{
    [self setBackgroundColor:[UIColor colorWithRed:0.0/255 green:164.0/255 blue:248.0/255 alpha:1]];

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
