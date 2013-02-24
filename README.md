# SETOlib

Awesome Objective-C and iOS specific library.

## Consists of

- `SETOSplashScreen`

## Requirements

* iOS 5.0 or higher
* ARC enabled

## SETOSplashScreen

SETOSplashScreen adds a smooth and clean transition after your launch image (also called Default image) has been shown. It's perfect to use, if your launch image is a splash screen and doesn't represent your empty main view. The transition is a scaled fade out by default. If you wish, you can customize the animation to anything you want.

### Class methods

``` objective-c
	+ (void)splash;
```

`[SETOSplashScreen splash]` is in most cases the only method you need to call. You should call it in the `application:didFinishLaunchingWithOptions:` method of your AppDelegate as the last thing, right before the return.

``` objective-c
	+ (SETOSplashScreen*)show;
```

Shows a splash screen on your main window, and returns it.

``` objective-c
	+ (void)hide;
```

Hides the splash screen with a scaled fade out, if shown. Otherwise does nothing.

### Instance methods

``` objective-c
	- (void)hideWithAnimation:(void(^)(SETOSplashScreen *splashScreen))animation duration:(NSTimeInterval)duration completion:(void(^)())completion;
```

Performs the given animation with the specified duration and then removes the view from the window.

``` objective-c
	- (void)scaledFadeOutWithDuration:(NSTimeInterval)duration;
```

Calls `[splashScreen hideWithAnimation:duration:completion:]` with the given duration and a scaled fade out animation.

``` objective-c
	- (void)scaledFadeOut;
```

Same as `[splashScreen scaledFadeOutWithDuration:0.3]`.

## Credits

- Sebastian Stenzel, @totalvoidness
- Tobias Hagemann, @MuscleRumble

## License

Distributed under the CC BY 3.0 license. See the LICENSE file for more info.