//
//  ViewController.m
//  NSURLCache Crash
//
//  Created by Steven W. Riggins on 11/17/14.
//  Copyright (c) 2014 Steve Riggins. All rights reserved.
//


#import "ViewController.h"


@interface ViewController () <NSURLConnectionDataDelegate>

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self fireAppVersion];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fireAppVersion
{
    NSURL *url = [NSURL URLWithString:@"http://mobile.walmart.com/m/j?service=AppVersion&method=getVersionRequired&p1=com.walmart.electronics&e=1"];
    [self fireServiceAPI:url];
}

- (IBAction)fireExtendedItem
{
    NSURL *url = [NSURL URLWithString:@"https://mobile.walmart.com/m/j?service=ExtendedItem&method=get&p1=27653030&version=4&e=1"];
    [self fireServiceAPI:url];
}


- (void)fireServiceAPI:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSCachedURLResponse *response = [self cachedResponseForRequest:request];
    if (!response)
    {
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
        [connection start];
    }
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request
{
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    NSCachedURLResponse *response = [urlCache cachedResponseForRequest:request];

    [urlCache removeCachedResponseForRequest:request];
    return nil;
}



@end