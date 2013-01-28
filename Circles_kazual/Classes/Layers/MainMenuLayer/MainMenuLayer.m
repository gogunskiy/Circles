//
//  MainMenuLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/17/13.
//
//

#import "MainMenuLayer.h"
#import "CCAnimate+SequenceLoader.h"

@implementation MainMenuLayer

- (id)init {
    self = [super init];
    
    
    CCMenuItemLabel *start = [CCMenuItemImage itemWithNormalImage:@"play-button.png" selectedImage:@"play-button.png" block:^(id sender) {

        [GAME loadChooseLevelLayer];
        
	}];
    
    CCMenu *menu = [CCMenu menuWithItems:start, nil];
	
	[menu alignItemsVerticallyWithPadding:30];
    
	[menu setPosition:ccp(512,400)];
	
	[self addChild: menu z:-1];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"DataFile.plist"];
    
    CCSprite * character = [CCSprite spriteWithSpriteFrameName:@"cipochka1.png"];
    [character setPosition:ccp(200,500)];
    [self addChild:character z:-2];
    
    [character runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithSpriteSequence:@"cipochka%d.png"
                                                   numFrames:4
                                                       delay:0.15
                                        restoreOriginalFrame:NO]]];
    
    [character runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCJumpBy actionWithDuration:3.0 position:ccp(400,0) height:200 jumps:2],[CCJumpBy actionWithDuration:3.0 position:ccp(-400,0) height:200 jumps:2], nil]]];
    
    return self;
}

@end
