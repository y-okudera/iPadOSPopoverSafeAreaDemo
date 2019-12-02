//
//  PopoverViewController.h
//  iPadOSPopoverSafeAreaDemo
//
//  Created by Yuki Okudera on 2019/11/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopoverViewController : UIViewController

+ (PopoverViewController *)makeWithSourceView:(UIView *)sourceView cellCount:(NSInteger)count backgroundColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
