//
//  CustomKeyboard.h
//  MJKeyboard
//
//  Created by KMJ on 2015. 11. 12..
//  Copyright © 2015년 mj. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CustomKeyBoard : UIViewController <UITextFieldDelegate>

@property (nonatomic) BOOL isShift;
@property (nonatomic) float width;
@property (nonatomic) float height;
@property (strong, nonatomic) id<UITextInput> textView;
@property (strong, nonatomic) UIView *keyboardView;

@property (strong, nonatomic) NSMutableArray *arr_key;
@property (strong, nonatomic) NSMutableArray *arr_shift_key;
@property (strong, nonatomic) NSMutableArray *arr_special_key;
@property (strong, nonatomic) UIView *infoView;
@property (strong, nonatomic) UIView *infoBackView;
@property (strong, nonatomic) UILabel *infoLabel;

-(id)init:(float)keyboardwidth height:(float)keyboadheight textView:(id<UITextInput>)textView;

- (IBAction)characterPressed:(id)sender;
- (IBAction)deletePressed:(id)sender ;
- (IBAction)relocationKeyboard:(id)sender ;

- (IBAction)spacePressed:(id)sender;
- (IBAction)shiftPressed:(id)sender;

-(IBAction)showStringKeyboard:(id)sender;
-(IBAction)reShowStringKeyboard:(id)sender;

-(UIButton*)makeBtn:(float)x y:(float)y width:(float)w height:(float)h tagValue:(int)tagValue
              title:(NSString*)title action:(SEL)action addInfoView:(BOOL)infoViewOnOff;
@end
