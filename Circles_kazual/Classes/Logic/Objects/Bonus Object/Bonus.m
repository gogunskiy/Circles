//
//  Character.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/10/13.
//
//

#import "Bonus.h"


@implementation Bonus

@synthesize value;
@synthesize active;

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super initWithFile:[dict objectForKey:BONUS_SPRITE]];
    if (self) {
        
        [self setValue:[[dict objectForKey:BONUS_VALUE] floatValue]];
        [self setAnchorPoint:ccp(0.5,0.5)];
        [self setActive:TRUE];
        [self setPosition:CGPointFromString([dict objectForKey:BONUS_POSITION])];
        [self runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeTo actionWithDuration:.3 opacity:125],[CCFadeTo actionWithDuration:.3 opacity:255], nil]]];
        
    }
    
    return self;
}



+ (NSMutableDictionary *) bonusDataByType:(NSString *) bonusType {
    return [NSMutableDictionary dictionaryWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bonusType]];
}


- (BOOL) intersectWithPosition:(CGPoint)position size:(CGSize)size {
    
    CGRect bonusRect  = CGRectMake(self.position.x - size.width/2, self.position.y + size.height/2, size.width, size.height) ;
    CGRect objectRect = CGRectMake(position.x - size.width/2, position.y + size.height/2, size.width, size.height) ;
    
    return CGRectIntersectsRect(bonusRect, objectRect);
}


@end
