//
//  ViewController.m
//  CustomKeyboard
//
//  Created by KMJ on 2015. 11. 26..
//  Copyright © 2015년 KMJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tf_keyboard, keyboard;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    keyboard = [[CustomKeyBoard alloc] init:mainScreen.bounds.size.width height:mainScreen.bounds.size.width*0.7 textView:tf_keyboard];
    tf_keyboard.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSLog(@"string = %@", string);
    return YES;
}


@end
