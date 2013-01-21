//
//  MainMenuLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/17/13.
//
//

#import "MainMenuLayer.h"

@implementation MainMenuLayer

- (id)init {
    self = [super init];
    
    
    CCMenuItemLabel *start = [CCMenuItemImage itemWithNormalImage:@"play-button.png" selectedImage:@"play-button.png" block:^(id sender) {
        
     //   [GAME startGameWithInfo:@{@"Level":@"1.plist"}];
        [GAME loadChooseLevelLayer];
        
	}];
    
    CCMenu *menu = [CCMenu menuWithItems:start, nil];
	
	[menu alignItemsVerticallyWithPadding:30];
    
	[menu setPosition:ccp(512,400)];
	
	[self addChild: menu z:-1];
    
    return self;
}

@end
