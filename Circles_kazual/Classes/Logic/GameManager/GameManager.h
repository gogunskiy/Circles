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

@interface GameManager : NSObject {
    double levelStartTime_;
    double levelEndTime_;
}

+ (GameManager *) shared ;

@property (nonatomic, retain) LevelsLoader * levelsLoader;
@property (nonatomic, retain) LevelContainer * currentLevel;

- (void) startGameWithInfo:(NSDictionary *)info;
- (void) startGameFromPrevoiusLevel;
- (void) restartLevel;

- (void) finishGameWithResult:(NSDictionary *)result;

- (NSArray *) levelsInformation;

- (NSInteger) levelScores;
- (void) setLevelScores:(CGFloat)theScore;
- (void) addLevelScores:(CGFloat)theScore;


- (void) setHighScores:(NSInteger)scores levelPage:(NSInteger)levelPage levelIndex:(NSInteger)levelIndex;
- (NSInteger) highScoreForLevelPage:(NSInteger)levelPage levelIndex:(NSInteger)levelIndex;

@end
