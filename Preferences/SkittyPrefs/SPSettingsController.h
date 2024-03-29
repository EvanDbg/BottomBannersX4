// SPSettingsController.h

#import <Preferences/PSListController.h>
#import <UserNotifications/UserNotifications.h>
#import "SPHeaderView.h"

@interface UIStatusBar : NSObject
@property (nonatomic, assign) UIColor *foregroundColor;
@end

@interface UIApplication (Private)
@property (nonatomic, retain) UIStatusBar *statusBar;
@end

@interface SPSettingsController : PSListController <UIScrollViewDelegate, UNUserNotificationCenterDelegate>

@property (nonatomic, retain) NSMutableDictionary *settings;
@property (nonatomic, retain) NSMutableDictionary *requiredToggles;
@property (nonatomic, retain) UIImageView *iconView;
@property (nonatomic, retain) SPHeaderView *headerView;
@property (nonatomic, retain) UIColor *themeColor;
@property (nonatomic, assign) BOOL navbarThemed;

- (void)layoutHeader;
- (NSBundle *)resourceBundle;

@end

@interface UITableView ()
@property (getter=_sectionContentInset,nonatomic,assign,readwrite,setter=_setSectionContentInset:) UIEdgeInsets sectionContentInset;
@end