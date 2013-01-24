//
//  CharacterDirectionArrow.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/24/13.
//
//

#import "CharacterDirectionArrow.h"

#define images      @[@"arrow-left.png",@"arrow-right.png",@"arrow-up.png",@"arrow-down.png"]
#define positions   @[@"{-50,50}",@"{150,50}",@"{50,170}",@"{50,-50}"]

@interface CharacterDirectionArrow ()

+ (CharacterArrowDirection) directionByGravity:(CGPoint)gravity;

- (void) startAnimation;

@end

@implementation CharacterDirectionArrow

@synthesize direction;

- (id)initWithGravity:(CGPoint)gravity
{
    CharacterArrowDirection theDirection = [[self class] directionByGravity:gravity];
    
    self = [super initWithFile:[images objectAtIndex:theDirection]];
    if (self) {
        [self setDirection:theDirection];
        [self setPosition:CGPointFromString([positions objectAtIndex:theDirection])];
        
        [self startAnimation];
    }
    return self;
}

- (void) startAnimation {
    [self runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeTo actionWithDuration:.3 opacity:125],[CCFadeTo actionWithDuration:.3 opacity:255], nil]]];
}

+ (CharacterArrowDirection) directionByGravity:(CGPoint)gravity {
    if (gravity.x < 0) {
        return ArrowDirectionLeft;
    }
    if (gravity.x > 0) {
        return ArrowDirectionRight;
    }
    
    if (gravity.y > 0) {
        return ArrowDirectionUp;
    }
    
    if (gravity.y < 0) {
        return ArrowDirectionDown;
    }
    
    return ArrowDirectionDown;
}

@end
