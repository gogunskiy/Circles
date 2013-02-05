//
//  LevelWorldLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 2/5/13.
//
//

#import "LevelWorldLayer.h"

@interface LevelWorldLayer()

- (void) addSubstrate;
- (void) addLayers ;
- (void) addObjects ;
@end

@implementation LevelWorldLayer

@synthesize info;

- (id)init
{
    self = [super init];
    if (self) {
        [self addSubstrate];
    }
    return self;
}

- (void) initialize {
    
    [self addLayers];
    [self addObjects];
}


- (void) addSubstrate {
    
    CCLayerColor * layer = [[CCLayerColor alloc] initWithColor:ccc4(255,255,255,255)];
    [layer setAnchorPoint:ccp(0,0)];
    [layer setPosition:ccp(0,0)];
    [self addChild:layer z:-1];
}

- (void) addLayers {
 
    NSArray * layers = [[self info] objectForKey:WORLD_LAYERS];
    
    for (NSDictionary * layerInfo in layers) {
        CCSprite * layer = [CCSprite spriteWithFile:[layerInfo objectForKey:WORLD_LAYER_IMAGE]];
        [layer setPosition:ccp(0,0)];
        [layer setAnchorPoint:ccp(0,0)];
        [self setOpacity:125];
        [self addChild:layer z:[[layerInfo objectForKey:WORLD_LAYER_ORDER] intValue]];
    }
}

- (void) addObjects {
    
    NSArray * objects = [[self info] objectForKey:WORLD_OBJECTS];
    
    for (NSDictionary * objectInfo in objects) {
        CCSprite * object = [CCSprite spriteWithFile:[objectInfo objectForKey:WORLD_OBJECT_IMAGE]];
        [object setPosition:CGPointFromString([objectInfo objectForKey:WORLD_OBJECT_POSITION])];
        [object setAnchorPoint:ccp(0.5,0.5)];
        [self addChild:object z:[[objectInfo objectForKey:WORLD_OBJECT_ORDER] intValue]];
    }
}

@end
