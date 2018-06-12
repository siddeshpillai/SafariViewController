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
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

    [center addObserver:self
            selector:@selector(receiveTestNotification:)
            name:@"TestNotification"
            object:self];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Press Me" forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = CGPointMake(320/2, 60);
    
    // Add an action in current code file (i.e. target)
    [button addTarget:self action:@selector(buttonPressed2:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];

}

- (void)buttonPressed2:(UIButton *)button {
    NSURL *destinationUrl = [NSURL URLWithString:@"https://www.arcgis.com/sharing/rest/oauth2/authorize/?hidecancel=true&client_id=arcgiscompanion&grant_type=code&response_type=code&expiration=-1&redirect_uri=urn:ietf:wg:oauth:2.0:oob&locale=en"];
    
    NSString *redirectScheme = @"safariviewcontrollertest://";
    
    if (@available(iOS 11.0, *)) {
        
        SFAuthenticationSession* authenticationVC = [[SFAuthenticationSession alloc]
                                                     initWithURL: destinationUrl
                                                     callbackURLScheme: redirectScheme
                                                     completionHandler: ^(NSURL * _Nullable callbackURL,
                                                     NSError * _Nullable error)
        {
            _authenticationVC = nil;
            
            if (callbackURL)
            {
                NSString *oauthToken = callbackURL.absoluteString;
                NSLog(@"%@",oauthToken);
                
                NSURLComponents *components = [NSURLComponents componentsWithString:[oauthToken stringByReplacingOccurrencesOfString:@"#" withString:@"&"]];
                
                for (NSURLQueryItem *item in components.queryItems)
                {
                    if ([item.name isEqualToString:@"access_token"])
                    {
                        NSLog(@"%@", item.value);
                        
                    }
                }
                
                NSLog(@"%@", components.queryItems);

            }
            else
            {
                NSLog(@"%@",[error localizedDescription]);
            }
        }];
        
        _authenticationVC = authenticationVC;

        BOOL started = [_authenticationVC start];
        
        if (started)
        {
            NSLog(@"SFAuthenticationSession: Loading of URL finished");
        }
        else
        {
            NSLog(@"Unable to open in safari");
        }
    }
    else
    {
        // Our app is only iOS 9+, so we can assume SFSafariViewController is present here.
        SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:destinationUrl];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)buttonPressed:(UIButton *)button {

    NSString *sURL = @"https://www.arcgis.com/sharing/rest/oauth2/authorize/?hidecancel=true&client_id=arcgiscompanion&grant_type=code&response_type=code&expiration=-1&redirect_uri=urn:ietf:wg:oauth:2.0:oob&locale=en";
    NSURL *URL = [NSURL URLWithString:sURL];
    
    SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:URL];
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
    
    if (didLoadSuccessfully) {
        NSLog(@"SafariViewController: Loading of URL finished");
    }
    
}

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    // Done button pressed
    
    NSLog(@"Done button pressed");
    
    
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"TestNotification"])
        NSLog (@"Successfully received the test notification!");
}


@end
