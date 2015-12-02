//
//  ViewController.h
//  CustomKeyboard
//
//  Created by KMJ on 2015. 11. 26..
//  Copyright © 2015년 KMJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomKeyBoard.h"

@interface ViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *tf_keyboard;
@property (nonatomic, strong) CustomKeyBoard *keyboard;

@end

