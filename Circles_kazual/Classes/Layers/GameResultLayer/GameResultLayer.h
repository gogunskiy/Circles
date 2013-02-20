//
//  GameResultLayer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/20/13.
//
//

#import "BasePopupLayer.h"


@class CCAnimatedLabel;

@protocol GameResultLayerDelegate;

@interface GameResultLayer : BaseLayer {
    CCAnimatedLabel * resulLabel_;
    CCAnimatedLabel * scoreLabel_;
    CCAnimatedLabel * highScoreLabel_;
    CCMenuItemImage *nextLevel_;
}

@property (nonatomic, assign) id <GameResultLayerDelegate> delegate;
@property (nonatomic, copy) NSString * result;
@property (nonatomic, copy) NSString * score;
@property (nonatomic, copy) NSString * highScore;

- (void) show;
- (void) hide;
- (void) setResult:(NSString *)result ;

@end




@protocol GameResultLayerDelegate

- (void) restartButtonWasClicked;
- (void) chooseLevelButtonWasClicked;
- (void) nextLevelButtonWasClicked;
- (void) hidePauseMenuButtonClicked;


@end;