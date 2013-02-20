//
//  CCAnimatedLabel.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 2/20/13.
//
//

#import "CCAnimatedLabel.h"

@interface CCAnimatedLabel ()

- (void)setString:(NSString *)str withDelay:(CGFloat)delay;

@end

@implementation CCAnimatedLabel

- (void)setString:(NSString *)str animated:(BOOL)animated {
    if (animated) {
        [self setString:[NSString stringWithFormat:@"%d", [self currentValue]] animated:FALSE];
        [self setString:str withDelay:[self delay]];
    } else {
        [super setString:str];
    }
}

- (void)setString:(NSString *)str withDelay:(CGFloat)delay {
    [self setStartValue:[[self string] integerValue]];
    [self setEndValue:[str intValue]];
    [self setCurrentValue:[self startValue]];
    
    [self schedule:@selector(update:) interval:[self delay]];
}

- (void) update:(ccTime)time {
    
    [self setString:[NSString stringWithFormat:@"%d", [self currentValue]] animated:FALSE];
    [GAME playEffect:SOUND_COUNTER];
    
    if ([self startValue] < [self endValue]) {
        if ([self currentValue] >= [self endValue]) {
            [self unschedule:@selector(update:)];
        }
        [self setCurrentValue:[self currentValue] + [self delta]];
    } else {
        if ([self currentValue] <= [self endValue]) {
            [self unschedule:@selector(update:)];
        }
        [self setCurrentValue:[self currentValue] - [self delta]];
    }
}

@end
