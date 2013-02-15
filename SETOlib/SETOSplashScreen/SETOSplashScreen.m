//
//  SETOSplashScreen.m
//  SETOlibDemo
//
//  Created by Sebastian Stenzel on 15.02.13.
//  Copyright (c) 2013 setolab.com. All rights reserved.
//

#import "SETOSplashScreen.h"

NSString *const kSETOSplashScreen4inchPostfix = @"-568h";
NSString *const kSETOSplashScreenLandscapePostfix = @"-Landscape";
NSString *const kSETOSplashScreenPortraitPostfix = @"-Portrait";
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
			splashScreenImageName = [self splashScreenImageName:splashScreenImageName WithPostifxIfExists:kSETOSplashScreen4inchPostfix];
	}
	
	// iPad userinterface orientation dependent postfix (-Landscape, -Portrait)
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
			splashScreenImageName = [self splashScreenImageName:splashScreenImageName WithPostifxIfExists:kSETOSplashScreenLandscapePostfix];
		} else {
			splashScreenImageName = [self splashScreenImageName:splashScreenImageName WithPostifxIfExists:kSETOSplashScreenPortraitPostfix];
		}
	}
	
	// Retina postfix (@2x)
	if ([[UIScreen mainScreen] scale] == 2.0) {
		splashScreenImageName = [self splashScreenImageName:splashScreenImageName WithPostifxIfExists:kSETOSplashScreenRetinaPostfix];
	}
	
	// Device postfix (~iPhone, ~iPad)
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		splashScreenImageName = [self splashScreenImageName:splashScreenImageName WithPostifxIfExists:kSETOSplashScreeniPhonePostfix];
	} else {
		splashScreenImageName = [self splashScreenImageName:splashScreenImageName WithPostifxIfExists:kSETOSplashScreeniPadPostfix];
	}
	
	return splashScreenImageName;
}

+ (NSString*)splashScreenImageName:(NSString*)imageName WithPostifxIfExists:(NSString*)postfix {
	NSString *combinedName = [imageName stringByAppendingString:postfix];
	if([[NSBundle mainBundle] pathForResource:combinedName ofType:kSETOSplashScreenFileExtension]) {
		return combinedName;
	} else {
		return imageName;
	}
}

@end
