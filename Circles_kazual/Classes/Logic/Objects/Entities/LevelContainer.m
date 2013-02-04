//
//  LevelContainer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/17/13.
//
//

#import "LevelContainer.h"


@implementation LevelContainer

@synthesize levelIndex;
@synthesize pageIndex;
@synthesize title;
@synthesize backgroundImage;
@synthesize characters;

- (id) init {
    
    self = [super init];
    
    
    return self;
}

- (void)dealloc {
    
    [self setTitle:nil];
    [self setCharacters:nil];
    [super dealloc];
}

- (void) setWithInfo:(NSDictionary *)info {
    
    [self setTitle:[info objectForKey:TITLE]];
    [self setBackgroundImage:[info objectForKey:LEVEL_BACKGROUND]];
    [self setCharacters:[info objectForKey:CHARACTERS]];
}

@end
