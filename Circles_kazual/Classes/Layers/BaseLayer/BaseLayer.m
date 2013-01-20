//
//  BaseLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/12/13.
//
//

#import "BaseLayer.h"

static NSInteger const TAG_BACKGROUND = 1;

@implementation BaseLayer


+ (CCScene *) scene {
    CCScene * scene = [CCScene node];
    
    BaseLayer * layer = [[[self class] alloc] init];
    
    [scene addChild:layer];
    
    [layer release];
    
    return scene;
}

- (id)init {
    
    self = [super init];
    
    [self addElements];
    
    return self;
}

- (void) setBackgroundImage:(NSString *)imageName {
    
    CCSprite * background = [CCSprite spriteWithFile:imageName];
    [background setAnchorPoint:ccp(0,0)];
    [background setPosition:ccp(0,0)];
    [self addChild:background z:-1 tag:TAG_BACKGROUND];
}

- (void) addElements {
    
}


-(void) cleanup {
    
    [[CCDirector sharedDirector] purgeCachedData];
    [[CCTextureCache sharedTextureCache] removeAllTextures];
    
    [self removeAllChildrenWithCleanup:TRUE];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self unscheduleAllSelectors];

    [super cleanup];
}


@end
