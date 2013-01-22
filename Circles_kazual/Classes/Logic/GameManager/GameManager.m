//
//  GameManager.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/17/13.
//
//

#import "GameManager.h"
#import "LevelContainer.h"
#import "LevelsLoader.h"


static GameManager * shared = nil;

@implementation GameManager

@synthesize levelsLoader;
@synthesize currentLevel;

+ (GameManager *) shared  {
    if (!shared) {
        shared = [[GameManager alloc] init];
    }
    
    return shared;
}

- (id)init {
    
    self = [super init];
    
    [self setCurrentLevel:[[[LevelContainer alloc] init] autorelease]];
    [self setLevelsLoader:[[[LevelsLoader alloc] init] autorelease]];

    return self;
}

- (void)dealloc {
    
    [self setCurrentLevel:nil];
    [self setLevelsLoader:nil];
    
    [super dealloc];
}

- (void) startGameWithInfo:(NSDictionary *)info {
  
    [[self currentLevel] setWithInfo:[[self levelsLoader] levelDataForLevel:[info objectForKey:LEVEL_FILE_INFO]]];
    
    [GAME loadMainGameLayer];
}

- (void) finishGameWithResult:(NSDictionary *)result {
    NSLog(@"%@", result);
}


- (NSArray *) levelsInformation {
    return [[self levelsLoader] levelsInformation];
}

@end
