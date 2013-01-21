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
    
    return self;
}

- (void) setBackgroundImage:(NSString *)imageName {
    
    if (![UIImage imageNamed:imageName]) {
        NSLog(@"Image not found !");
        return;
    }
    
    background_ = [CCSprite spriteWithFile:imageName];
    [background_ setAnchorPoint:ccp(0,0)];
    [background_ setPosition:ccp(0,0)];
    [self addChild:background_ z:-1 tag:TAG_BACKGROUND];
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

-(void) setOpacity: (GLubyte) opacity
{
    for( CCNode *node in [self children] )
    {
        if( [node conformsToProtocol:@protocol( CCRGBAProtocol)] )
        {
            [(id<CCRGBAProtocol>) node setOpacity: opacity];
        }
    }
}

@end
