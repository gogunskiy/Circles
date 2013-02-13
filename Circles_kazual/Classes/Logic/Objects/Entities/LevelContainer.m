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
@synthesize scores;
@synthesize highScores;
@synthesize worldInfo;
@synthesize characters;
@synthesize bonuses;

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
    [self setWorldInfo:[NSDictionary dictionaryWithContentsOfFile:RESOURCE_FILE([info objectForKey:LEVEL_WORLD])]];
    [self setCharacters:[info objectForKey:CHARACTERS]];
    [self setBonuses:[info objectForKey:BONUSES]];
    [self setHighScores:[[info objectForKey:LEVEL_HIGHSCORES] intValue]];
}


@end
