//
//  Calculator.m
//  Calc
//
//  Created by Fred Fenimore on 8/14/09.
//  Copyright 2009 __Bugware__. All rights reserved.
//

#import "Calculator.h"

const NSString *Operators   = @"+-*/=";
const NSString *Digits      = @"0123456789.";
const NSString *Clear       = @"∅";
const NSString *Equals		= @"=";

@implementation Calculator

#pragma mark Lifecycle
- init {
	if (self = [super init]) {
		_decimalDisplay = [[NSMutableString stringWithCapacity:20] retain];
		_romanDisplay = [[NSMutableString stringWithCapacity:20] retain];
		_runningTotal = [[Number alloc] init];
		_current = [[Number alloc] init];
		[self reset];
	}
	return self;
}
- (void) dealloc {
	[_decimalDisplay release];
	[_romanDisplay release];
	[_pendingOperator release];
	[_current release];
	[super dealloc];
}

#pragma mark Calculator Operation
- (NSString*) input:(NSString *) character {
	if ([character isEqual:Clear])
		[self reset];

	[self checkOperator:(NSString *) character];
	[self checkRoman:(NSString *) character];

	[_romanDisplay setString:[_display asRoman]];
	[_decimalDisplay setString:[_display asDecimal]];
	
	NSString *r = [NSString stringWithFormat:@"%@%@%@%@",[_current validNextCharacters],Operators,Clear,Equals];
	return r;	
}
- (void) reset {
	[_runningTotal reset];
	[_current reset];
	_pendingOperator = nil;
}
- (void) checkRoman:(NSString*) character {
	_display = _current;
	[_current inputCharacter:character];
}
- (void) checkOperator:(NSString *) character {
	if ([Operators rangeOfString:character].length  == 0)
		return;


	[self doPendingOp];
	if ([Operators rangeOfString: character].location < 4) // a new operation
	{
		_display = _current;
		_pendingOperator = character;
	}
	else {
		_display = _runningTotal;
		_pendingOperator = nil;
	}
	[_current reset];
	
}
- (void) doPendingOp {
	if (nil == _pendingOperator) {
		[_runningTotal add:_current];
		return;
	}
	
	switch ([Operators rangeOfString: _pendingOperator].location) {
		case 0: // +
			[_runningTotal add: _current];
			break;
		case 1: // -
			[_runningTotal subtract: _current];
			break;
		case 2:// *
			[_runningTotal multiply: _current];
			break;
		case 3:// /
			[_runningTotal divide: _current];
			break;
	}
}
- (Boolean) isOperatorSymbol:(NSString *) character {
	return [Operators rangeOfString:character].length > 0;
}

#pragma mark Outlets
- (NSString *) displayDecimalValue {
	if ([_decimalDisplay length]) {
		return [[_decimalDisplay copy] autorelease];
	}
	return @"0";
}
- (NSString *) displayRomanValue {
	if ([_romanDisplay length]) {
		return [[_romanDisplay copy] autorelease];
	}
	return @"";
}
@end
