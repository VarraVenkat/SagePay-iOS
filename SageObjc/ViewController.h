//
//  ViewController.h
//  SageObjc
//
//  Created by EGReddy on 24/03/17.
//  Copyright © 2017 EGReddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *myweb;
- (IBAction)loadWebview:(UIButton *)sender;
- (IBAction)goBack:(UIButton *)sender;
- (IBAction)goForward:(UIButton *)sender;

@end

