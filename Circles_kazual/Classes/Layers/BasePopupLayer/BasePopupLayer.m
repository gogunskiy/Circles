//
//  BasePopupLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/20/13.
//
//

#import "BasePopupLayer.h"

@interface BasePopupLayer ()

- (void) showAllElementsWithDuration:(CGFloat)duration;
- (void) hideAllElementsWithDuration:(CGFloat)duration;

@end

@implementation BasePopupLayer

@synthesize fadeDuration;

- (id)init
{
    self = [super init];
    if (self) {
        
        [self hideAllElements];
    }
    
    return self;
}

- (void) show {
    [self showAllElementsWithDuration:fadeDuration];
}

- (void) hide {
    [self hideAllElementsWithDuration:fadeDuration];
}

- (void)removeFromParentAndCleanup:(BOOL)cleanup {
    [self hideAllElementsWithDuration:fadeDuration];
    
    [super performSelector:@selector(removeFromParentAndCleanup:)
                withObject:nil
                afterDelay:fadeDuration];
}


- (void) hideAllElements {
    
    for (CCSprite *sprite in [self children]) {
        [sprite runAction:[CCFadeOut actionWithDuration:0.01]];
    }
}


- (void) showAllElementsWithDuration:(CGFloat)duration {
    
    for (CCSprite *sprite in [self children]) {
        [sprite runAction:[CCFadeIn actionWithDuration:duration]];
    }
}

- (void) hideAllElementsWithDuration:(CGFloat)duration {
    
    for (CCSprite *sprite in [self children]) {
        [sprite runAction:[CCFadeOut actionWithDuration:duration]];
    }
    
}

@end
