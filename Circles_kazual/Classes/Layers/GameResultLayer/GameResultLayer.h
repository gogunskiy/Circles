//
//  GameResultLayer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/20/13.
//
//

#import "BasePopupLayer.h"
#import "CCLabelFX.h"

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
- (void) hidePauseMenuButtonClicked;


@end;