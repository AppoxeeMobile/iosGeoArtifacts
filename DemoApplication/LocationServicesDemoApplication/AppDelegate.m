//
//  AppDelegate.m
//  LocationServicesDemoApplication
//
//  Created by Raz Elkayam on 8/17/15.
//  Copyright (c) 2015 Teradata. All rights reserved.
//

#import "AppDelegate.h"
#import <AppoxeeSDK/AppoxeeSDK.h>
#import "APXRichContentViewController.h"
#import <AppoxeeLocationServices/AppoxeeLocationServices.h>

@interface AppDelegate () <AppoxeeDelegate, AppoxeeLocationManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[Appoxee shared] engageAndAutoIntegrateWithLaunchOptions:launchOptions andDelegate:self];
    
    // Set an observer, and enable location monitoring when AppoxeeSDK is ready. This can also be achived when listening to @"APX_Ready" notification with NSNotificationCenter
    [[Appoxee shared] addObserver:self forKeyPath:@"isReady" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
    
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isReady"]) {
        
        [[Appoxee shared] removeObserver:self forKeyPath:@"isReady"];
        [[AppoxeeLocationManager shared] setDelegate:self];
        [[AppoxeeLocationManager shared] enableLocationMonitoring];
    }
}

#pragma mark - Schemes

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [self handleScheme:url];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options
{
    [self handleScheme:url];
    
    return YES;
}

- (void)handleScheme:(NSURL *)scheme
{
    [[NSUserDefaults standardUserDefaults] setObject:[scheme description] forKey:@"urlScheme"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"urlScheme" object:nil];
}

#pragma mark - AppoxeeDelegate

- (void)appoxeeManager:(AppoxeeManager *)manager handledRemoteNotification:(APXPushNotification *)pushNotification andIdentifer:(NSString *)actionIdentifier
{
    // a push notification was received.
}

- (void)appoxeeManager:(AppoxeeManager *)manager handledRichContent:(APXRichMessage *)richMessage didLaunchApp:(BOOL)didLaunch
{
    if (didLaunch) {
        
        // If a Rich Message launched the app, we will display it's content.
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        APXRichContentViewController *richContent = [storyboard instantiateViewControllerWithIdentifier:@"APXRichContentViewController"];
        [richContent setHtml:richMessage.messageLink];
        
        [self.window.rootViewController presentViewController:richContent animated:NO completion:nil];
    }
}

#pragma mark - AppoxeeLocationManagerDelegate

- (void)locationManager:(AppoxeeLocationManager *)manager didFailWithError:(NSError *)error
{
    // Check what is the cause to the error.
    NSLog(@"Error: %@", [error description]);
}

- (void)locationManager:(AppoxeeLocationManager *)manager didEnterGeoRegion:(CLCircularRegion *)geoRegion
{
    // Entered a region.
    // Notice that the .identifier @property of the CLCircularRegion instance is the location ID as created By Teradata.
    
    NSLog(@"Entered location id of: %@, of coordinates: %.2f | %.2f, with radius: %.2f", geoRegion.identifier, geoRegion.center.latitude, geoRegion.center.longitude, geoRegion.radius);
}

- (void)locationManager:(AppoxeeLocationManager *)manager didExitGeoRegion:(CLCircularRegion *)geoRegion
{
    // Exited a region.
    // Notice that the .identifier @property of the CLCircularRegion instance is the location ID as created By Teradata.
    
    NSLog(@"Entered location id: %@, of coordinates: %.2f | %.2f, with radius: %.2f", geoRegion.identifier, geoRegion.center.latitude, geoRegion.center.longitude, geoRegion.radius);
}

@end
