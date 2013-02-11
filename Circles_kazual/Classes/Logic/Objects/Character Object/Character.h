//
//  Character.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/10/13.
//
//

#import "PhysicsObject.h"


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
