//
//  GameInfoLayer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/20/13.
//
//

#import "BaseLayer.h"

@protocol GameInfoLayerDelegate;

@interface GameInfoLayer : BaseLayer

@property (nonatomic, assign) id <GameInfoLayerDelegate> delegate;

@end



@protocol GameInfoLayerDelegate

- (void) startButtonWasClicked;
- (void) restartButtonWasClicked;
- (void) chooseLevelButtonWasClicked;

@end
