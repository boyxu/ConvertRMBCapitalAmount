//
//  ViewController.m
//  ConvertToRMB
//
//  Created by 徐英杰 on 15/4/1.
//  Copyright (c) 2015年 徐英杰. All rights reserved.
//

#import "ViewController.h"
#import "XYJNumberConverter.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)textFieldTextDidChanged:(UITextField *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
}

- (IBAction)textFieldTextDidChanged:(UITextField *)textField {
    double amount = [textField.text doubleValue];
    
    self.label.text = [XYJNumberConverter chineseCapitalForNumber:@(amount)];
    if (amount == 0) {
        self.label.text = nil;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *text = textField.text;
    if ([text length] == 0 && [string isEqualToString:@"."]) {
        textField.text = @"0.";
        return NO;
    }
    if (!([text length] > 0) && [text floatValue] == 0 && [string isEqualToString:@"0"]) {
        return NO;
    }
    if ([text isEqualToString:@"0"] && [string length] > 0 && ![string isEqualToString:@"."]) {
        textField.text = string;
        return NO;
    }
    if ([string length] == 0 && range.length > 0) {//删除键
        return YES;
    }
    if ([string isEqualToString:@"."] && [text rangeOfString:@"."].length > 0) {
        return NO;
    }
    if ([text rangeOfString:@"."].length > 0 && [[text componentsSeparatedByString:@"."][1] length] >= 2) {
        return NO;
    }
    return YES;
}


@end
