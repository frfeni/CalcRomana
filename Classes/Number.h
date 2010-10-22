//
//  Number.h
//  CalcRomana
//
//  Created by Fred Fenimore on 9/5/09.
//  Copyright 2009 __Bugware__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Number : NSObject {
	float	_operand;
	int		_numTwelvths;
	
	NSArray *romanDots;
	NSArray *romanSs;
	NSArray *roman1s;
	NSArray *roman10s;
	NSArray *roman100s;
	NSArray *roman1000s;
	NSArray *roman10000s;
	NSArray *roman100000s;
	
	NSString *_validNextCharacters;
}

- init;
- (void) dealloc;

- (void) reset;

- (void) addInt:(int) val;
- (void) addFloat:(float) val;
- (void) addTwelfths:(int) val;

- (void) add:(Number*) val;
- (void) subtract:(Number*) val;
- (void) multiply:(Number*) val;
- (void) divide:(Number*) val;

- (NSString *) asRoman;
- (NSString *) asDecimal;

- (void) inputCharacter:(NSString *) character;
- (void) figureValidNextCharacters:(NSString*) character ;
- (NSString *) validNextCharacters;
@end
