//
//  SETOBlockingAlertViewDemo.m
//  SETOlibDemo
//
//  Created by Sebastian Stenzel on 20.03.13.
//  Copyright (c) 2013 setolabs.com. All rights reserved.
//

#import "SETOBlockingAlertViewDemo.h"
#import "SETOBlockingAlertView.h"

@interface SETOBlockingAlertViewDemo ()

@end

@implementation SETOBlockingAlertViewDemo

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = @"SETOBlockingAlertView.h";
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	btn.frame = CGRectMake(0.0, 0.0, 200.0, 44.0);
	btn.center = self.view.center;
	[btn setTitle:@"blocking alert view" forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(showBlockingAlertView:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btn];
}

- (void)showBlockingAlertView:(UIButton*)sender {
	SETOBlockingAlertView *alert = [[SETOBlockingAlertView alloc] initWithTitle:@"demo" message:nil delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"option1", @"option2", @"option3", nil];
	
	//show blocking alert view from background thread, that blocks until alert is dismissed
	dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
	dispatch_async(backgroundQueue, ^{
		NSInteger buttonIndex = [alert showBlocking];
		NSString *buttonTitle = [alert buttonTitleAtIndex:buttonIndex];
		
		//perform ui update on main thread:
		dispatch_async(dispatch_get_main_queue(), ^{
			[sender setTitle:buttonTitle forState:UIControlStateNormal];
		});
	});
}


@end
