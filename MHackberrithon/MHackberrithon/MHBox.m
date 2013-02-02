//
//  MHBox.m
//  MHackberrithon
//
//  Created by Lingyong Wang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHBox.h"

@implementation MHBox

- (id)initWithFrame:(CGRect)frame word:(NSString *)w
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.word = w;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0.0, 1.0); // yellow line
    
    CGContextStrokeRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    CGContextStrokePath(context);
}


@end
