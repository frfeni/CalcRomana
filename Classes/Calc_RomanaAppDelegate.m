//
//  Calc_RomanaAppDelegate.m
//  Calc Romana
//
//  Created by Fred Fenimore on 8/23/09.
//  Copyright __Bugware__ 2009. All rights reserved.
//

#import "Calc_RomanaAppDelegate.h"
#import "Calc_RomanaViewController.h"

@implementation Calc_RomanaAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    Calc_RomanaViewController *_viewController = [[Calc_RomanaViewController alloc] initWithNibName:@"Calc_RomanaViewController"bundle:nil];
	self.viewController = _viewController;
	
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
