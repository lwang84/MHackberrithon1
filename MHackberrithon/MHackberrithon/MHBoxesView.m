//
//  MHBoxesView.m
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHBoxesView.h"
#import "MHBox.h"

@implementation MHBoxesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

- (void)setBoxesWithBoxes:(NSMutableArray*)boxes imageSize:(CGSize) size wordsConfidences:(NSMutableArray *)confidences
{
    self.boxes = boxes;
    self.imageSize = size;
    self.confidences = confidences;
    
    for (int i = 0; i < [self.boxes count]; i++) {
        CGRect box =  [(NSValue *)[self.boxes objectAtIndex:i] CGRectValue];
        CGRect scaledBox = [self scaleBox:box];
        MHBox *boxView = [[MHBox alloc] initWithFrame:scaledBox word:nil];
        [self addSubview:boxView];
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0.0, 1.0); // yellow line
//    
//    // Drawing code
//    for (int i = 0; i < [self.boxes count]; i++) {
//        CGRect box =  [(NSValue *)[self.boxes objectAtIndex:i] CGRectValue];
//        if ([[self.confidences objectAtIndex:i] integerValue]>80){
//            CGContextStrokeRect(context, [self scaleBox:box]);
//            CGContextStrokePath(context);
//        }
//    }
    
    
}
*/

- (CGRect)scaleBox:(CGRect) box {
    return CGRectMake(box.origin.x/self.imageSize.width * self.frame.size.width,
                      box.origin.y/self.imageSize.height * self.frame.size.height,
                      box.size.width/self.imageSize.width * self.frame.size.width,
                      box.size.height/self.imageSize.height * self.frame.size.height);
}


- (NSString *) getWordFromLocation: (CGPoint) location {
    for (int i = 0; i < [self.boxes count]; i++){
        CGRect box =  [(NSValue *)[self.boxes objectAtIndex:i] CGRectValue];
        CGRect scaledBox = [self scaleBox:box];
        if (location.x >= scaledBox.origin.x && location.x <= scaledBox.origin.x + scaledBox.size.width && location.y >= scaledBox.origin.y && location.y <= scaledBox.origin.y + scaledBox.size.height) {
                
        }
    }
    return nil;
}

- (void) tap: (UIGestureRecognizer *) tapGesture {
    CGPoint location = [tapGesture locationInView:self.superview];
    [self.delegate needChangeLabel:@"taped"];
}

@end
