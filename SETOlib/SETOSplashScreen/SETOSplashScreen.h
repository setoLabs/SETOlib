//
//  SETOSplashScreen.h
//  SETOlibDemo
//
//  Created by Sebastian Stenzel on 15.02.13.
//  Copyright (c) 2013 setolabs.com. All rights reserved.
//

@interface SETOSplashScreen : UIImageView

/*!
 * \brief shows and returns a splash screen
 */
+ (SETOSplashScreen*)show;

/*!
 * \brief hides the splash screen, if shown. Otherwise does nothing.
 */
+ (void)hide;

/*!
 * \brief same as [SETOSplashScreen show]; [SETOSplashScreen hide];
 */
+ (void)splash;

#pragma mark - hiding

/*!
 * \brief same as [splashScreen scaledFadeOutWithDuration:0.3]
 */
- (void)scaledFadeOut;

/*!
 * \brief calls [splashScreen hideWithAnimation:duration:completion:] with the given duration and a fade out and scale animation.
 * \param duration The animation duration.
 */
- (void)scaledFadeOutWithDuration:(NSTimeInterval)duration;

/*!
 * \brief performs the given animation with the specified duration and then removes the view from the window.
 * \param animation The animations.
 * \param duration The animation duration.
 * \param completion Callback when finished.
 */
- (void)hideWithAnimation:(void(^)(SETOSplashScreen *splashScreen))animation duration:(NSTimeInterval)duration completion:(void(^)())completion;

@end
