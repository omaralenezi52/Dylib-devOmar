TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DevOmar
DevOmar_FILES = Tweak.x
DevOmar_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-error
DevOmar_FRAMEWORKS = UIKit Foundation QuartzCore

include $(THEOS)/makefiles/tweak.mk
