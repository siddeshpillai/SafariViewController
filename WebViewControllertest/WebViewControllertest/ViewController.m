//
//  ViewController.m
//  WebViewControllertest
//
//  Created by Siddesh Pillai on 6/8/18.
//  Copyright © 2018 Siddesh Pillai. All rights reserved.
//

#import "ViewController.h"
@import SafariServices;


@interface ViewController () {
    SFSafariViewController *sfSafariViewController;
}

@end

@implementation ViewController

SFAuthenticationSession *_authenticationVC;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(safariCallback:) name:@"SafariCallback" object:nil];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Case 1" forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = CGPointMake(320/2, 60);
    
    // Add an action in current code file (i.e. target)
    [button addTarget:self action:@selector(type1:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

// Case 1: open in view
- (void)type1:(UIButton *)button {
    
    NSString *sURL = @"https://www.arcgis.com/sharing/rest/oauth2/authorize/?hidecancel=true&client_id=ud2XLznQs9P57ugn&grant_type=code&response_type=code&expiration=-1&redirect_uri=safariviewcontrollertest://&locale=en";
    
    NSURL *URL = [NSURL URLWithString:sURL];
    
    //SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:URL];
    sfSafariViewController = [[SFSafariViewController alloc] initWithURL:URL];
    sfSafariViewController.configuration.barCollapsingEnabled = false;
    sfSafariViewController.delegate = self;
//    sfSafariViewController.transitioningDelegate = self;
//    safari.delegate = self;
//    sfSafariViewController.dismissButtonStyle = SFSafariViewControllerDismissButtonStyleCancel;
//    sfSafariViewController.preferredBarTintColor = UIColor.blackColor;
//    sfSafariViewController.preferredControlTintColor = UIColor.grayColor;
    
//    sfSafariViewController = safari;
    
    [self presentViewController:sfSafariViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SFSafariViewController delegate methods
-(void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
    // Load finished
    
    NSLog(@"Load finished");
    
    if (didLoadSuccessfully) {
        NSLog(@"SafariViewController: Loading of URL finished");
    }    
}

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    // Done button pressed    
    NSLog(@"Done button pressed");
}

- (void)safariCallback:(NSNotification *)notification {
    // Dismiss View
    [self dismissViewControllerAnimated:NO completion:nil];

    // Extract information from notification
    NSDictionary *dict = [notification userInfo];
    NSString *value = [dict objectForKey:@"key"];
    NSLog(@"Value is %@", value);
    
    // Show result as alert dialog
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Key content" message:value preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
