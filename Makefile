export THEOS=/var/mobile/theos
ARCHS = arm64 
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

include $(THEOS)/makefiles/common.mk
TWEAK_NAME = D79oM

$(TWEAK_NAME)_CCFLAGS = -std=c++11 -fno-rtti -fno-exceptions -DNDEBUG
$(TWEAK_NAME)_CFLAGS = -fobjc-arc #-w #-Wno-deprecated -Wno-deprecated-declarations
$(TWEAK_NAME)_FILES = Menu.mm Tweak.xm SwitchesTemplate.mm $(wildcard KittyMemory/*.cpp)

$(TWEAK_NAME)_LIBRARIES += substrate
# GO_EASY_ON_ME = 1

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 ShadowTrackerExtra || :"
