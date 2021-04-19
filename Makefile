ARCHS = arm64 arm64e

DEBUG = 1
FINALPACKAGE = 0
export COPYFILE_DISABLE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BottomBannersX4

BottomBannersX4_FILES = Tweak.x
BottomBannersX4_CFLAGS = -Wno-deprecated-declarations
BottomBannersX4_FRAMEWORKS = UIKit

SUBPROJECTS += Preferences

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"