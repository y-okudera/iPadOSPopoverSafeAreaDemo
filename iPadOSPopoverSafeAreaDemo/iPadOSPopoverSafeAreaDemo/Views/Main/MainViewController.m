//
//  MainViewController.m
//  iPadOSPopoverSafeAreaDemo
//
//  Created by Yuki Okudera on 2019/11/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

#import "MainViewController.h"
#import "PopoverViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITextField *countTextField;

@end

@implementation MainViewController

- (IBAction)tappedShowPopoverButton:(UIButton *)sender {
    
    // キーボードを閉じる
    if ([self.countTextField isFirstResponder]) {
        [self.countTextField resignFirstResponder];
    }
    
    NSString *inputString = self.countTextField.text;
    NSInteger count = [inputString integerValue];
    
    PopoverViewController *popoverViewController = [PopoverViewController makeWithSourceView:sender
                                                                                   cellCount:count
                                                                             backgroundColor:[UIColor systemOrangeColor]];
    // Popover表示
    [self presentViewController:popoverViewController animated:YES completion:nil];
}
@end
