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

static NSString * const LEVELS_INFO         = @"Levels";

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
    
    [[self currentLevel] setLevelIndex:[[info objectForKey:LEVEL_INDEX] integerValue]];
    [[self currentLevel] setPageIndex:[[info objectForKey:PAGE_INDEX] integerValue]];
    
    [GAME loadMainGameLayer];
}

- (void) startGameFromPrevoiusLevel {
    
    NSArray * levelsInfo = [self levelsInformation];
    
    NSInteger levelIndex = [[self currentLevel] levelIndex];
    NSInteger pageIndex  = [[self currentLevel] pageIndex];
    
    levelIndex ++;
    
    if (levelIndex < [[[levelsInfo objectAtIndex:pageIndex] objectForKey:LEVELS_INFO] count]) {
        NSDictionary * levelDescriptor = [[[levelsInfo objectAtIndex:pageIndex] objectForKey:LEVELS_INFO] objectAtIndex:levelIndex];
        [self startGameWithInfo:levelDescriptor];
    } else {
        [self loadChooseLevelLayer];
    }
}

- (void) finishGameWithResult:(NSDictionary *)result {
    
    [[SimpleAudioEngine sharedEngine] playEffect:[[[result objectForKey:GAME_RESULT] lowercaseString] stringByAppendingString:@"Sound.wav"]];
}


- (NSArray *) levelsInformation {
    return [[self levelsLoader] levelsInformation];
}

@end
