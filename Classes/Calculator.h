//
//  Calculator.h
//  Calc
//
//  Created by Fred Fenimore on 8/14/09.
//  Copyright 2009 __Bugware__. All rights reserved.
//

#import <Foundation/NSArray.h>
#import <UIKit/UIKit.h>
#import "Number.h"

@interface Calculator : NSObject {
@private
	NSMutableString *_decimalDisplay;
	NSMutableString *_romanDisplay;
	
	Number			*_current;
	Number			*_runningTotal;
	Number			*_display;
	
	NSString        *_pendingOperator;
}

- init;
- (void) dealloc;

- (void) reset;
- (void) doPendingOp;

- (NSString*) input:(NSString *) character;

- (NSString *) displayDecimalValue;
- (NSString *) displayRomanValue;

- (void) checkRoman:(NSString*) character ;
- (void) checkOperator:(NSString *) character ;

- (Boolean) isOperatorSymbol:(NSString *) character ;
@end