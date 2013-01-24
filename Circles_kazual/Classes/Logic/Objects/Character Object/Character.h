//
//  Character.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/10/13.
//
//

#import "PhysicsObject.h"

static NSString * const CHARACTER_TYPE                  = @"CharacterType";

static NSString * const CHARACTER_NAME                  = @"Name";

static NSString * const CHARACTER_ROLE                  = @"Role";

static NSString * const CHARACTER_ROLE_POSITIVE         = @"Positive";
static NSString * const CHARACTER_ROLE_NEGATIVE         = @"Negative";
static NSString * const CHARACTER_ROLE_LONELY           = @"Lonely";


static NSString * const CHARACTER_SPRITE                = @"SpriteName";
static NSString * const CHARACTER_GEOMETRY              = @"Geometry";
static NSString * const CHARACTER_GRAVITYSCALE          = @"Gravity";
static NSString * const CHARACTER_GEOMETRY_TYPE         = @"Type";

static NSString * const CHARACTER_GEOMETRY_TYPE_SQUARE  = @"Square";
static NSString * const CHARACTER_GEOMETRY_TYPE_CIRCLE  = @"Circle";
static NSString * const CHARACTER_GEOMETRY_TYPE_POLYGON = @"Polygon";
static NSString * const CHARACTER_GEOMETRY_POINTS       = @"Points";
static NSString * const CHARACTER_GEOMETRY_RADIUS       = @"Radius";
static NSString * const CHARACTER_FILE                  = @"File";
static NSString * const CHARACTER_POSITION              = @"Position";

@class CharacterDirectionArrow;

@interface Character : PhysicsObject {
    CharacterDirectionArrow * arrow_;
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * role;
@property (nonatomic, retain) NSDictionary * data;

- (id) initWithPosition:(CGPoint)position indefiener:(int)indefiener data:(NSDictionary *)theData;

- (void) enablePhysics;
- (void) disablePhysics;

- (BOOL) intersectWithCharacter:(Character *) character;

+ (NSMutableDictionary *) characterDataByType:(NSString *)characterType;

@end
