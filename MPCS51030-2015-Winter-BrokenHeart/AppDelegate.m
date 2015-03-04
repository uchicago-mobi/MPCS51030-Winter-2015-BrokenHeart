//
//  AppDelegate.m
//  MPCS51030-2015-Winter-BrokenHeart
//
//  Created by T. Andrew Binkowski on 3/1/15.
//  Copyright (c) 2015 Department of Computer Science, The University of Chicago. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Register non-interactive notifications
    //[self registerForNotifications];

    // Register interactive notifications
    [self registerForNotificationsWithActions];
    
    // Test and handle launching from a notification
    NSLog(@"Launch Options:%@",launchOptions);
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    // If not nil, the application was based on an incoming notifiation
    if (notification) {
        // Access the payload content
        NSLog(@"Notification payload: %@", [notification.userInfo objectForKey:@"payload"]);
        
        // Show an alert view so we can verify this launch sequence
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"LocalNotifications from didFinishLaunchingWithOptions"
                                                        message:@"Notifications from application"
                                                       delegate:self cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    return YES;
}


///-----------------------------------------------------------------------------
#pragma mark - Notification Registration and Handling
///-----------------------------------------------------------------------------
- (void)registerForNotifications
{
    // Note the `nil` categories
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeAlert | UIUserNotificationTypeBadge |UIUserNotificationTypeSound
                                                                             categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)registerForNotificationsWithActions
{
    // Action 1
    UIMutableUserNotificationAction *action1;
    action1 = [[UIMutableUserNotificationAction alloc] init];
    [action1 setActivationMode:UIUserNotificationActivationModeBackground];
    [action1 setTitle:@"Action 1"];
    [action1 setIdentifier:NotificationActionOneIdent];
    [action1 setDestructive:NO];
    [action1 setAuthenticationRequired:NO];
    
    // Action 2
    UIMutableUserNotificationAction *action2;
    action2 = [[UIMutableUserNotificationAction alloc] init];
    [action2 setActivationMode:UIUserNotificationActivationModeBackground];
    [action2 setTitle:@"Action 2"];
    [action2 setIdentifier:NotificationActionTwoIdent];
    [action2 setDestructive:NO];
    [action2 setAuthenticationRequired:NO];
    
    // Create a category with actions
    UIMutableUserNotificationCategory *actionCategory;
    actionCategory = [[UIMutableUserNotificationCategory alloc] init];
    [actionCategory setIdentifier:NotificationCategoryIdent];
    [actionCategory setActions:@[action1, action2]
                    forContext:UIUserNotificationActionContextDefault];
    NSSet *categories = [NSSet setWithObject:actionCategory];
    
    // Register the notification
    UIUserNotificationType types = (UIUserNotificationTypeAlert|
                                    UIUserNotificationTypeSound|
                                    UIUserNotificationTypeBadge);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}


///-----------------------------------------------------------------------------
#pragma mark - Notification Handling
///-----------------------------------------------------------------------------

/** 
 Received when application was in background or foreground
 */
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"Received Local Notification:%@",notification);
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        
        // Display a UIAlertView (that will pose as a notification alert)
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Local Notification Recieved"
                                                            message:@"This is called when the app is in the foreground."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles: nil];
        [alertView show];
    }
}

/**
 Handle the tap actions from interactive notifications (these are happening when the 
 application is in background (i.e. they don't launch the application
 */
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier
                                                       forLocalNotification:(NSDictionary *)userInfo
                                                          completionHandler:(void (^)())completionHandler
{
    if ([identifier isEqualToString:NotificationActionOneIdent]) {
        NSLog(@"You chose action 1.");
    } else if ([identifier isEqualToString:NotificationActionTwoIdent]) {
        NSLog(@"You chose action 2.");
    }
    if (completionHandler) {
        completionHandler();
    }
}

@end
