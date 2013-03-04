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

- (void) setStartButtonhEnabled:(BOOL)enabled  {
    [startMenu_ setIsTouchEnabled:enabled];
}

- (void) addElements {

    CCMenuItemLabel *reset = [CCMenuItemImage itemWithNormalImage:@"restart-button.png" selectedImage:@"restart-button.png" block:^(id sender) {
        [[self delegate] restartButtonWasClicked];
    }];
    
    CCMenuItemLabel *start = [CCMenuItemImage itemWithNormalImage:@"play-button.png" selectedImage:@"play-button.png" block:^(id sender) {
        [[self delegate] startButtonWasClicked];
        
	}];
    
    resetMenu_ = [CCMenu menuWithItems:reset, nil];
	[resetMenu_ setPosition:ccp(70,700)];
	[self addChild:resetMenu_ z:2];
    
    startMenu_ = [CCMenu menuWithItems:start, nil];
	[startMenu_ setPosition:ccp(954,700)];
	[self addChild:startMenu_ z:2];
    
}



@end
