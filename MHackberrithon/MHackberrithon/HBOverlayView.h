//
//  OverlayView.h
//  OverlayViewTester
//
//  Created by Jason Job on 09-12-10.
//  Copyright 2009 Jason Job. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHFreezeCameraButton.h"
#import "MHBoxesView.h"

@class HBOverlayView;

@protocol MHOverlayViewDelegate
- (void) needTakePicture: (HBOverlayView *)overlay;
@end

@interface HBOverlayView : UIView {

}

- (void)clearLabel:(UILabel *)label;
- (void) setStaticImage: (UIImage *) image;
@property (assign) id <MHOverlayViewDelegate> delegate;
@property (retain) UIImageView *staticImageView;
@property (retain) MHFreezeCameraButton *freezeButton;
@property (retain) MHBoxesView *boxesLayer;
@end
