//
//  ViewController.m
//  MPCS51030-2015-Winter-BrokenHeart
//
//  Created by T. Andrew Binkowski on 3/1/15.
//  Copyright (c) 2015 Department of Computer Science, The University of Chicago. All rights reserved.
//

#import "ViewController.h"
#import "Heart.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *hearts;
@end

@implementation ViewController


/*
 This is a multiline comment
 */

// This is a single line comment


//#warning This is a warning

//#error You need to fix this


// FIXME: fix me

// ???: what is this?

// !!!: pay attention

// TODO: Do this message


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create an array so that we have a loop to debug
    self.hearts = [NSMutableArray arrayWithCapacity:255];
    for (int i=0; i<255; i++) {
        CGRect frame = CGRectMake(i+5, i+5, 20, 20);
        
        // Create a heart object and store the frame and color
        Heart *heart = [[Heart alloc] initWithFrame:frame];
        heart.backgroundColor = RGB(i, 0, 0);
        heart.tag = i;
        [self.hearts addObject:heart];
        
    }
}

/** 
 There should be a [super viewDidAppear:] call here, but it is ommited to
 highlight Code Analysis (shift-command B)
 */
- (void)viewDidAppear:(BOOL)animated
{
    // Add the hearts
    for (Heart *heart in self.hearts) {
        [self.view addSubview:heart];
    }

}



@end
