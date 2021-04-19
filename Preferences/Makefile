ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = BottomBannersX4Prefs

BottomBannersX4Prefs_FILES = $(wildcard *.m) $(wildcard SkittyPrefs/*.m)
BottomBannersX4Prefs_FRAMEWORKS = UIKit
BottomBannersX4Prefs_PRIVATE_FRAMEWORKS = Preferences
BottomBannersX4Prefs_INSTALL_PATH = /Library/PreferenceBundles
BottomBannersX4Prefs_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/bundle.mk
