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

@interface GameManager : NSObject

+ (GameManager *) shared ;

@property (nonatomic, retain) LevelContainer * currentLevel;

- (void) startGameWithInfo:(NSDictionary *)info;

@end
