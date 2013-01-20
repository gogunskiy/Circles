//
//  Character.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/10/13.
//
//

#import "Character.h"

#define OUT_THE_SCREEN(x) !CGRectContainsPoint(CGRectMake(-200, -200, 1224,968), x)

@implementation Character


@synthesize data;
@synthesize name;
@synthesize role;

- (id) initWithPosition:(CGPoint)position indefiener:(int)indefiener data:(NSDictionary *)theData {
    
    self = [super initWithPosition:position filename:[theData objectForKey:CHARACTER_SPRITE] indefiener:indefiener];

    [self setData:theData];
    [self setState:JUST_CREATED];
    
    [self setName:[theData objectForKey:CHARACTER_NAME]];
    [self setRole:[theData objectForKey:CHARACTER_ROLE]];
    [self setGravityScale:CGPointFromString([theData objectForKey:CHARACTER_GRAVITYSCALE])];
    
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

- (BOOL) intersectWithCharacter:(Character *) character {
    
    if (self == character) {
        return FALSE;
    }

    b2Vec2 pos   = body_->GetPosition();
    b2Vec2 pos2  = [character body]->GetPosition();

    return CGRectIntersectsRect(CGRectMake((pos.x*PTM_RATIO)-55, (pos.y*PTM_RATIO)-55, 110, 110), CGRectMake((pos2.x*PTM_RATIO)-55, (pos2.y*PTM_RATIO)-55, 110, 110));
}


+ (NSMutableDictionary *) characterDataByType:(NSString *)characterType {
    return [NSMutableDictionary dictionaryWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:characterType]];
}


-(CGAffineTransform) nodeToParentTransform
{
    if (body_ == NULL) {
        return [super nodeToParentTransform];
    }
    
	b2Vec2 pos  = body_->GetPosition();
	
    b2Vec2 initialPosition = b2Vec2(CGPointFromString([[self data] objectForKey:CHARACTER_POSITION]).x, CGPointFromString([[self data] objectForKey:CHARACTER_POSITION]).y);
    
    if (fabs(pos.x*PTM_RATIO - initialPosition.x) < 0.01 && fabs(pos.y*PTM_RATIO == initialPosition.y) < 0.001) {
        [self setState:JUST_CREATED];
    } else {
        [self setState:(ccpDistance(ccp(pos.x,pos.y), ccp(previousPosition_.x,previousPosition_.y)) < .05) ? SLEEPING : MOVING];
    }
    
    if (OUT_THE_SCREEN(ccp(pos.x * PTM_RATIO, pos.y * PTM_RATIO))) {
        [self setState:OUT];
    }
    
    previousPosition_ = pos;
    
	
	return [super nodeToParentTransform];
}


@end
