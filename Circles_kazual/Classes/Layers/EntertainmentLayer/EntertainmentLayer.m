//
//  EntertainmentLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/12/13.
//
//

#import "EntertainmentLayer.h"

static NSString * const ENTERTAIMENT_ROTATION           = @"Rotation";
static NSString * const ENTERTAIMENT_START_POINT        = @"StartPoint";
static NSString * const ENTERTAIMENT_END_POINT          = @"EndPoint";


static CGFloat const ENTERTAIMENT_TIME_INTERVAL = 5.;

static CGFloat const ENTERTAIMENT_SHOWING_CHARACTER_HEIGHT = 90.0;


@interface EntertainmentLayer()


- (void) update;
- (void) displayRandomCharacter;
- (NSDictionary *) entertaimentData;

@end

@implementation EntertainmentLayer


- (id)init {
    
    self = [super init];
    
    [self schedule:@selector(update) interval:ENTERTAIMENT_TIME_INTERVAL];
    
    self.isTouchEnabled = YES;
    
    return self;
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)eventt {

}


- (void) update {

    [self displayRandomCharacter];
}


- (void) displayRandomCharacter {
    
    NSDictionary * data = [self entertaimentData];
    
    // TODO
    CCSprite * characterImage = [CCSprite spriteWithFile:@"hero.png"];
    [characterImage setAnchorPoint:ccp(.5, .5)];
    [characterImage setPosition:CGPointFromString([data objectForKey:ENTERTAIMENT_START_POINT])];
    [self addChild:characterImage];
    
    
    void (^removeCharacterBlock)(void) = ^ {
        
        [characterImage removeFromParentAndCleanup:TRUE];
    };

    
   [characterImage setRotation:[[data objectForKey:ENTERTAIMENT_ROTATION] floatValue]];
    
    CGPoint endPoint = CGPointFromString([data objectForKey:ENTERTAIMENT_END_POINT]);
    
    
    [characterImage runAction:[CCSequence actions:
                                [CCMoveBy actionWithDuration:0.5 position:endPoint],
                                [CCDelayTime actionWithDuration:3.],
                                [CCMoveBy actionWithDuration:0.5 position:ccp(-endPoint.x,-endPoint.y)],
                                [CCCallBlock actionWithBlock:removeCharacterBlock],nil]];
}

- (NSDictionary *) entertaimentData {
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CGFloat rotation = (arc4random() % 4) * 90;
    
    CGFloat offset = arc4random() % 600 + 100;
    
    CGFloat seconfCoordinate = - ENTERTAIMENT_SHOWING_CHARACTER_HEIGHT/2;
    
    if (rotation == 180) {
        seconfCoordinate = size.height +  ENTERTAIMENT_SHOWING_CHARACTER_HEIGHT/2;
    } else if (rotation == 270) {
        seconfCoordinate = size.width +  ENTERTAIMENT_SHOWING_CHARACTER_HEIGHT/2;
    }
    
    CGPoint startPosition = (rotation == 0 || rotation == 180) ? ccp(offset, seconfCoordinate) : ccp(seconfCoordinate, offset);
    
    CGFloat height = (rotation == 0 || rotation == 90) ? ENTERTAIMENT_SHOWING_CHARACTER_HEIGHT : -ENTERTAIMENT_SHOWING_CHARACTER_HEIGHT;
    
    CGPoint endPosition =  (rotation == 0 || rotation == 180) ? ccp(0, height) : ccp(height, 0);
    
    return @{ENTERTAIMENT_ROTATION:[NSString stringWithFormat:@"%f", rotation],ENTERTAIMENT_START_POINT:NSStringFromCGPoint(startPosition), ENTERTAIMENT_END_POINT:NSStringFromCGPoint(endPosition)};
}

@end

