//
//  MainGameLayer+Initialization.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/10/13.
//
//

#import "MainGameLayer.h"



@interface MainGameLayer (Initialization)

- (void) initPhysics;

- (void) initLevel;
- (void) initBackground;
- (void) initCharacters;
- (void) initBonuses;
- (void) initInfoLayer;

- (void) initDrawingLayer;
- (void) initEntertainmentLayer;
- (void) initPauseLayer;

- (void) initResultLayer;
- (void) showResultLayer;
- (void) hideResultLayer;

@end
