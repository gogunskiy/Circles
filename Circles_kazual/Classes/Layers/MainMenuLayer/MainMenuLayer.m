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
    
    
    CCMenuItemLabel *start = [CCMenuItemFont itemWithString:@"Start" block:^(id sender){
        
        [GAME startGameWithInfo:@{@"Level":@"1.plist"}];
        
	}];
    
    CCMenu *menu = [CCMenu menuWithItems:start, nil];
	
	[menu alignItemsVerticallyWithPadding:30];
    
	[menu setPosition:ccp(512,700)];
	
	[self addChild: menu z:-1];
    
    return self;
}

@end
