//
//  MHCameraMaskView.m
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHCameraMaskView.h"

@implementation MHCameraMaskView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.83;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rectangle = CGRectMake(0,0,self.superview.frame.size.width,self.superview.frame.size.height * 1.0/3);
    CGContextAddRect(context, rectangle);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, rectangle);
    
    CGRect rectangle2 = CGRectMake(0,self.superview.frame.size.height * 2.0/3,self.superview.frame.size.width,self.superview.frame.size.height * 1.0/3);
    CGContextAddRect(context, rectangle2);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, rectangle2);
    
}


@end
