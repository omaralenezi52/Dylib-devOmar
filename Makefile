TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = DevOmar
DevOmar_FILES = Tweak.m
DevOmar_CFLAGS = -fobjc-arc
DevOmar_FRAMEWORKS = UIKit Foundation QuartzCore
DevOmar_INSTALL_PATH = /Library/Frameworks

include $(THEOS)/makefiles/library.mk
