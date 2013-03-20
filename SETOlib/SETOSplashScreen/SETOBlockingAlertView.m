//
//  SETOBlockingAlertView.m
//  SETOlibDemo
//
//  Created by Sebastian Stenzel on 20.03.13.
//  Copyright (c) 2013 setolabs.com. All rights reserved.
//

#import "SETOBlockingAlertView.h"

@interface SETOBlockingAlertView ()
@property (nonatomic, strong) NSCondition *clickedButtonCondition;
@property (nonatomic, assign) NSInteger clickedButtonIndex;
@property (nonatomic, assign) BOOL clickedButton;
@end

@implementation SETOBlockingAlertView

- (NSInteger)showBlocking {
	if ([NSThread currentThread] == [NSThread mainThread]) {
		NSAssert(false, @"SETOBlockingAlertView must not be shown from the main thread.");
		return -1;
	}
	
	self.clickedButtonCondition = [[NSCondition alloc] init];
	[self.clickedButtonCondition lock];
	dispatch_async(dispatch_get_main_queue(), ^{
		[self show];
	});
	while (!self.clickedButton) [self.clickedButtonCondition wait];
	
	[self.clickedButtonCondition unlock];
	return self.clickedButtonIndex;
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
	[super dismissWithClickedButtonIndex:buttonIndex animated:animated];
	self.clickedButton = YES;
	self.clickedButtonIndex = buttonIndex;
	[self.clickedButtonCondition signal];
}

@end
