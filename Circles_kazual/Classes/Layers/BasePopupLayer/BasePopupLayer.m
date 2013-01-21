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
        
      
    }
    
    return self;
}

- (void) addElements {
    
    [self setOpacity:0];
    [super addElements];
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




- (void) showAllElementsWithDuration:(CGFloat)duration {
    
    [self  runAction:[CCFadeIn actionWithDuration:duration]];
}

- (void) hideAllElementsWithDuration:(CGFloat)duration {
   
    [self  runAction:[CCFadeOut actionWithDuration:duration]];
}

@end
