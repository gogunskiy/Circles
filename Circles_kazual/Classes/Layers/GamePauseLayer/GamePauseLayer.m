//
//  GamePauseLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/20/13.
//
//

#import "GamePauseLayer.h"

static NSInteger const MOVE_BY = 150;

@implementation GamePauseLayer

@synthesize delegate;

- (id)init {
    
    self = [super init];
    
    [self addElements];
    
    return self;
}

- (void) show {

    [self runAction:[CCMoveBy actionWithDuration:0.3 position:ccp(0,-MOVE_BY)]];
}

- (void) hide {
    [self runAction:[CCMoveBy actionWithDuration:0.3 position:ccp(0,MOVE_BY)]];
}

- (void) setIsTouchEnabled:(BOOL)enabled  {
    [pauseMenu_ setIsTouchEnabled:enabled];
}

- (void) addElements {

    CCMenuItemLabel *reset = [CCMenuItemImage itemWithNormalImage:@"restart-button.png" selectedImage:@"restart-button.png" block:^(id sender) {
        [[self delegate] restartButtonWasClicked];
    }];
    
    CCMenuItemLabel *start = [CCMenuItemImage itemWithNormalImage:@"play-button.png" selectedImage:@"play-button.png" block:^(id sender) {
        [[self delegate] startButtonWasClicked];
        
	}];
    
    
     pauseMenu_ = [CCMenu menuWithItems:reset, start, nil];
    [pauseMenu_ alignItemsHorizontallyWithPadding:800];
	[pauseMenu_ setPosition:ccp(512,700)];
	[self addChild: pauseMenu_ z:2];
}


@end
