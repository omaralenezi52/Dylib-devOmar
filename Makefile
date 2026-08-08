TARGET := iphone:clang:latest:14.0
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = DevOmar
DevOmar_FILES = Tweak.m
DevOmar_CFLAGS = -fobjc-arc
DevOmar_FRAMEWORKS = UIKit Foundation QuartzCore
DevOmar_LDFLAGS = -install_name @executable_path/DevOmar.dylib

include $(THEOS)/makefiles/library.mk
