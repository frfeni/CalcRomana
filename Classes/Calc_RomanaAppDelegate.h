//
//  Calc_RomanaAppDelegate.h
//  Calc Romana
//
//  Created by Fred Fenimore on 8/23/09.
//  Copyright __Bugware__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Calc_RomanaViewController;

@interface Calc_RomanaAppDelegate : NSObject <UIApplicationDelegate> {
    IBOutlet UIWindow *window;
    Calc_RomanaViewController *viewController;
}

@property (nonatomic, retain)  IBOutlet UIWindow *window;
@property (nonatomic, retain)  Calc_RomanaViewController *viewController;

@end

