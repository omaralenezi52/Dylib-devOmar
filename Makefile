TARGET := iphone:clang:latest:14.0
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DevOmar
DevOmar_FILES = Tweak.x
DevOmar_CFLAGS = -fobjc-arc
DevOmar_FRAMEWORKS = UIKit

include $(THEOS)/makefiles/tweak.mk
