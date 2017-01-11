//
//  SettingsViewController.m
//  tip calculator
//
//  Created by Seth Bertalotto on 1/9/17.
//  Copyright © 2017 Seth Bertalotto. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipPercentage;
@property (weak, nonatomic) IBOutlet UISwitch *theme;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Set up the default tip value
    long defaultTipPercentage = [defaults integerForKey:@"defaultTipPercentage"];
    self.defaultTipPercentage.selectedSegmentIndex = defaultTipPercentage;
    
    // Set up the theme
    bool theme = [defaults boolForKey:@"theme"];
    [self.theme setOn:theme];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onTipChanged:(UISegmentedControl *)sender {
    long selectedTip = self.defaultTipPercentage.selectedSegmentIndex;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:selectedTip forKey:@"defaultTipPercentage"];
    [defaults synchronize];
}

- (IBAction)onThemeChanged:(UISwitch *)sender {
    bool isOn = self.theme.isOn;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isOn forKey:@"theme"];
    [defaults synchronize];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
