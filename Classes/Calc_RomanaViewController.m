//
//  Calc_RomanaViewController.m
//  Calc Romana
//
//  Created by Fred Fenimore on 8/23/09.
//  Copyright __Bugware__ 2009. All rights reserved.
//

#import "Calc_RomanaViewController.h"

@implementation Calc_RomanaViewController


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _calculator = [Calculator new];
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
 }
 */

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}
- (void)dealloc {
	[Calculator release];
    [super dealloc];
}
- (IBAction) press:(id)sender {
	NSString *validNextButtons = [_calculator input:[sender titleForState:UIControlStateNormal]];
	[decimalDisplayField setText:[_calculator displayDecimalValue]];
	[romanDisplayField setText:[_calculator displayRomanValue]];
	[romanDisplayField setPlaceholder:@""];
	[self setButtonStates:validNextButtons];
}
- (void) setButtonStates:(NSString*)validNextButtons {
	NSArray *sv = [ [self view] subviews];
	NSEnumerator *e = [sv objectEnumerator];
	id member ;
	while ((member = [e nextObject]))	{
		if ([member isKindOfClass:[UIButton class]]) {
			UIButton *button = member;
			NSString *title = [button titleForState:UIControlStateNormal];
			if ([_calculator isOperatorSymbol:title]) 
				continue;
			if ([validNextButtons rangeOfString:title].length > 0) {
				button.enabled = true;
			}
			else {
				button.enabled = false;
			}
		}
	}
}
@end
