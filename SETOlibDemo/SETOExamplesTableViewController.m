//
//  SETOExamplesTableViewController.m
//  SETOLibDemo
//
//  Created by Sebastian Stenzel on 15.02.13.
//  Copyright (c) 2013 Sebastian Stenzel. All rights reserved.
//

#import "SETOExamplesTableViewController.h"
#import "SETOSplashScreenDemo.h"
#import "SETOAppDelegate.h"

typedef enum {
	SETOExampleSplashScreen
} SETOExamples;

NSUInteger const SETOExampleCount = 1;

@implementation SETOExamplesTableViewController

- (void)showExampleViewController:(UIViewController*)exampleViewController {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		SETOAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
		UINavigationController *detailNavCtrl = appDelegate.splitViewController.viewControllers[1];
		[detailNavCtrl setViewControllers:@[exampleViewController] animated:YES];
	} else {
		[self.navigationController pushViewController:exampleViewController animated:YES];
	}
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return SETOExampleCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
    
    switch (indexPath.row) {
		case SETOExampleSplashScreen:
			cell.textLabel.text = @"SETOSplashScreen";
			break;
		default:
			break;
	}
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.row) {
		case SETOExampleSplashScreen:
			[self showExampleViewController:[[SETOSplashScreenDemo alloc] init]];
			break;
		default:
			break;
	}
}

#pragma mark - autorotate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return !([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - splitviewcontroller delegate

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
	return NO; //show master AND detail view controller in both ui orientations
}

@end
