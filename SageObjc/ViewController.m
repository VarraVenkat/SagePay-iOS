//
//  ViewController.m
//  SageObjc
//
//  Created by EGReddy on 24/03/17.
//  Copyright © 2017 EGReddy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import <CommonCrypto/CommonCrypto.h>

#import "CryptLib.h"
#import "NSData+Base64.h"
#import "AppDelegate.h"


@interface ViewController (){
    NSString *webLoadString;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myweb.delegate=self;
    
    //NSString * _key = @"TPjs72eMz5qBnaTa";
    
    NSString *base64Key  = @"VFBqczcyZU16NXFCbmFUYQ==";
    NSString *dataString = @"VendorTxCode=TxCode-498657-1&Amount=36.95&Currency=GBP&Description=description&Website=http://192.168.2.19:8080/sagepay-php/&CustomerName=Fname&Surname&CustomerEMail=gopalreddy.509@gmail.com&VendorEMail=gopalreddy2440@gmail.com&BillingSurname=Surname&BillingFirstnames=Fname&BillingAddress1=BillAddress Line 1&BillingCity=BillCity&BillingPostCode=W1A 1BL&BillingCountry=GB&BillingPhone=447933000000&DeliveryFirstnames=Fname&DeliverySurname=Surname&DeliveryAddress1=BillAddress Line 1&DeliveryCity=BillCity&DeliveryPostCode=W1A 1BL&DeliveryCountry=GB&DeliveryPhone=447933000000&SuccessURL=http://192.168.2.19:8080/sagepay-php/&FailureURL=http://192.168.2.19:8080/sagepay-php/";
    
    NSData *key  = [[NSData alloc] initWithBase64EncodedString:base64Key  options:0];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *encryptedData = [self crypt:data
                                          iv:key
                                         key:key
                                     context:kCCEncrypt];
    
    NSString *hex111 = [encryptedData hexadecimalString];

    webLoadString = [NSString stringWithFormat:@"https://test.sagepay.com/gateway/service/vspform-register.vsp?VPSProtocol=3.00&TxType=PAYMENT&Vendor=protxross&Crypt=@%@",[hex111 uppercaseString]];
    
}

//encryption

- (NSData *)crypt:(NSData *)dataIn iv:(NSData *)iv key:(NSData *)symmetricKey context:(CCOperation)encryptOrDecrypt
{
    CCCryptorStatus ccStatus   = kCCSuccess;
    size_t          cryptBytes = 0;    // Number of bytes moved to buffer.
    NSMutableData  *dataOut    = [NSMutableData dataWithLength:dataIn.length + kCCBlockSizeAES128];
    
    ccStatus = CCCrypt( encryptOrDecrypt,
                       kCCAlgorithmAES128,
                       kCCOptionPKCS7Padding,
                       symmetricKey.bytes,
                       kCCKeySizeAES128,
                       iv.bytes,
                       dataIn.bytes,
                       dataIn.length,
                       dataOut.mutableBytes,
                       dataOut.length,
                       &cryptBytes);
    
    if (ccStatus != kCCSuccess) {
        NSLog(@"CCCrypt status: %d", ccStatus);
    }
    dataOut.length = cryptBytes;
    
    return dataOut;
}

- (IBAction)loadWebview:(UIButton *)sender {
    
   // [[UIApplication sharedApplication]openURL:[NSURL URLWithString:webLoadString]];
    
    NSURL *url = [NSURL URLWithString:webLoadString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.myweb loadRequest:requestObj];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlString = [[request URL] absoluteString];
    NSLog(@"Contents: %@",urlString);//Logout
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *urlString = [[NSString alloc]initWithFormat:@"%@",webView.request.URL];
    
    if ([urlString rangeOfString:@"http://192.168.2.19:8080/sagepay-php/"].location == NSNotFound)
    {
        NSLog(@"string does not contain bla");
    }
    else
    {
        NSLog(@"string contains bla!");
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:urlString]
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSData *data2 = [newStr dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data2 options:0 error:nil];
                    NSLog(@"====%@",json);
                    NSString *status = [json objectForKey:@"Status"];
                    NSLog(@"status:%@",status);
                }]
         resume];
    }
    
    
    
    NSCachedURLResponse *resp = [[NSURLCache sharedURLCache] cachedResponseForRequest:webView.request];
    NSLog(@"call22:%@",[(NSHTTPURLResponse*)resp.response allHeaderFields]);
    
  //  NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
   // NSLog(@"html str:%@",html);
}

- (IBAction)goBack:(UIButton *)sender {
    [self.myweb goBack];
}

- (IBAction)goForward:(UIButton *)sender {
    [self.myweb goForward];
}

@end
