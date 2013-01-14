//
//  Character.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/10/13.
//
//

#import "Character.h"

@implementation Character

@synthesize data;

- (id) initWithPosition:(CGPoint)position indefiener:(int)indefiener data:(NSDictionary *)theData {
    
    self = [super initWithPosition:position filename:[theData objectForKey:CHARACTER_SPRITE] indefiener:indefiener];

    [self setData:theData];
    
    [self setGravityScale:[[theData objectForKey:CHARACTER_GRAVITYSCALE] floatValue]];
    
    if ([[[[self data] objectForKey:CHARACTER_GEOMETRY] objectForKey:CHARACTER_GEOMETRY_TYPE] isEqualToString:CHARACTER_GEOMETRY_TYPE_POLYGON]) {
        [self setAnchorPoint:ccp(0, 0)];
    }
    return self;
}

- (void) enablePhysics {
    
    [self disablePhysics];
    
    if ([[[[self data] objectForKey:CHARACTER_GEOMETRY] objectForKey:CHARACTER_GEOMETRY_TYPE] isEqualToString:CHARACTER_GEOMETRY_TYPE_POLYGON]) {
        
        NSArray * points = [[[self data] objectForKey:CHARACTER_GEOMETRY] objectForKey:CHARACTER_GEOMETRY_POINTS];
    
        [self generatePolygonBodyWithVerticles:points bodyType:b2_dynamicBody];
        
        [self body]->SetGravityScale([self gravityScale]);
    } else  if ([[[[self data] objectForKey:CHARACTER_GEOMETRY] objectForKey:CHARACTER_GEOMETRY_TYPE] isEqualToString:CHARACTER_GEOMETRY_TYPE_CIRCLE]) {
        CGFloat radius =  [[[[self data] objectForKey:CHARACTER_GEOMETRY] objectForKey:CHARACTER_GEOMETRY_RADIUS] floatValue];
        
        [self generateCirlceBodyWithRadius:radius];
        
    }
}


- (void) disablePhysics {
    if (physicsBodyExist_) {
        world_->DestroyBody([self body]);
      
        body_ = NULL;
        
        physicsBodyExist_ = FALSE;
    }
}

+ (NSMutableDictionary *) characterDataByType:(NSString *)characterType {
    return [NSMutableDictionary dictionaryWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:characterType]];
}

@end
