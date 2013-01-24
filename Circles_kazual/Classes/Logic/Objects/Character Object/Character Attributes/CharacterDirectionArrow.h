//
//  CharacterDirectionArrow.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/24/13.
//
//

#import "CCSprite.h"

typedef enum CharacterArrowDirection {
    ArrowDirectionLeft,
    ArrowDirectionRight,
    ArrowDirectionUp,
    ArrowDirectionDown
    
} CharacterArrowDirection;

@interface CharacterDirectionArrow : CCSprite

@property (nonatomic, assign) CharacterArrowDirection direction;

- (id)initWithGravity:(CGPoint)gravity;

@end
