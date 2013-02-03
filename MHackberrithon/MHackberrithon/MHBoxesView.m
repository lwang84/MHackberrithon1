//
//  MHBoxesView.m
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHBoxesView.h"
#import "MHBox.h"
#import "MHInfoComplex.h"

@implementation MHBoxesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tapGesture];
        
        CGRect superframe = self.frame;
        self.textView = [[MHRecognizedTextView alloc] initWithFrame:CGRectMake(superframe.size.width*0.05, superframe.size.height*0.03, superframe.size.width*0.9, superframe.size.height/3*0.7)];
        self.searchBtn = [[MHSearchButton alloc]initWithFrame:CGRectMake(superframe.size.width*0.95-70, superframe.size.height*(1.0/3*0.7+0.03), 30, 30) assignedSuper:self];
        self.confirmView = [[MHConfirmButtons alloc] initWithFrame:CGRectMake(superframe.size.width*0.95-30, superframe.size.height*(1.0/3*0.7+0.03), 30, 30)];
        self.indicator = nil;
        
    }
    return self;
}

- (void)setBoxesWithBoxes:(NSMutableArray*)boxes imageSize:(CGSize) size wordsConfidences:(NSMutableArray *)confidences words:(NSMutableArray *)w
{
    self.boxes = boxes;
    self.imageSize = size;
    self.confidences = confidences;
    self.words = w;
    
    for (int i = 0; i < [self.boxes count]; i++) {
        CGRect box =  [(NSValue *)[self.boxes objectAtIndex:i] CGRectValue];
        CGRect scaledBox = [self scaleBox:box];
        
        //MHConfirmButtons * confirm = [[MHConfirmButtons alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        //MHRecognizedTextView * textview = [[MHRecognizedTextView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        //MHSearchButton * search = [[MHSearchButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0) assignedSuper:self.superview words:[self.words objectAtIndex:i]];
        
        MHBox *boxView = [[MHBox alloc] initWithFrame:CGRectMake(scaledBox.origin.x+scaledBox.size.width/2, scaledBox.origin.y+scaledBox.size.height/2, 0, 0) word:[self.words objectAtIndex:i] buttons:nil textview:nil searchBtn:nil];
        //[complex addSubview:boxView];
        boxView.delegate = self;
        
        double delay = (arc4random() % 20)*1.0/20*0.7;
        
        UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut;
        [UIView animateWithDuration:0.3 delay:delay options:options animations:^{
            boxView.frame = CGRectMake(scaledBox.origin.x-0.1*scaledBox.size.width, scaledBox.origin.y-0.1*scaledBox.size.height, scaledBox.size.width*1.2, scaledBox.size.height*1.2);
        } completion:^(BOOL finished) {
            
            UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut;
            [UIView animateWithDuration:0.3 delay:0.0 options:options animations:^{
                boxView.frame = scaledBox;
            } completion:nil];
 
        }];
        
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
    return CGRectMake(0+box.origin.x/self.imageSize.width * self.frame.size.width,
                      self.frame.size.height*1.0/3+box.origin.y/self.imageSize.height * self.frame.size.height*1.0/3,
                      box.size.width/self.imageSize.width * self.frame.size.width,
                      box.size.height/self.imageSize.height * self.frame.size.height*1.0/3);
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

- (void) clearBoxes {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[MHBox class]] || [view isKindOfClass:[MHConfirmButtons class]] || [view isKindOfClass:[MHRecognizedTextView class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void) clearDetailInfo {
    [self.indicator removeFromSuperview];
    [self.confirmView removeFromSuperview];
    [self.textView removeFromSuperview];
    [self.searchBtn removeFromSuperview];
}

-(void)originalGotTapped: (MHBox *) original recognizedString:(NSString *)str
{
    //spiky solution:
    self.searchBtn.assignedSuperView = self.superview;
    
    [self.superview addSubview:self.confirmView];
    [self.superview addSubview:self.textView];
    [self.superview addSubview:self.searchBtn];
    
    [self.indicator removeFromSuperview];
    
    NSString *emailExpression = @".+@[A-Za-z0-9.-]+";
    NSString *phoneExpression = @".+[123456789.]+";
    NSString *urlExpression = @".+[w.]+[a-z.]+";
    
    if ([self checkREGEX:emailExpression forString: str]){
        self.indicator = [[MHTypeIndicator alloc] initWithFrame:CGRectMake(0, 0, 40, 40) imageName:@"gamil.png"];
        [self.superview addSubview:self.indicator];
        
    }
    else if ([self checkREGEX:phoneExpression forString:str]) {
        self.indicator = [[MHTypeIndicator alloc] initWithFrame:CGRectMake(0, 0, 40, 40) imageName:@"phone1.png"];
        [self.superview addSubview:self.indicator];
        
    }
    else if([self checkREGEX:urlExpression forString:str]) {
        self.indicator = [[MHTypeIndicator alloc] initWithFrame:CGRectMake(0, 0, 40, 40)imageName:@"web1.png"];
        [self.superview addSubview:self.indicator];
        
    }

    
    self.textView.text = str;
    NSLog(@"in delegate");
}

- (BOOL) checkREGEX: (NSString *) expression  forString: (NSString *)str{
    if (str == nil){
        return NO;
    }
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSTextCheckingResult *match = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    
    if (match){
        return YES;
    }else{
        return NO;
    }
}
@end
