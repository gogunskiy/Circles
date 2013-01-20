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

@property (nonatomic, assign) BOOL shown;

- (void) show;
- (void) hide;

@end



@protocol GameInfoLayerDelegate

- (void) restartButtonWasClicked;
- (void) chooseLevelButtonWasClicked;
- (void) hidePauseMenuButtonClicked;

@end
