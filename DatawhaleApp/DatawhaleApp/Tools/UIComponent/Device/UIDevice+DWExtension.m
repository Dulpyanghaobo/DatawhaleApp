//
//  UIDevice+UIDevice_DWExtension.m
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/14.
//

#import "UIDevice+DWExtension.h"

@implementation UIDevice (DWExtension)

+ (CGFloat)statusBarHeight
{
    UIWindowScene *keyWindowScane = [self keyWindowScene];
    CGFloat height = keyWindowScane.statusBarManager.statusBarFrame.size.height;
    if (height <= 0) {
        if ([self isiPhoneXDevice]) {
            height = 44;
        } else {
            height = 20;
        }
    }
    return height;
}

+ (CGFloat)navigationAndStatusBarHeight
{
    return 44 + [self statusBarHeight];
}

+ (UIWindow *)keyWindow
{
    UIWindowScene *keyWindowScane = [self keyWindowScene];
    return keyWindowScane.windows.firstObject;
}

+ (UIWindowScene *)keyWindowScene
{
    NSSet *scenes = [UIApplication sharedApplication].connectedScenes;
    UIWindowScene *keyWindowScane = nil;
    for (UIWindowScene* windowScene in scenes) {
        if (windowScene.activationState == UISceneActivationStateForegroundActive) {
            keyWindowScane = windowScene;
            break;
        }
    }
    if (!keyWindowScane && scenes.count) {
        keyWindowScane = [scenes anyObject]; // 启动开始的时候拿不到用来布局
    }
    return keyWindowScane;
}

+ (BOOL)isiPhoneXDevice
{
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    UIWindow *mainWindow = [self keyWindow];
    if (mainWindow.safeAreaInsets.bottom > 0.0) {
        iPhoneXSeries = YES;
    }
    return iPhoneXSeries;
}

@end
