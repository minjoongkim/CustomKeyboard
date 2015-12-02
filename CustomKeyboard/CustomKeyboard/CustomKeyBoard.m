//
//  CustomKeyboard.m
//  MJKeyboard
//
//  Created by KMJ on 2015. 11. 12..
//  Copyright © 2015년 mj. All rights reserved.
//

#import "CustomKeyBoard.h"


@implementation CustomKeyBoard

@synthesize textView=_textView;
@synthesize keyboardView=_keyboardView;
@synthesize arr_key, arr_shift_key, arr_special_key;
@synthesize isShift;
@synthesize width, height;
@synthesize infoLabel, infoView, infoBackView;

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define UIColorKeyboardColor \
[UIColor colorWithRed:((float)((0xE1E5E9 & 0xFF0000) >> 16))/255.0 \
green:((float)((0xE1E5E9 & 0x00FF00) >>  8))/255.0 \
blue:((float)((0xE1E5E9 & 0x0000FF) >>  0))/255.0 \
alpha:1.0]


- (void)viewDidLoad {
    [super viewDidLoad];
    infoBackView = [[UIView alloc] init];
    infoView = [[UIView alloc]init];
    infoLabel = [[UILabel alloc] init];

    [infoView addSubview:infoLabel];
    [infoBackView addSubview:infoView];

    
    isShift = false;
    
    arr_key = [[NSMutableArray alloc] initWithObjects:
               @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",
               @"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",
               @"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",
               @"z",@"x",@"c",@"v",@"b",@"n",@"m",nil];
    
    arr_shift_key = [[NSMutableArray alloc] initWithObjects:
                     @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",
                     @"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",
                     @"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",
                     @"Z",@"X",@"C",@"V",@"B",@"N",@"M",nil];
    
    arr_special_key = [[NSMutableArray alloc] initWithObjects:
                     @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",
                     @"[",@"]",@"{",@"}",@"#",@"%",@"^",@"*",@"+",@"=",
                     @"-",@"/",@":",@";",@"(",@")",@"$",@"&",@"@",
                     @".",@",",@"?",@"!",@"'",@"<",@">",nil];
    
}

-(id)init:(float)keyboardwidth height:(float)keyboadheight textView:(id<UITextInput>)textView {
    
    self = [super init];
    
    if (self) {
        height = keyboadheight;
        width = keyboardwidth;
        
        UIView *keyboardView = [self getNumberKeyboard];
        
        self.view.autoresizingMask = UIViewAutoresizingNone;
        if ([textView isKindOfClass:[UITextView class]]) {
            [(UITextView *)textView setInputView:keyboardView];
        }
        else if([textView isKindOfClass:[UITextField class]]) {
            [(UITextField *)textView setInputView:keyboardView];
        }
        
        [(UITextField *)self.textView setDelegate:self];
        _textView = textView;
        _keyboardView = keyboardView;
        
    }
    
    return self;
}

-(IBAction)specialKeyboard:(id)sender {
    [self removeKeyboardKey];
    [_keyboardView addSubview:[self getStringKeyboard:YES]];
}

-(IBAction)reShowStringKeyboard:(id)sender {
    [self removeKeyboardKey];
    [_keyboardView addSubview:[self getStringKeyboard:NO]];
}

-(IBAction)showStringKeyboard:(id)sender {
    [self removeKeyboardKey];
    [_keyboardView addSubview:[self getStringKeyboard:NO]];
    [[(UITextField *)self.textView delegate] textField:(UITextField*)self.textView shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"complexkeyboard"];
}

- (IBAction)relocationKeyboard:(id)sender {
    [self removeKeyboardKey];
    
    [_keyboardView addSubview:[self getNumberKeyboard]];
    
    [[(UITextField *)self.textView delegate] textField:(UITextField*)self.textView shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"simplekeyboard"];
    
}

-(void)removeKeyboardKey {
    while ([_keyboardView viewWithTag:100]) {
        [[_keyboardView viewWithTag:100] removeFromSuperview];
    }
    
}

-(UIView*)getStringKeyboard:(BOOL)isSpecialKey {
    UIView* keyboardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    int random1 = arc4random()%10;
    int random2 = arc4random()%10 + 11;
    int random3 = arc4random()%5 + 22;
    int random4 = arc4random()%5 + 27;
    int random5 = arc4random()%7 + 33;
    
    NSMutableArray *arr_string;
    if(isSpecialKey) {
        arr_string = [[NSMutableArray alloc] initWithArray:arr_special_key];
    }else if(isShift) {
        arr_string = [[NSMutableArray alloc] initWithArray:arr_shift_key];
    }else {
        arr_string = [[NSMutableArray alloc] initWithArray:arr_key];
    }
    [arr_string insertObject:@"" atIndex:random1];
    [arr_string insertObject:@"" atIndex:random2];
    [arr_string insertObject:@"" atIndex:random3];
    [arr_string insertObject:@"" atIndex:random4];
    [arr_string insertObject:@"" atIndex:random5];
    [arr_string addObject:@""];
    [arr_string addObject:@""];
    
    float btn_width = (width-10)/11;
    float btn_height = (height-6)/5;
    
    float btn_bottom_width = (width-3)/4;
    int number = 0;
    
    for(int i=0; i<4; i++) {
        for(int j=0; j<11; j++) {
            if(i==3) {
                if(j>8) {
                    continue;
                }
                
                [keyboardView addSubview:[self makeBtn:btn_width*1.5+1+btn_width*j+j y: btn_height*i+i+1 width:btn_width height:btn_height tagValue:100 title:[arr_string objectAtIndex:number] action:@selector(characterPressed:) addInfoView:YES]];
            }else {
                [keyboardView addSubview:[self makeBtn:btn_width*j+j y: btn_height*i+i+1 width:btn_width height:btn_height tagValue:100 title:[arr_string objectAtIndex:number] action:@selector(characterPressed:) addInfoView:YES]];
            }
            
            number++;
        }
    }
    if(isSpecialKey) {
        [keyboardView addSubview:[self makeBtn:0 y:btn_height*3+3+1 width:btn_width*1.5 height:btn_height tagValue:100 title:@"" action:nil addInfoView:NO]];
    }else {
        [keyboardView addSubview:[self makeBtn:0 y:btn_height*3+3+1 width:btn_width*1.5 height:btn_height tagValue:100 title:@"Shift" action:@selector(shiftPressed:) addInfoView:NO]];
    }
    [keyboardView addSubview:[self makeBtn:btn_width*1.5+1+btn_width*8+8 y:btn_height*3+3+1 width:btn_width*1.5 height:btn_height tagValue:100 title:@"<-" action:@selector(deletePressed:) addInfoView:NO]];
    
    [keyboardView addSubview:[self makeBtn:0 y:btn_height*4+4+1 width:btn_bottom_width height:btn_height tagValue:100 title:@"#+=" action:@selector(specialKeyboard:) addInfoView:NO]];
    
    [keyboardView addSubview:[self makeBtn:btn_bottom_width*1+1 y:btn_height*4+4+1 width:btn_bottom_width height:btn_height tagValue:100 title:@"ABC" action:@selector(reShowStringKeyboard:) addInfoView:NO]];
    
    [keyboardView addSubview:[self makeBtn:btn_bottom_width*2+2 y:btn_height*4+4+1 width:btn_bottom_width height:btn_height tagValue:100 title:@"123" action:@selector(relocationKeyboard:) addInfoView:NO]];
    
    [keyboardView addSubview:[self makeBtn:btn_bottom_width*3+3 y:btn_height*4+4+1 width:btn_bottom_width height:btn_height tagValue:100 title:@"Enter" action:@selector(returnPressed:) addInfoView:NO]];
     
    
    return keyboardView;
}
-(UIView*)getNumberKeyboard {
    float btn_width = (width-3)/4;
    float btn_height = (height-5)/4;
    
    float btn2_width = (width-1)/2;
    
    UIView* keyboardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [keyboardView setBackgroundColor:UIColorKeyboardColor];
    
    int number = 1;
    int random1 = arc4random()%11+1;
    int random2 = arc4random()%11+1;
    
    while (random1 == random2) {
        random2 = arc4random()%11+1;
        
    }
    
    for(int i=0; i<3; i++) {
        for(int j=0; j<4; j++) {
            int count = i*4+j;
            if(count == random1){
                [keyboardView addSubview:[self makeBtn:btn_width*j+j y:btn_height*i+i+1 width:btn_width height:btn_height tagValue:100 title:@"" action:nil addInfoView:NO]];
                
            }else if(count == random2) {
                [keyboardView addSubview:[self makeBtn:btn_width*j+j y:btn_height*i+i+1 width:btn_width height:btn_height tagValue:100 title:@"" action:nil addInfoView:NO]];
            }else {
                [keyboardView addSubview:[self makeBtn:btn_width*j+j y:btn_height*i+i+1 width:btn_width height:btn_height tagValue:100 title:[NSString stringWithFormat:@"%d", number%10] action:@selector(characterPressed:) addInfoView:NO]];
                number++;
            }
        }
    }
    
    [keyboardView addSubview:[self makeBtn:0 y:btn_height*3+3+1 width:btn_width height:btn_height tagValue:100 title:@"<-" action:@selector(deletePressed:) addInfoView:NO]];
    
    [keyboardView addSubview:[self makeBtn:btn_width+1 y:btn_height*3+3+1 width:btn_width height:btn_height tagValue:100 title:@"ABC" action:@selector(showStringKeyboard:) addInfoView:NO]];
    
    [keyboardView addSubview:[self makeBtn:btn2_width+1 y:btn_height*3+3+1 width:btn2_width height:btn_height tagValue:100 title:@"Enter" action:@selector(returnPressed:) addInfoView:NO]];

    return keyboardView;
}


- (IBAction)characterPressed:(id)sender {
    UIButton *btn = (UIButton*)sender;
    
    if(btn.titleLabel.text.length  > 0) {
        [[UIDevice currentDevice] playInputClick];
        [self.textView insertText:btn.titleLabel.text];
        
        if ([self.textView isKindOfClass:[UITextView class]])
            [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
        else if ([self.textView isKindOfClass:[UITextField class]]) {
            if ([[(UITextField *)self.textView delegate] respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
                [[(UITextField *)self.textView delegate] textField:(UITextField*)self.textView shouldChangeCharactersInRange:[self selectedRangeInTextView:_textView] replacementString:btn.titleLabel.text];
            }
        }
    }
}


- (IBAction)deletePressed:(id)sender {
    
    [[UIDevice currentDevice] playInputClick];
    [self.textView deleteBackward];
    
    if ([self.textView isKindOfClass:[UITextView class]])
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
    else if ([self.textView isKindOfClass:[UITextField class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:(UITextField*)self.textView];
        if ([[(UITextField *)self.textView delegate] respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            
            //[[(UITextField *)self.textView delegate] textField:(UITextField*)self.textView shouldChangeCharactersInRange:[self selectedRangeInTextView:_textView] replacementString:@"delete"];
        }
    }
}

- (IBAction)returnPressed:(id)sender{
    
    [[UIDevice currentDevice] playInputClick];
    
    if ([self.textView isKindOfClass:[UITextView class]]) {
        [self.textView insertText:@"\n"];
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
    }
    else if([self.textView isKindOfClass:[UITextField class]]) {
        if ([[(UITextField *)self.textView delegate] respondsToSelector:@selector(textFieldShouldReturn:)]) {
            [[(UITextField *)self.textView delegate] textFieldShouldReturn:(UITextField *)self.textView];
        }
        
    }
}

- (IBAction)spacePressed:(id)sender{
    [[UIDevice currentDevice] playInputClick];
    [self.textView insertText:@" "];
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification
                                                        object:self.textView];
    if ([self.textView isKindOfClass:[UITextView class]])
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
    else if ([self.textView isKindOfClass:[UITextField class]])
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:(UITextField*)self.textView];
    
}
- (IBAction)shiftPressed:(id)sender{
    [[UIDevice currentDevice] playInputClick];
    isShift = !isShift;
    [self reShowStringKeyboard:nil];
}


- (NSRange) selectedRangeInTextView:(UITextView*)textView
{
    UITextPosition* beginning = textView.beginningOfDocument;
    
    UITextRange* selectedRange = textView.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [textView offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [textView offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

-(UIButton*)makeBtn:(float)x y:(float)y width:(float)w height:(float)h tagValue:(int)tagValue
              title:(NSString*)title action:(SEL)action addInfoView:(BOOL)infoViewOnOff {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [btn setTag:tagValue];
    if([title isEqualToString:@"<-"]) {
        [btn setImage:[UIImage imageNamed:@"pad_del.PNG"] forState:UIControlStateNormal];
    }else {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    if([title length] == 1) {
        [btn.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    }else {
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    }
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    if(infoViewOnOff) {
        [btn addTarget:self action:@selector(showInfoView:) forControlEvents:UIControlEventTouchDown];
        
        [btn addTarget:self action:@selector(closeInfoView) forControlEvents:UIControlEventTouchDragExit];
        [btn addTarget:self action:@selector(closeInfoView) forControlEvents:UIControlEventTouchUpInside];
    }
    [btn setBackgroundColor:[UIColor whiteColor]];
    return btn;
    
}

-(void)showInfoView:(id)sender {
    
    UIButton *btn = (UIButton*)sender;

    if(btn.titleLabel.text.length == 1) {
        [infoBackView setHidden:NO];
        

        [infoBackView setFrame:CGRectMake(btn.frame.origin.x - btn.frame.size.width*0.2 - 1,
                                      btn.frame.origin.y-btn.frame.size.height,
                                      btn.frame.size.width*1.4+2,
                                      btn.frame.size.height*1.4+2)];
        [infoBackView setBackgroundColor:[UIColor grayColor]];
        
        [infoView setBackgroundColor:[UIColor whiteColor]];
        [infoView setFrame:CGRectMake(1.0f,1.0f,
                                      btn.frame.size.width*1.4,
                                      btn.frame.size.height*1.4)];
        [infoLabel setFrame:CGRectMake(0.0f,0.0f, btn.frame.size.width*1.4, btn.frame.size.height)];
        [infoLabel setTextColor:[UIColor blackColor]];
        [infoLabel setText:btn.titleLabel.text];
        [infoLabel setFont:[UIFont systemFontOfSize:20.0f]];
        [infoLabel setTextAlignment:NSTextAlignmentCenter];
        [_keyboardView addSubview:infoBackView];
    }
    
     
}
-(void)closeInfoView {
    [infoBackView setHidden:YES];
}
@end
