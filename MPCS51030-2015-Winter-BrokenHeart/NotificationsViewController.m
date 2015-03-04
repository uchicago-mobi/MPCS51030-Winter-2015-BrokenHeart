//
//  NotificationsViewController.m
//  MPCS51030-2015-Winter-BrokenHeart
//
//  Created by T. Andrew Binkowski on 3/2/15.
//  Copyright (c) 2015 Department of Computer Science, The University of Chicago. All rights reserved.
//

#import "NotificationsViewController.h"

@interface NotificationsViewController ()

@end

@implementation NotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/**
 Launch a local notification after 10 seconds
 */
- (IBAction)tap10Seconds:(UIButton *)sender
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    localNotification.alertBody = [NSString stringWithFormat:@"Alert Fired at %@", [NSDate date]];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1;
    localNotification.category = NotificationCategoryIdent;

    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
