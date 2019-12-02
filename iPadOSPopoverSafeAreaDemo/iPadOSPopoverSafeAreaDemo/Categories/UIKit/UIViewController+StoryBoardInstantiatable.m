//
//  UIViewController+StoryBoardInstantiatable.m
//  iPadOSPopoverSafeAreaDemo
//
//  Created by Yuki Okudera on 2019/11/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

#import "UIViewController+StoryBoardInstantiatable.h"

@implementation UIViewController (StoryBoardInstantiatable)

+ (__kindof UIViewController *)instantiate {
    NSString *className = NSStringFromClass(self);
    return [self instantiateWithStoryboardName:className identifier:className];
}

+ (__kindof UIViewController *)instantiateWithStoryboardName:(NSString *)storyboardName
                                                  identifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:NSBundle.mainBundle];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}
@end
