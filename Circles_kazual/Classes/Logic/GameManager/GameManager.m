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
    
    [self preloadEffects];
    
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
    
    [self setLevelScores:0];
    
    levelStartTime_ = [[NSDate date] timeIntervalSince1970];
    
    [GAME loadMainGameLayer];
}

- (void) restartLevel {
    
    [self setLevelScores:0];
  
    levelStartTime_ = [[NSDate date] timeIntervalSince1970];
  
    [self loadMainGameLayer];
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
    
    levelEndTime_ = [[NSDate date] timeIntervalSince1970];
    
    CGFloat levelTime = levelEndTime_ - levelStartTime_;
    
    if ([[result objectForKey:GAME_RESULT] isEqualToString:WIN_RESULT]) {
        
        NSInteger result = (1000 - levelTime) > 0 ? (1000 - levelTime) : 0;
        result = result / 10 * 10;
        
        [self addLevelScores:result];
        
        [GAME playEffect:SOUND_WIN];
    } else {
        [self setLevelScores:0];
        
        [GAME playEffect:SOUND_LOSE];
    }
}


- (NSArray *) levelsInformation {
    return [[self levelsLoader] levelsInformation];
}

#pragma mark - SCORING -

- (NSInteger) levelScores {
    return [currentLevel scores];
}

- (void) setLevelScores:(CGFloat)theScore {
    [currentLevel setScores:theScore];
}

- (void) addLevelScores:(CGFloat)theScore {
    [self setLevelScores:[self levelScores] + theScore];
}

- (void) setHighScores:(NSInteger)scores levelPage:(NSInteger)levelPage levelIndex:(NSInteger)levelIndex {
    
    NSInteger highScores = [self highScoreForLevelPage:levelPage levelIndex:levelIndex];
    
    if (scores > highScores) {
        [levelsLoader setScores:scores levelPage:levelPage levelIndex:levelIndex];
    }
}


- (NSInteger) highScoreForLevelPage:(NSInteger)levelPage levelIndex:(NSInteger)levelIndex {
    return [levelsLoader scoreForLevelPage:levelPage levelIndex:levelIndex];
}


@end
