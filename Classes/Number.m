//
//  Number.m
//  CalcRomana
//
//  Created by Fred Fenimore on 9/5/09.
//  Copyright 2009 __Bugware__. All rights reserved.
//

#import "Number.h"
const NSString *RomanDigits = @".SIVXLCDM";


@implementation Number
#pragma mark Lifecycle
- init {
	if (self = [super init]) {
		[self reset];
		romanDots =		[[NSArray alloc] initWithObjects:	@"",	@".",	@"..",		@"...",		@"....",	@".....",	nil];
		romanSs =		[[NSArray alloc] initWithObjects:	@"",	@"S",	nil];
		roman1s =		[[NSArray alloc] initWithObjects:	@"",	@"I",	@"II",		@"III",		@"IV",		@"V",	@"VI",		@"VII",		@"VIII",	@"IX",	nil];
		roman10s =		[[NSArray alloc] initWithObjects:	@"",	@"X",	@"XX",		@"XXX",		@"XL",		@"L",	@"LX",		@"LXX",		@"LXXX",	@"XC",	nil];
		roman100s =		[[NSArray alloc] initWithObjects:	@"",	@"C",	@"CC",		@"CCC",		@"CD",		@"D",	@"DC",		@"DCC",		@"DCCC",	@"CM",	nil];
		roman1000s =	[[NSArray alloc] initWithObjects:	@"",	@"M",	@"MM",		@"MMM",		@"IV",		@"V",	@"VI",		@"VII",		@"VIII",	@"IX",	nil];
		roman10000s =	[[NSArray alloc] initWithObjects:	@"",	@"X",	@"XX",		@"XXX",		@"XL",		@"L",	@"LX",		@"LXX",		@"LXXX",	@"XC",	nil];
		roman100000s =	[[NSArray alloc] initWithObjects:	@"",	@"C",	@"CC",		@"CCC",		@"CD",		@"D",	@"DC",		@"DCC",		@"DCCC",	@"CM",	nil];
	}
	return self;
}
- (void) dealloc {
	[super dealloc];
}

#pragma mark State
- (void) reset {
	_operand = 0;
	_numTwelvths = 0;
	_validNextCharacters = @".SIVXLCDM";
}
- (float) value {
	return _operand + (_numTwelvths / 12.0);
}

#pragma mark Conversion
- (NSString *) asRoman {
	float fullNumber = _operand + (_numTwelvths / 12.0);
	
	if (fullNumber >= 1000000)
		return @"Number is too large to display.";
	if (fullNumber < 0)
		return @"Number is too small to display.";
	
	int number100M = (int)fullNumber / 100000; fullNumber -= (number100M * 100000);	
	int number10M = (int)fullNumber / 10000; fullNumber -= (number10M * 10000);		
	int numberM = (int)fullNumber / 1000;	fullNumber -= (numberM * 1000);			
	int numberC = (int)fullNumber / 100;	fullNumber -= (numberC * 100);			
	int numberX = (int)fullNumber / 10;	fullNumber -= (numberX * 10);				
	int numberI = (int)fullNumber / 1;	fullNumber -= (numberI * 1);
	int numberS = (fullNumber >= 0.5? 1 : 0); if (numberS > 0) fullNumber -= 0.5;
	
	int numberDots = 0;
	if (fullNumber > 0)
	{
		if (fullNumber <= 0.084)
			numberDots = 1;
		else	if (fullNumber <= 0.17)
			numberDots = 2;
		else	if (fullNumber <= 0.25)
			numberDots = 3;
		else	if (fullNumber <= 0.34)
			numberDots = 4;
		else	if (fullNumber <= 0.42)
			numberDots = 5;
	}
	
	// and reset it so we know how large it is
	fullNumber = _operand + (_numTwelvths / 12.0);
		
	NSString *largePart = @"";
	NSString *string100M = [roman100000s objectAtIndex:number100M];
	NSString *string10M = [string100M stringByAppendingString:[roman10000s objectAtIndex:number10M]];
	NSString *stringM = [string10M stringByAppendingString:[roman1000s objectAtIndex:numberM]];
	if (fullNumber >= 4000) // this is the cutoff where the larger part is in parens to indicate 1000's 
	{
		largePart = @"(";
		largePart = [largePart stringByAppendingString: stringM];
		largePart = [largePart stringByAppendingString:@")"];
	}
	else
		largePart = stringM;
	
	NSString *smallPart = @"";
	NSString *stringC = [smallPart stringByAppendingString:[roman100s objectAtIndex:numberC]];
	NSString *stringX = [stringC stringByAppendingString:[roman10s objectAtIndex:numberX]];
	NSString *stringI = [stringX stringByAppendingString:[roman1s objectAtIndex:numberI]];
	smallPart = stringI;

	NSString *fractionPart = @"";
	if ((numberS > 0) || (numberDots > 0))
	{
		NSString *stringSpace = @" ";
		NSString *stringS = [stringSpace stringByAppendingString:[romanSs objectAtIndex:numberS]];
		NSString *stringDots = [stringS stringByAppendingString:[romanDots objectAtIndex:numberDots]];
		if ([stringDots length] > 0)
			fractionPart = stringDots;
	}
		
	NSString *returnVal = largePart;
	returnVal = [returnVal stringByAppendingString:smallPart];
	returnVal = [returnVal stringByAppendingString:fractionPart];
	return returnVal;
}
- (NSString *) asDecimal {
	return [NSString stringWithFormat:@"%0.2f", [self value]];
}

#pragma mark Operations/
-(void) addTwelfths:(int) val {
	_numTwelvths += 1;
}
-(void) add:(Number*) val {
	float me = [self value];
	float them = [val value];
	_operand = me + them;
}
-(void) subtract:(Number*) val {
	float me = [self value];
	float them = [val value];
	_operand = me - them;
}
-(void) multiply:(Number*) val {
	float me = [self value];
	float them = [val value];
	_operand = me * them;
}
-(void) divide:(Number*) val {
	float me = [self value];
	float them = [val value];
	_operand = me / them;	
}

- (void) addInt:(int) val {
	_operand += val;
}
- (void) addFloat:(float) val {
	_operand += val;
}

- (void) inputCharacter:(NSString*) character {
	if ([RomanDigits rangeOfString:character].length == 0)
		return;

	static NSString *lastCharacter;
	
	switch ([RomanDigits rangeOfString:character].location) {
		case 0: //.
			[self addTwelfths: 1];
			break;
		case 1: //S
			[self addFloat: 0.5]; 
			break;
		case 2: //I
			[self addInt: 1];
			break;
		case 3: //V
			if ([lastCharacter isEqualToString:@"I"])
				[self addInt: 3]; // IV is 4 but we already added the 1
			else
				[self addInt: 5];
			break;
		case 4://X
			if ([lastCharacter isEqualToString:@"I"])
				[self addInt: 8]; 
			else				
				[self addInt: 10];
			break;
		case 5://L
			if ([lastCharacter isEqualToString:@"X"])
				[self addInt: 30];
			else
				[self addInt: 50];
			break;
		case 6://C
			if ([lastCharacter isEqualToString:@"X"])
				[self addInt: 80];
			else
				[self addInt: 100];
			break;
		case 7://D
			if ([lastCharacter isEqualToString:@"C"])
				[self addInt: 300];
			else
				[self addInt: 500];
			break;
		case 8://M
			if ([lastCharacter isEqualToString:@"C"])
				[self addInt: 800];
			else
				[self addInt: 1000];
			break;
		default:
			break;
	}
	lastCharacter = character;
	[self figureValidNextCharacters:character];
}
- (void) figureValidNextCharacters:(NSString*) character {
	float fullNumber = _operand + (_numTwelvths / 12.0);
	
	int number100M = (int)fullNumber / 100000; fullNumber -= (number100M * 100000);	
	int number10M = (int)fullNumber / 10000; fullNumber -= (number10M * 10000);		
	int numberM = (int)fullNumber / 1000;	fullNumber -= (numberM * 1000);			
	int numberC = (int)fullNumber / 100;	fullNumber -= (numberC * 100);			
	int numberX = (int)fullNumber / 10;	fullNumber -= (numberX * 10);				
	int numberI = (int)fullNumber / 1;	fullNumber -= (numberI * 1);
	int numberS = (fullNumber >= 0.5? 1 : 0); if (numberS > 0) fullNumber -= 0.5;
	fullNumber = _operand + (_numTwelvths / 12.0);
	
	_validNextCharacters = @"";
	switch ([RomanDigits rangeOfString:character].location) {
		case 0: //.
		{
			int twelvths = _numTwelvths % 6;
			if (twelvths < 5)
				_validNextCharacters = @".";
			break;
		}
	
		case 1: //S
			_validNextCharacters = @".";
			break;
	
		case 2: //I
		{
			int ones = numberI % 5;
			if (ones == 1)
				if (fullNumber > 15.0)
					_validNextCharacters = @"I";
				else if (fullNumber > 10.0)
					_validNextCharacters = @"IV";
				else
					_validNextCharacters = @"IVX";
			else if (ones == 2)
				_validNextCharacters = @"I";
			else if (ones == 3)
				_validNextCharacters = @"";
			
			_validNextCharacters = [_validNextCharacters stringByAppendingString:@"S."];
			break;
		}
		case 3: //V
			if (numberI != 5)
				_validNextCharacters = @"S.";
			else
				_validNextCharacters = [@"I" stringByAppendingString:@"S."];
			break;
	
		case 4://X
		{
			int tens = numberX % 5;
			if (tens == 1)
				if (fullNumber > 150.0)
					_validNextCharacters = @"X";
				else if (fullNumber > 100.0)
					_validNextCharacters = @"XL";
				else
					_validNextCharacters = @"XLC";
			else if (tens == 2)
				_validNextCharacters = @"X";
			else if (tens == 3)
				_validNextCharacters = @"";
			
			_validNextCharacters = [_validNextCharacters stringByAppendingString:@"VIS."];
			break;
		}
	
		case 5://L
			if (numberX != 5)
				_validNextCharacters = @"VIS.";
			else
				_validNextCharacters = [@"X" stringByAppendingString:@"VIS."];
			break;
	
		case 6://C
		{
			int hundreds = numberC % 5;
			if (hundreds == 1)
				if (fullNumber > 1000.0)
					_validNextCharacters = @"CD";
				else
					_validNextCharacters = @"CDM";
			else if (hundreds == 2)
				_validNextCharacters = @"C";
			else if (hundreds == 3)
				_validNextCharacters = @"";
			
			_validNextCharacters = [_validNextCharacters stringByAppendingString:@"LXVIS."];
			break;
		}

		case 7://D
			if (numberC != 5)
				_validNextCharacters = @"LXVIS.";
			else 
				_validNextCharacters = [@"C" stringByAppendingString:@"LXVIS."];
			break;

		case 8://M
			if (numberM == 1)
				_validNextCharacters = @"M";
			else if (numberM == 2)
				_validNextCharacters = @"M";
			else if (numberM == 3)
				_validNextCharacters = @"";
			
			_validNextCharacters = [_validNextCharacters stringByAppendingString:@"DCLXVIS."];
			break;
		
		default:
			_validNextCharacters =  @".SIVXLCDM";
			break;
	}
	//TODO: hundred thousands 
	// if ([character is@"(":
	//		_validNextCharacters = @"IVXLCD";
}
- (NSString *) validNextCharacters {
	return _validNextCharacters;
}

@end
