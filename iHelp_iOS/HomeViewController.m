//
//  HomeViewController.m
//  iHelp_iOS
//
//  Created by Birdy Chang on 2015/3/3.
//  Copyright (c) 2015年 Birdy Chang. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *helpButton;
@property (nonatomic) BOOL userAcceptDisclaimer;
@end

@implementation HomeViewController

#pragma mark - Properties

- (void)setUserAcceptDisclaimer:(BOOL)userAcceptDisclaimer {
    [[NSUserDefaults standardUserDefaults] setBool:userAcceptDisclaimer forKey:@"acceptDisclaimer"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.helpButton.enabled = userAcceptDisclaimer;
}

- (BOOL)userAcceptDisclaimer {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"acceptDisclaimer"];
}

#pragma mark - View controller methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.helpButton.enabled = self.userAcceptDisclaimer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.userAcceptDisclaimer) {
        [self displayDisclaimer];
    }
}

#pragma mark - Private methods

- (void)displayDisclaimer {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Disclaimer", nil) message:NSLocalizedString(@"message of disclaimer", nil) preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Agree", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.userAcceptDisclaimer = YES;
        });
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Disagree", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Actions
- (IBAction)onHelp:(UIButton *)sender {
    NSLog(@"onHelp");
}

- (IBAction)onSetting:(UIButton *)sender {
    NSLog(@"onSetting");
}

@end
