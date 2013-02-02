//
//  MHLoginViewController.m
//  MHackberrithon
//
//  Created by Lingyong Wang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHLoginViewController.h"

@interface MHLoginViewController ()

@end

@implementation MHLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performLogin:(id)sender {
    MHAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
    //[self.spinner stopAnimating];
}

@end
