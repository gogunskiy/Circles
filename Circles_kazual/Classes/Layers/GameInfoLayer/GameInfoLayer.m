//
//  GameInfoLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/20/13.
//
//

#import "GameInfoLayer.h"

@implementation GameInfoLayer

@synthesize delegate;
@synthesize shown;

- (id)init {
    
    self = [super init];
    
    [self setBackgroundImage:@"infolayer_bacground.png"];
    
    [self setShown:FALSE];
    
    [self addElements];
    
    return self;
}


- (void) addElements {
	
    CCMenuItemLabel *reset = [CCMenuItemImage itemWithNormalImage:@"restart-button.png" selectedImage:@"restart-button.png" block:^(id sender) {
        [[self delegate] restartButtonWasClicked];
    }];
    
    
    CCMenuItemLabel *chooseLevel = [CCMenuItemImage itemWithNormalImage:@"chooselevel-button.png" selectedImage:@"chooselevel-button.png" block:^(id sender) {
        [[self delegate] chooseLevelButtonWasClicked];
    }];
	
    CCMenuItemLabel *hideMenu = [CCMenuItemImage itemWithNormalImage:@"start-button.png" selectedImage:@"start-button.png" block:^(id sender) {
        [[self delegate] hidePauseMenuButtonClicked];
    }];
    
	CCMenu *menu = [CCMenu menuWithItems:reset, chooseLevel, nil];
	[menu alignItemsVerticallyWithPadding:40];
	[menu setPosition:ccp(1120,600)];
	[self addChild: menu z:1];
    
    CCMenu *chooseLevelMenu = [CCMenu menuWithItems:hideMenu, nil];
	[chooseLevelMenu setPosition:ccp(1120,100)];
	[self addChild: chooseLevelMenu z:1];
    
    [background_ setPosition:ccp(160,0)];
}

- (void) show {
    if (![self shown]) {
        [self setShown:TRUE];
        for (CCSprite * sprite in [self children]) {
            [sprite runAction:[CCMoveBy actionWithDuration:.1 position:ccp(-160,0)]];
        }
    }
}

- (void) hide {
    
    if ([self shown]) {
        [self setShown:FALSE];
        for (CCSprite * sprite in [self children]) {
            [sprite runAction:[CCMoveBy actionWithDuration:.1 position:ccp(160,0)]];
        }
    }
}



@end
