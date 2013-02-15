//
//  SETOSplashScreenDemo.m
//  SETOlibDemo
//
//  Created by Sebastian Stenzel on 15.02.13.
//  Copyright (c) 2013 setolab.com. All rights reserved.
//

#import "SETOSplashScreenDemo.h"
#import "SETOSplashScreen.h"

typedef enum {
	SETOSplashExampleSplash,
	SETOSplashExampleScaledFadeOutWithDuration,
	SETOSplashExampleHideWithAnimation
} SETOSplashExamples;

NSUInteger const SETOSplashExampleCount = 3;

@implementation SETOSplashScreenDemo

- (void)splash {
	[SETOSplashScreen splash];
}

- (void)scaledFadeOutWithDuration {
	[[SETOSplashScreen show] scaledFadeOutWithDuration:1.0];
}

- (void)hideWithAnimation {
	[[SETOSplashScreen show] hideWithAnimation:^(SETOSplashScreen *splashScreen){
		splashScreen.transform = CGAffineTransformRotate(splashScreen.transform, 180.0);
		splashScreen.alpha = 0.0;
	} duration:1.0 completion:nil];
}

#pragma mark - View Controller

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"SETOSplashScreen.h";
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return SETOSplashExampleCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
    
    switch (indexPath.row) {
		case SETOSplashExampleSplash:
			cell.textLabel.text = @"+ splash";
			break;
		case SETOSplashExampleScaledFadeOutWithDuration:
			cell.textLabel.text = @"- scaledFadeOutWithDuration:1.0";
			break;
		case SETOSplashExampleHideWithAnimation:
			cell.textLabel.text = @"- hideWithAnimation:^(){...}: duration:1.0 completion:nil";
			break;
		default:
			break;
	}
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.row) {
		case SETOSplashExampleSplash:
			[self splash];
			return;
		case SETOSplashExampleScaledFadeOutWithDuration:
			[self scaledFadeOutWithDuration];
			return;
		case SETOSplashExampleHideWithAnimation:
			[self hideWithAnimation];
			return;
		default:
			return;
	}
}

#pragma mark - autorotate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return !([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

@end
