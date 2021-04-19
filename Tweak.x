
@interface NCNotificationShortLookView : UIView
@property (nonatomic, assign, readwrite) CGRect frame;
@property (nonatomic,readonly) CGRect bounds; 
@end

@interface SBNotificationBannerWindow : UIView
@end

@interface UIApplication ()
- (UIDeviceOrientation)_frontMostAppOrientation;
@end

@interface UIImage (Private)
+ (id)_applicationIconImageForBundleIdentifier:(id)arg1 format:(int)arg2 scale:(double)arg3;
- (UIImage *)initWithContentOfFile:(id)arg1;
@end

@interface SBFLockScreenAlternateDateLabel : UIView
@end

NSUserDefaults *defaults;
BOOL enabled;
NSInteger kPSSliderCell;

// static double PADDING = 10.3333;

// %hook SBFLockScreenDateSubtitleDateView
// - (void)didMoveToWindow {
// 	%orig;

// 	SBFLockScreenAlternateDateLabel * label = (SBFLockScreenAlternateDateLabel *)[self valueForKey:@"_alternateDateLabel"];
//     [label setHidden:YES];
// }
// %end

%hook NCNotificationShortLookViewController
- (void)viewWillAppear:(BOOL)animated {
    %log;
    animated = NO;
    %orig(animated);
}
%end

%hook NCNotificationShortLookView
-(void) layoutSubviews {
    %orig;
    if (enabled) {
        UIView * topView = self.superview.superview.superview.superview.superview.superview.superview;
        UIDeviceOrientation deviceOrientation = [[UIApplication sharedApplication] _frontMostAppOrientation];
        bool isPortrait = false;
	    if(deviceOrientation != UIDeviceOrientationLandscapeRight && deviceOrientation != UIDeviceOrientationLandscapeLeft) {
            // check not in landscape
            isPortrait = true;
        }
        // check in home screen or application
        bool isInHSorApp = [NSStringFromClass([topView class]) isEqualToString: @"SBBannerWindow"];
        
        if (isInHSorApp && isPortrait) {
            UIView * parent = self.superview.superview.superview.superview.superview;
            CGRect thisFrame = [[parent valueForKey:@"frame"] CGRectValue];
            RLog(@"thisFrame ===> %ld", parent.frame.size.height);

            thisFrame.origin.y = (CGFloat)kPSSliderCell;//[[UIScreen mainScreen] bounds].size.height - (parent.frame.size.height * 2) + kPSSliderCell;
            [parent setValue:[NSValue valueWithCGRect:thisFrame] forKey:@"frame"];
        }
    }
}
%end


void ReloadPrefs() {
    defaults = [[NSUserDefaults alloc] initWithSuiteName:@"fun.yfyf.bottombannersx4.prefs"];
    [defaults registerDefaults:@{ @"enabled" : @YES }];
    [defaults registerDefaults:@{ @"kPSSliderCell" : @600 }];
    
    enabled = [[defaults objectForKey:@"enabled"] boolValue];
    kPSSliderCell = [[defaults objectForKey:@"kPSSliderCell"] intValue];
}

%ctor {
    ReloadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)ReloadPrefs, CFSTR("fun.yfyf.bottombannersx4/ReloadPreferences"), NULL, kNilOptions);

    %init;
}