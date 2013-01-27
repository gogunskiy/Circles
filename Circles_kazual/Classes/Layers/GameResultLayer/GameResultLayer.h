//
//  GameResultLayer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/20/13.
//
//

#import "BasePopupLayer.h"
#import "CCLabelFX.h"


static NSString * const WIN_RESULT  = @"WIN !";
static NSString * const LOSE_RESULT = @"LOSE !";

@protocol GameResultLayerDelegate;

@interface GameResultLayer : BasePopupLayer {
    CCLabelFX * resulLabel_;
}

@property (nonatomic, assign) id <GameResultLayerDelegate> delegate;
@property (nonatomic, copy) NSString * result;

- (void) setResult:(NSString *)result ;

@end




@protocol GameResultLayerDelegate

- (void) restartButtonWasClicked;
- (void) chooseLevelButtonWasClicked;
- (void) nextLevelButtonWasClicked;
- (void) hidePauseMenuButtonClicked;


@end;