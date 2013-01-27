//
//  ChooseLevelPageLayer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/21/13.
//
//

#import "BaseLayer.h"

@protocol ChooseLevelPageLayerDelegate;


@interface ChooseLevelPageLayer : BaseLayer {
    CCSprite * leftPusher_;
    CCSprite * rightPusher_;
    
    CCMenuItemImage * leftArrow_;
    CCMenuItemImage * rightArrow_;
}

@property (nonatomic, assign) id <ChooseLevelPageLayerDelegate> delegate;
@property (nonatomic, retain) NSDictionary *info;

- (void) initialize;

- (void) show;

- (void) leftIn;
- (void) leftOut;
- (void) rightIn;
- (void) rightOut;
    
@end



@protocol ChooseLevelPageLayerDelegate <NSObject>

- (void) setLayerEnabled:(BOOL)endbled;
- (BOOL) needLeftArrowForPage:(ChooseLevelPageLayer *) page;
- (BOOL) needRightArrowForPage:(ChooseLevelPageLayer *) page;

- (void) showPreviousPage;
- (void) showNextPage;

@end