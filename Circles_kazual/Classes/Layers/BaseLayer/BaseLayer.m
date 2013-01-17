//
//  BaseLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/12/13.
//
//

#import "BaseLayer.h"

@implementation BaseLayer


+ (CCScene *) scene {
    CCScene * scene = [CCScene node];
    
    BaseLayer * layer = [[[self class] alloc] init];
    
    [scene addChild:layer];
    
    [layer release];
    
    return scene;
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
