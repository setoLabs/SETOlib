//
//  SETOWelcomeViewController.m
//  SETOLibDemo
//
//  Created by Sebastian Stenzel on 15.02.13.
//  Copyright (c) 2013 Sebastian Stenzel. All rights reserved.
//

#import "SETOWelcomeViewController.h"

@implementation SETOWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.view.bounds, 20.0, 20.0)];
	welcomeLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	welcomeLabel.numberOfLines = 5;
	welcomeLabel.textAlignment = NSTextAlignmentCenter;
	welcomeLabel.text = @"Welcome to SETOlib example projects. To explore your oportunities, choose a class from the list on the left.";
	
	[self.view addSubview:welcomeLabel];
}

#pragma mark - autorotate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return !([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}


@end
