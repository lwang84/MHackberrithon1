//
//  MHBoxesView.h
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tesseract.h"

@interface MHBoxesView : UIView

- (void)setBoxesWithTesseract:(Tesseract*)tess imageSize:(CGSize) size;

@end
