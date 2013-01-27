//
//  GameManager.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/17/13.
//
//

#import <Foundation/Foundation.h>

#define GAME [GameManager shared]

@class LevelContainer;
@class LevelsLoader;

@interface GameManager : NSObject

+ (GameManager *) shared ;

@property (nonatomic, retain) LevelsLoader * levelsLoader;
@property (nonatomic, retain) LevelContainer * currentLevel;

- (void) startGameWithInfo:(NSDictionary *)info;
- (void) startGameFromPrevoiusLevel;

- (void) finishGameWithResult:(NSDictionary *)result;

- (NSArray *) levelsInformation;

@end
