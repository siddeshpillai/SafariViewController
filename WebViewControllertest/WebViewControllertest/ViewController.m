//
//  ViewController.m
//  WebViewControllertest
//
//  Created by Siddesh Pillai on 6/8/18.
//  Copyright © 2018 Siddesh Pillai. All rights reserved.
//

#import "ViewController.h"
@import SafariServices;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Press Me" forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = CGPointMake(320/2, 60);
    
    // Add an action in current code file (i.e. target)
    [button addTarget:self action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];

}

- (void)buttonPressed:(UIButton *)button {

    NSString *sURL = @"http://google.com";
    NSURL *URL = [NSURL URLWithString:sURL];
//    SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:URL]; // 1.
    SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:URL entersReaderIfAvailable:YES]; // 2.
    safari.delegate = self;
    [self presentViewController:safari animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SFSafariViewController delegate methods
-(void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
    // Load finished
    
    NSLog(@"Load finished");
    
}

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    // Done button pressed
    
    NSLog(@"Done button pressed");
    
}

@end
