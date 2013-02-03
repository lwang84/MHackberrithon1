//
//  MHFacebookSearchView.h
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHFacebookSearchView : UITableView <UITableViewDataSource, UITableViewDelegate>

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style words: (NSString *) w;
@property NSString *words;

@property NSMutableArray *events;

@end
