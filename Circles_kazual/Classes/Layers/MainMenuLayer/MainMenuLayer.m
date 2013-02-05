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
    
  //  [character runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCJumpBy actionWithDuration:3.0 position:ccp(400,0) height:200 jumps:2],[CCJumpBy actionWithDuration:3.0 position:ccp(-400,0) height:200 jumps:2], nil]]];
    
    
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"magentaAnim.plist"];
    
    CCSprite * character2 = [CCSprite spriteWithSpriteFrameName:@"magenta1.png"];
    [character2 setPosition:ccp(500,500)];
    [self addChild:character2 z:-2];
    
    [character2 runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithSpriteSequence:@"magenta%d.png"
                                                                                     numFrames:3
                                                                                         delay:0.1
                                                                          restoreOriginalFrame:NO]]];

    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"angryAnim.plist"];
    
    CCSprite * character5 = [CCSprite spriteWithSpriteFrameName:@"angry1.png"];
    [character5 setPosition:ccp(700,400)];
    [self addChild:character5 z:-2];
    
    [character5 runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithSpriteSequence:@"angry%d.png"
                                                                                      numFrames:3
                                                                                          delay:0.1
                                                                           restoreOriginalFrame:NO]]];

    
    CCSprite * character3 = [CCSprite spriteWithFile:@"Angry.png"];
    [character3 setPosition:ccp(40,40)];
    [character3 setScale:2.0];
    [character3 setRotation:45];
    [self addChild:character3 z:-2];
    
    CCSprite * character4 = [CCSprite spriteWithFile:@"GoodSoul.png"];
    [character4 setPosition:ccp(984,40)];
    [character4 setScale:2.0];
    [character4 setRotation:-45];
    [self addChild:character4 z:-2];
    
    return self;
}

@end
