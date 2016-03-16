//
//  FormTextField.m
//  GSLVideoCallApp
//
//  Created by Aniket on 15/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "FormTextField.h"
#import "Constant.h"

@implementation FormTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self applyCustomization];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self applyCustomization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self applyCustomization];
    }
    
    return self;
}

- (void)applyCustomization {
     self.layer.cornerRadius = 5.0;
    [self setFont:[UIFont fontWithName:kHELVETICA_NEUE_LIGHT size:14]];
     self.layer.masksToBounds = YES;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, self.frame.size.height)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = kCGCOLOR_FROM_HEX(@"DDDDDD");
    self.textColor = kUICOLOR_FROM_HEX(@"666666");
    
   // [self setUpTextField];
}

- (void)setUpTextField{
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(doneTap:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.inputAccessoryView = keyboardDoneButtonView;
}

- (void)doneTap:(UITextField *)textField{
    [textField resignFirstResponder];
}

@end
