//
//  GamePauseLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/20/13.
//
//

#import "GamePauseLayer.h"

@implementation GamePauseLayer

@synthesize delegate;

- (id)init {
    
    self = [super init];
    
    [self addElements];
    
    return self;
}

- (void) setIsTouchEnabled:(BOOL)enabled  {
    [pauseMenu_ setIsTouchEnabled:enabled];
}

- (void) addElements {

    CCMenuItemLabel *start = [CCMenuItemImage itemWithNormalImage:@"play-button.png" selectedImage:@"play-button.png" block:^(id sender) {
        [[self delegate] startButtonWasClicked];
        
	}];
    
    CCMenuItemLabel *pencil = [CCMenuItemImage itemWithNormalImage:@"pencil-button.png" selectedImage:@"pencil-button.png" block:^(id sender) {
        [[self delegate] clearLineButtonClicked];
        
	}];
    
    CCMenuItemLabel *pause = [CCMenuItemImage itemWithNormalImage:@"pause-button.png" selectedImage:@"pause-button.png" block:^(id sender) {
        [[self delegate] showPauseMenuButtonClicked];
        
	}];
    
     pauseMenu_ = [CCMenu menuWithItems:start,pencil, pause, nil];
    [pauseMenu_ alignItemsVerticallyWithPadding:220];
	[pauseMenu_ setPosition:ccp(960,394)];
	[self addChild: pauseMenu_ z:2];
}


@end
