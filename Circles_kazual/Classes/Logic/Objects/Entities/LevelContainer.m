//
//  LevelContainer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/17/13.
//
//

#import "LevelContainer.h"

static NSString * const CHARACTERS = @"Characters";

@implementation LevelContainer

@synthesize characters;

- (id) init {
    
    self = [super init];
    
    
    return self;
}

- (void)dealloc {
    
    [self setCharacters:nil];
    [super dealloc];
}

- (void) setWithInfo:(NSDictionary *)info {
    
    [self setCharacters:[info objectForKey:CHARACTERS]];
}

@end
