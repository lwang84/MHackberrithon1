//
//  MHFacebookSearchView.m
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHFacebookSearchView.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"

@implementation MHFacebookSearchView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style words: (NSString *) w
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *dismiss = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        dismiss.backgroundColor = [UIColor blueColor];
        [self addSubview:dismiss];
        [dismiss addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        
        self.words = w;
        self.events = [[NSMutableArray alloc] initWithCapacity:5];
        self.delegate = self;
        self.dataSource = self;
        
        // Initialization code
        
        //NSString *str = [NSString stringWithFormat:@"https://graph.facebook.com/search?fields=name&q=%@&type=event&access_token=AAAAAAITEghMBAHYQsr5ip1FpMi6ZC7ZBzYzbMoiZCa6xtf5YYIxWnlXZA6APb1z6GaFIqoBYrtQ7bGZAMQiMo1c2zgmG9QqTTRtoYYFwVmwZDZD", [self.words stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
        NSString *str = @"https://graph.facebook.com/search?fields=name&q=mhack&type=event&access_token=AAAAAAITEghMBAHYQsr5ip1FpMi6ZC7ZBzYzbMoiZCa6xtf5YYIxWnlXZA6APb1z6GaFIqoBYrtQ7bGZAMQiMo1c2zgmG9QqTTRtoYYFwVmwZDZD";
        NSLog(@"%@", str);
        NSURL *url = [NSURL URLWithString:str];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate:self];
        [request startAsynchronous];
    }
    return self;
}

- (void)dismiss: (UIButton *)btn
{
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut;
    [UIView animateWithDuration:0.3 delay:0.0 options:options animations:^{
        self.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    
    // Use when fetching binary data
    //NSData *responseData = [request responseData];
    
    NSLog(@"%@", responseString);
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *result = [parser objectWithString:responseString];
    
    NSArray *data = [result objectForKey:@"data"];

    for (NSDictionary *eventDetail in data) {
        NSString *eventName = [eventDetail objectForKey:@"name"];
        [self.events addObject:eventName];
        NSLog(@"%@", eventName);
    }
    NSLog(@"%d", [data count]);
    
    [self reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@", @"fail");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int selectedRow = indexPath.row;
    NSLog(@"touch on row %d", selectedRow);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return [self.events count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    
    cell.textLabel.text = [self.events objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"More text";
        
    return cell;
}


@end
