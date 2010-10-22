//
//  Calc_RomanaViewController.h
//  Calc Romana
//
//  Created by Fred Fenimore on 8/23/09.
//  Copyright __Bugware__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculator.h"

@interface Calc_RomanaViewController : UIViewController {
	IBOutlet id decimalDisplayField;
	IBOutlet id romanDisplayField;
	Calculator *_calculator;
}

- (IBAction) press:(id)sender;
- (void) setButtonStates:(NSString*)validNextButtons ;

@end

