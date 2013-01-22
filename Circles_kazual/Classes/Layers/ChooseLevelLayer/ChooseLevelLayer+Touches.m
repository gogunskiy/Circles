//
//  ChooseLevelLayer+Touches.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/23/13.
//
//

static CGFloat const SWIPE_CONDITION_DELTA = 100;

#import "ChooseLevelLayer+Touches.h"

@implementation ChooseLevelLayer (Touches)

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [ touches anyObject];
    CGPoint new_location = [touch locationInView: [touch view]];
    startLocation_ = [[CCDirector sharedDirector] convertToGL:new_location];
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [ touches anyObject];
    CGPoint new_location = [touch locationInView: [touch view]];
    CGPoint endLocation = [[CCDirector sharedDirector] convertToGL:new_location];
    
    if (endLocation.x - startLocation_.x > SWIPE_CONDITION_DELTA) {
        [self rightSwipe:nil];
    } else if (startLocation_.x - endLocation.x > SWIPE_CONDITION_DELTA) {
        [self leftSwipe:nil];
    }
    
}

@end
