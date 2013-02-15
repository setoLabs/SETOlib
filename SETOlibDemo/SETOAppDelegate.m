//
//  SETOAppDelegate.m
//  SETOlibDemo
//
//  Created by Sebastian Stenzel on 15.02.13.
//  Copyright (c) 2013 setolab.com. All rights reserved.
//

#import "SETOAppDelegate.h"
#import "SETOExamplesTableViewController.h"
#import "SETOWelcomeViewController.h"
#import "SETOSplashScreen.h"

@implementation SETOAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	SETOExamplesTableViewController *masterViewController = [[SETOExamplesTableViewController alloc] initWithStyle:UITableViewStylePlain];
	
    // Override point for customization after application launch.
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
	    self.window.rootViewController = self.navigationController;
	} else {
		SETOWelcomeViewController *detailViewController = [[SETOWelcomeViewController alloc] init];
	    UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
	    UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
		
	    self.splitViewController = [[UISplitViewController alloc] init];
		self.splitViewController.delegate = masterViewController;
	    self.splitViewController.viewControllers = @[masterNavigationController, detailNavigationController];
	    
	    self.window.rootViewController = self.splitViewController;
	}
    [self.window makeKeyAndVisible];
	
	[SETOSplashScreen splash];
	
    return YES;
}

@end
