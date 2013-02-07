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

- (void) addActions:(NSArray *)actions forObject:(CCSprite *)object;

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
    
    CCLayerColor * layer = [[CCLayerColor alloc] initWithColor:ccc4(0,0,0,255)];
    [layer setAnchorPoint:ccp(0,0)];
    [layer setPosition:ccp(0,0)];
    [self addChild:layer z:10];
    [layer setOpacity:0];
    
    [layer runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeTo actionWithDuration:60 opacity:220],[CCDelayTime actionWithDuration:10], [CCFadeTo actionWithDuration:40 opacity:0],[CCDelayTime actionWithDuration:20], nil]]];
}

- (void) addLayers {
 
    NSArray * layers = [[self info] objectForKey:WORLD_LAYERS];
    
    for (NSDictionary * layerInfo in layers) {
        CCSprite * layer = [CCSprite spriteWithFile:[layerInfo objectForKey:WORLD_LAYER_IMAGE]];
        [layer setPosition:ccp(0,0)];
        [layer setAnchorPoint:ccp(0,0)];
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
        
        [self addActions:[objectInfo objectForKey:WORLD_OBJECT_ACTIONS] forObject:object];
    }
}


- (void) addActions:(NSArray *)actions forObject:(CCSprite *)object {
    
    for (NSArray * sequence in actions) {
        NSMutableArray * actionsInSequence = [[NSMutableArray alloc] init];
        for (NSDictionary * action in sequence) {
      
            if ([[action objectForKey:WORLD_OBJECT_ACTION_TYPE] isEqualToString:WORLD_OBJECT_ACTION_MOVE_BY]) {
                CCMoveBy * theAction = [CCMoveBy actionWithDuration:[[action objectForKey:WORLD_OBJECT_ACTION_DURATION] intValue] position:CGPointFromString([action objectForKey:WORLD_OBJECT_ACTION_VALUE])];
                [actionsInSequence addObject:theAction];
            } else if ([[action objectForKey:WORLD_OBJECT_ACTION_TYPE] isEqualToString:WORLD_OBJECT_ACTION_DELAY]) {
                CCDelayTime * theAction = [CCDelayTime actionWithDuration:[[action objectForKey:WORLD_OBJECT_ACTION_DURATION] intValue]];
                [actionsInSequence addObject:theAction];
            } else if ([[action objectForKey:WORLD_OBJECT_ACTION_TYPE] isEqualToString:WORLD_OBJECT_ACTION_FADE_TO]) {
                CCFadeTo * theAction = [CCFadeTo actionWithDuration:[[action objectForKey:WORLD_OBJECT_ACTION_DURATION] intValue] opacity:[[action objectForKey:WORLD_OBJECT_ACTION_VALUE] intValue]];
                [actionsInSequence addObject:theAction];
            }
        }
        [object runAction:[CCRepeatForever actionWithAction:[CCSequence actionWithArray:actionsInSequence]]];
        [actionsInSequence release];
    }
    
}

@end
