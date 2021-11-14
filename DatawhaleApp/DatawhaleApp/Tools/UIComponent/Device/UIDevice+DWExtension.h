//
//  UIDevice+UIDevice_DWExtension.h
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (DWExtension)

+ (BOOL)isiPhoneXDevice;

+ (CGFloat)statusBarHeight;

+ (CGFloat)navigationAndStatusBarHeight;

@end

NS_ASSUME_NONNULL_END
