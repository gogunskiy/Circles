//
//  GamePauseLayer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/20/13.
//
//

#import "BaseLayer.h"

@protocol GamePauseLayerDelegate;

@interface GamePauseLayer : BaseLayer {
    CCMenu *pauseMenu_;
}

@property (nonatomic, assign) id <GamePauseLayerDelegate> delegate;

- (void) setIsTouchEnabled:(BOOL)enabled  ;

@end



@protocol GamePauseLayerDelegate

- (void) startButtonWasClicked;
- (void) showPauseMenuButtonClicked;

@end;