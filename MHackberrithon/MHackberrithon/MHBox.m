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

- (BOOL) checkREGEX: (NSString *) expression {
    if (self.word == nil){
        return NO;
    }
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSTextCheckingResult *match = [regex firstMatchInString:self.word options:0 range:NSMakeRange(0, [self.word length])];
    
    if (match){
        return YES;
    }else{
        return NO;
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSString *emailExpression = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";

    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    if ([self checkREGEX:emailExpression]){
        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0); // red line
    }
    else {
        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0.0, 1.0); // yellow line
    }
    
    CGContextStrokeRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    CGContextStrokePath(context);
}



@end
