#include "BBXRootListController.h"

@interface UIImage (Private)
+ (id)_applicationIconImageForBundleIdentifier:(id)arg1
                                        format:(int)arg2
                                         scale:(double)arg3;
- (UIImage *)initWithContentOfFile:(id)arg1;
@end

@implementation BBXRootListController
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  UIBarButtonItem *applyButton =
      [[UIBarButtonItem alloc] initWithTitle:@"注销"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(respring)];
  self.navigationItem.rightBarButtonItem = applyButton;
}

- (void)respring {
  UIAlertController *alert =
      [UIAlertController alertControllerWithTitle:@"应用修改"
                                          message:@"确认进行注销吗?"
                                   preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *respringAction = [UIAlertAction
      actionWithTitle:@"注销"
                style:UIAlertActionStyleDestructive
              handler:^(UIAlertAction *action) {
                pid_t pid;
                int status;

                const char *args[] = {"killall", "-9", "backboardd", NULL};
                posix_spawn(&pid, "/usr/bin/killall", NULL, NULL,
                            (char *const *)args, NULL);
                waitpid(pid, &status, WEXITED);
              }];
  UIAlertAction *cancelAction =
      [UIAlertAction actionWithTitle:@"取消"
                               style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction *action){
                             }];

  [alert addAction:respringAction];
  [alert addAction:cancelAction];

  [self presentViewController:alert animated:YES completion:nil];
}

- (void)joinQQ {
  [[UIApplication sharedApplication]
                openURL:[NSURL URLWithString:
                                   @"https://jq.qq.com/?_wv=1027&k=IOnHbk10"]
                options:@{}
      completionHandler:nil];
}
@end
