//
//  MHBoxesView.h
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tesseract.h"
#import "MHBox.h"

#import "MHRecognizedTextView.h"
#import "MHConfirmButtons.h"
#import "MHSearchButton.h"
#import "MHTypeIndicator.h"

@class MHBoxesView;

@protocol MHBoxesViewDelegate 

-(void)needChangeLabel: (NSString *) word;

@end

@interface MHBoxesView : UIView <MHBoxDelegate>

- (void)setBoxesWithBoxes:(NSMutableArray*)boxes imageSize:(CGSize) size wordsConfidences:(NSMutableArray *)confidences words:(NSMutableArray *)w;

@property NSMutableArray *boxes;
@property NSMutableArray *confidences;
@property NSMutableArray *words;

@property (retain) MHConfirmButtons * confirmView;
@property (retain) MHRecognizedTextView * textView;
@property (retain) MHSearchButton * searchBtn;
@property (retain) MHTypeIndicator * indicator;

@property CGSize imageSize;

@property (assign) id<MHBoxesViewDelegate>delegate;

-(void) clearBoxes;
@end
