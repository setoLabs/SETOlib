//
//  SETOSplashScreen.m
//  SETOlibDemo
//
//  Created by Sebastian Stenzel on 15.02.13.
//  Copyright (c) 2013 setolabs.com. All rights reserved.
//

#import "SETOSplashScreen.h"

NSString *const kSETOSplashScreen4inchPostfix = @"-568h";
NSString *const kSETOSplashScreenLandscapeWithStatusBarPostfix = @"-Landscape";
NSString *const kSETOSplashScreenLandscapeWithoutStatusBarPostfix = @"-748h-Landscape";
NSString *const kSETOSplashScreenPortraitWithStatusBarPostfix = @"-Portrait";
NSString *const kSETOSplashScreenPortraitWithoutStatusBarPostfix = @"-1004h-Portrait";
NSString *const kSETOSplashScreenRetinaPostfix = @"@2x";
NSString *const kSETOSplashScreeniPhonePostfix = @"~iPhone";
NSString *const kSETOSplashScreeniPadPostfix = @"~iPad";
NSString *const kSETOSplashScreenFileExtension = @"png";

@implementation SETOSplashScreen

static SETOSplashScreen* visibleSplashScreen = nil;

+ (SETOSplashScreen*)show {
	@synchronized(SETOSplashScreen.class) {
		if (visibleSplashScreen == nil) {
			visibleSplashScreen = [[SETOSplashScreen alloc] init];
			[visibleSplashScreen performSelector:@selector(addToWindow) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
		}
	}
	return visibleSplashScreen;
}

+ (void)hide {
	@synchronized(SETOSplashScreen.class) {
		[visibleSplashScreen scaledFadeOut];
	}
}

+ (void)splash {
	[[SETOSplashScreen show] scaledFadeOut];
}

#pragma mark - hiding

- (void)scaledFadeOut {
	[self scaledFadeOutWithDuration:0.3];
}

- (void)scaledFadeOutWithDuration:(NSTimeInterval)duration {
	[self hideWithAnimation:^(SETOSplashScreen *splashScreen){
		splashScreen.alpha = 0.0;
		splashScreen.transform = CGAffineTransformScale(splashScreen.transform, 2.0, 2.0);
	} duration:duration completion:nil];
}

- (void)hideWithAnimation:(void(^)(SETOSplashScreen *splashScreen))animation duration:(NSTimeInterval)duration completion:(void(^)())completion {
	NSParameterAssert(animation);
	[UIView animateWithDuration:duration animations:^{
		animation(self);
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
		visibleSplashScreen = nil;
		if (completion) {
			completion();
		}
	}];
}

#pragma mark - showing

- (id)init {
	NSString *imageName = [SETOSplashScreen splashScreenImageName];
	UIImage *image = [UIImage imageNamed:imageName];
	if (self = [super initWithImage:image]) {
		// Initialization code
	}
	return self;
}

- (void)addToWindow {
	NSAssert([NSThread currentThread] == [NSThread mainThread], @"user interface changes must be done on main thread");
	UIWindow *window = [[UIApplication sharedApplication] keyWindow];
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		self.transform = [self transformForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
	}
	self.center = window.rootViewController.view.center;
	[window addSubview:self];
}

- (CGAffineTransform)transformForOrientation:(UIInterfaceOrientation)orientation {
	switch (orientation) {
		case UIInterfaceOrientationLandscapeLeft:
			return CGAffineTransformMakeRotation(-M_PI_2);
		case UIInterfaceOrientationLandscapeRight:
			return CGAffineTransformMakeRotation(M_PI_2);
		case UIInterfaceOrientationPortraitUpsideDown:
			return CGAffineTransformMakeRotation(M_PI);
		case UIInterfaceOrientationPortrait:
		default:
			return CGAffineTransformMakeRotation(0.0);
	}
}

+ (NSString *)splashScreenImageName {
	NSString *splashScreenImageName = @"Default"; // basename
	
	// iPhone 4" postfix (-568h)
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height == 568.0) {
			splashScreenImageName = [self splashScreenImageName:splashScreenImageName withPostifxIfExists:kSETOSplashScreen4inchPostfix];
	}
	
	// iPad userinterface orientation dependent postfix (-Landscape, -Portrait) or <iOS 7.0 postfix (-748h-Landscape, -1004h-Portrait)
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		if ([SETOCommon isBeforeSystemVersion:@"7.0"] && UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
			// <iOS 7.0 landscape
			splashScreenImageName = [self splashScreenImageName:splashScreenImageName withPostifxIfExists:kSETOSplashScreenLandscapeWithoutStatusBarPostfix];
		} else if ([SETOCommon isBeforeSystemVersion:@"7.0"] && UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
			// <iOS 7.0 portrait
			splashScreenImageName = [self splashScreenImageName:splashScreenImageName withPostifxIfExists:kSETOSplashScreenPortraitWithoutStatusBarPostfix];
		} else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
			// iOS 7.0+ landscape
			splashScreenImageName = [self splashScreenImageName:splashScreenImageName withPostifxIfExists:kSETOSplashScreenLandscapeWithStatusBarPostfix];
		} else {
			// iOS 7.0+ portrait
			splashScreenImageName = [self splashScreenImageName:splashScreenImageName withPostifxIfExists:kSETOSplashScreenPortraitWithStatusBarPostfix];
		}
	}
	
	// Retina postfix (@2x)
	if ([[UIScreen mainScreen] scale] == 2.0) {
		splashScreenImageName = [self splashScreenImageName:splashScreenImageName withPostifxIfExists:kSETOSplashScreenRetinaPostfix];
	}
	
	// Device postfix (~iPhone, ~iPad)
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		splashScreenImageName = [self splashScreenImageName:splashScreenImageName withPostifxIfExists:kSETOSplashScreeniPhonePostfix];
	} else {
		splashScreenImageName = [self splashScreenImageName:splashScreenImageName withPostifxIfExists:kSETOSplashScreeniPadPostfix];
	}
	
	return splashScreenImageName;
}

+ (NSString*)splashScreenImageName:(NSString*)imageName withPostifxIfExists:(NSString*)postfix {
	NSString *combinedName = [imageName stringByAppendingString:postfix];
	if([[NSBundle mainBundle] pathForResource:combinedName ofType:kSETOSplashScreenFileExtension]) {
		return combinedName;
	} else {
		return imageName;
	}
}

@end
