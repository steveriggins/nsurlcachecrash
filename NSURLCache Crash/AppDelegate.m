//
//  AppDelegate.m
//  NSURLCache Crash
//
//  Created by Steven W. Riggins on 11/17/14.
//  Copyright (c) 2014 Steve Riggins. All rights reserved.
//


#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (id)init {
    if ((self = [super init])) {
        [NSURLCache setSharedURLCache:[self cacheInstance]];
    }
    return self;
}

- (NSUInteger)cacheMemoryCapacity
{
    return 1024 * 1024;
}

- (NSUInteger)cacheDiskCapacity
{
    return 1024 * 1024 * 300;
}

#pragma mark - Cache

- (NSURLCache *)cacheInstance
{
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"NSURLCache"];
    // Check for and delete the cache that is a remnant of past SDURLCache usage
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:cachePath error:nil];
    }

    NSUInteger memoryCapacity = [self cacheMemoryCapacity];
    NSUInteger diskCapacity = [self cacheDiskCapacity];
    NSURLCache *wmCache = [[NSURLCache alloc] initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:@"Cache.db"];
    return wmCache;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end