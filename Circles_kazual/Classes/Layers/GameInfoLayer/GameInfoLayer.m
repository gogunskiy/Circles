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

- (id)init {
    
    self = [super init];
    
    [self setBackgroundImage:@"infolayer_bacground.png"];
    
    return self;
}


- (void) addElements {
    
    [CCMenuItemFont setFontSize:22];
	
    CCMenuItemLabel *start = [CCMenuItemImage itemWithNormalImage:@"play-button.png" selectedImage:@"play-button.png" block:^(id sender) {
        [[self delegate] startButtonWasClicked];
        
	}];
	
    CCMenuItemLabel *reset = [CCMenuItemImage itemWithNormalImage:@"restart-button.png" selectedImage:@"restart-button.png" block:^(id sender) {
        [[self delegate] restartButtonWasClicked];
    }];
    
    
    CCMenuItemLabel *chooseLevel = [CCMenuItemImage itemWithNormalImage:@"chooselevel-button.png" selectedImage:@"chooselevel-button.png" block:^(id sender) {
        [[self delegate] chooseLevelButtonWasClicked];
    }];
	
	CCMenu *menu = [CCMenu menuWithItems:start, reset, nil];
	[menu alignItemsVerticallyWithPadding:40];
	[menu setPosition:ccp(960,600)];
	[self addChild: menu z:1];
    
    CCMenu *chooseLevelMenu = [CCMenu menuWithItems:chooseLevel, nil];
	[chooseLevelMenu setPosition:ccp(960,100)];
	[self addChild: chooseLevelMenu z:1];
}

@end
