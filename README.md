# CustomKeyboard
[iOS]CustomKeyboard

## Installation & Usage

### Setup
Make sure to import "CustomKeyBoard.h" into your view controller's header file.


### Usage
Insert the following into the viewDidLoad of your view controller or wherever else you see fit.

YouProjectFile.h
```objective-c
@property (nonatomic, strong) CustomKeyBoard *keyboard;
@property (nonatomic, strong) IBOutlet UITextField *tf_keyboard;
```
YouProjectFile.m
```objective-c
-(void)viewDidLoad {
	UIScreen *mainScreen = [UIScreen mainScreen];
	keyboard = [[CustomKeyBoard alloc] init:mainScreen.bounds.size.width height:mainScreen.bounds.size.width*0.7 textView:tf_keyboard];
	tf_keyboard.delegate = self;
}

```
