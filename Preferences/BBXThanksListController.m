#include "BBXThanksListController.h"

@implementation BBXThanksListController
- (NSMutableArray *)specifiers {
  if (!_specifiers) {
    _specifiers = [self loadSpecifiersFromPlistName:@"Thanks" target:self];
  }

  return _specifiers;
}
@end
