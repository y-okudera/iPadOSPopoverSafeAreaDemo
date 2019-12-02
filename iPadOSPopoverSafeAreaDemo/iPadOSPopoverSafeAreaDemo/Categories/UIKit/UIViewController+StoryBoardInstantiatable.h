//
//  UIViewController+StoryBoardInstantiatable.h
//  iPadOSPopoverSafeAreaDemo
//
//  Created by Yuki Okudera on 2019/11/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (StoryBoardInstantiatable)

/// Storyboard名とidentifierとViewControllerのクラス名が同じ場合のインスタンス取得
+ (__kindof UIViewController *)instantiate;

/// Storyboard名とidentifierを指定して、ViewControllerのインスタンスを取得
/// @param storyboardName Storyboard名
/// @param identifier Storyboard identifier
+ (__kindof UIViewController *)instantiateWithStoryboardName:(NSString *)storyboardName
                                                  identifier:(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
