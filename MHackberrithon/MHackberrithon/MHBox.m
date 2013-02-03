//
//  MHBox.m
//  MHackberrithon
//
//  Created by Lingyong Wang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHBox.h"
#import <QuartzCore/QuartzCore.h>


@implementation MHBox

@synthesize confirmView;
@synthesize textView;
@synthesize delegate;
@synthesize searchBtn;

- (id)initWithFrame:(CGRect)frame
               word:(NSString *)w
            buttons:(MHConfirmButtons *)btns
           textview:(MHRecognizedTextView *)txtview
          searchBtn:(MHSearchButton *) search
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blueColor];
        self.alpha = 0.4;
        self.layer.cornerRadius = 4;
        /*
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 10;
        self.layer.shadowOpacity = 0.5;
         */
        confirmView = btns;
        textView = txtview;
        searchBtn = search;
        [self addTarget:self action:@selector(originalTapped:) forControlEvents:UIControlEventTouchUpInside];
        self.word = w;
    }
    return self;
}

- (void) originalTapped: (UIButton *)btn
{
    confirmView.frame = CGRectMake(self.frame.origin.x+self.frame.size.width-30, self.frame.origin.y+self.frame.size.height, 30, 30);
    [self.superview addSubview:confirmView];    
    textView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y-70, self.frame.size.width, 100);
    [self.superview addSubview:textView];
    textView.text = self.word;
    
    searchBtn.frame = CGRectMake(self.frame.origin.x+self.frame.size.width-160, self.frame.origin.y+self.frame.size.height, 30, 30);
    [self.superview addSubview:searchBtn];

    
    [self.delegate originalGotTapped:self];
    NSLog(@"%@",self.word);
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
    NSString *phoneExpression = @".+[123456789.]+";
    NSString *urlExpression = @"[w.]+[a-z.]+";
    
    // Drawing code
    
    /*
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
	CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
	CGPathRef roundedRectPath = [self newPathForRoundedRect:frame radius:10];
    
	[[UIColor blueColor] set];
    
	CGContextAddPath(ctx, roundedRectPath);
	CGContextFillPath(ctx);
    
	CGPathRelease(roundedRectPath);
    */
    
    /*
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.0/255, 164.0/255, 248.0/255,1); // yellow line
    if ([self checkREGEX:emailExpression]){
        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0); // red line
    }
    else if ([self checkREGEX:phoneExpression]) {
        CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
    }
    else if([self checkREGEX:urlExpression]) {
        CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
    }
    else {
        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0.0, 1.0); // yellow line
    }
    
    CGContextStrokeRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    CGContextStrokePath(context);
     */
    
}

- (CGPathRef) newPathForRoundedRect:(CGRect)rect radius:(CGFloat)radius
{
	CGMutablePathRef retPath = CGPathCreateMutable();
    
	CGRect innerRect = CGRectInset(rect, radius, radius);
    
	CGFloat inside_right = innerRect.origin.x + innerRect.size.width;
	CGFloat outside_right = rect.origin.x + rect.size.width;
	CGFloat inside_bottom = innerRect.origin.y + innerRect.size.height;
	CGFloat outside_bottom = rect.origin.y + rect.size.height;
    
	CGFloat inside_top = innerRect.origin.y;
	CGFloat outside_top = rect.origin.y;
	CGFloat outside_left = rect.origin.x;
    
	CGPathMoveToPoint(retPath, NULL, innerRect.origin.x, outside_top);
    
	CGPathAddLineToPoint(retPath, NULL, inside_right, outside_top);
	CGPathAddArcToPoint(retPath, NULL, outside_right, outside_top, outside_right, inside_top, radius);
	CGPathAddLineToPoint(retPath, NULL, outside_right, inside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_right, outside_bottom, inside_right, outside_bottom, radius);
    
	CGPathAddLineToPoint(retPath, NULL, innerRect.origin.x, outside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_bottom, outside_left, inside_bottom, radius);
	CGPathAddLineToPoint(retPath, NULL, outside_left, inside_top);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_top, innerRect.origin.x, outside_top, radius);
    
	CGPathCloseSubpath(retPath);
    
	return retPath;
}



@end
