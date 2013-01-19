//
//  GameManager.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/17/13.
//
//

#import "GameManager.h"
#import "LevelContainer.h"

#define RESOURCE_FILE(file) [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:(file)]

static GameManager * shared = nil;

@implementation GameManager

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
    
    return self;
}

- (void)dealloc {
    
    [self setCurrentLevel:nil];
    
    [super dealloc];
}

- (void) startGameWithInfo:(NSDictionary *)info {
    
    NSDictionary * levelData = [NSDictionary dictionaryWithContentsOfFile:RESOURCE_FILE([info objectForKey:@"Level"])];
    
    [[self currentLevel] setWithInfo:levelData];
    
    [GAME loadMainGameLayer];
}

- (void) finishGameWithResult:(NSDictionary *)result {
    NSLog(@"%@", result);
}


@end
