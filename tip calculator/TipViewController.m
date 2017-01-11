//
//  ViewController.m
//  tip calculator
//
//  Created by Seth Bertalotto on 1/9/17.
//  Copyright © 2017 Seth Bertalotto. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UIView *top;
@property (weak, nonatomic) IBOutlet UIView *bottom;

@end

@implementation TipViewController


// -------- Lifecycle Events --------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tip Calculator";
    
    // hide the ui
    self.top.transform = CGAffineTransformMakeScale(0,0);
    self.bottom.transform = CGAffineTransformMakeScale(0,0);
    
    // animate into view
    [UIView animateWithDuration:0.4 animations:^{
        self.top.transform = CGAffineTransformIdentity;
        self.bottom.transform = CGAffineTransformIdentity;
    }];
    
    [self updateValues];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateTheme];
    [self updateTipControl];
    [self updateValues];
    
    // ensure bill field is focused
    [self.billTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// -------- Event Handlers --------
- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)onBillValueChanged:(UITextField *)sender {
    [self updateValues];
}

- (IBAction)onTipValueChange:(UISegmentedControl *)sender {
    [self updateValues];
}

// -------- Control Methods --------
- (void)updateTheme {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // get saved theme
    bool theme = [defaults boolForKey:@"theme"];

    // change color if theme is set
    if (theme) {
        self.top.backgroundColor = [UIColor purpleColor];
    } else {
        self.top.backgroundColor = [UIColor redColor];
    }
}

- (void)updateTipControl {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // get default tip percentage if set
    long defaultTipPercentage = [defaults floatForKey:@"defaultTipPercentage"];
    self.tipControl.selectedSegmentIndex = defaultTipPercentage;
}

- (void)updateValues {
    // get bill amount
    float billAmount = [self.billTextField.text floatValue];
    
    // compute tip and total
    NSArray *tipValues = @[@(0.15), @(0.2), @(0.25)];
    float tipAmount = [tipValues[self.tipControl.selectedSegmentIndex] floatValue] * billAmount;
    float totalAmount = billAmount + tipAmount;
    
    // update the UI
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

@end
