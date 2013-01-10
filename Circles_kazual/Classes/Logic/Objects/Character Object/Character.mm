//
//  Character.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/10/13.
//
//

#import "Character.h"

@implementation Character


- (id) initWithPosition:(CGPoint)position filename:(NSString *)filename indefiener:(int)indefiener {

    self = [super initWithPosition:position filename:filename indefiener:indefiener];
    
    return self;
}


- (void) disablePhysics {
    if (physicsBodyExist_) {
        world_->DestroyBody([self body]);
        physicsBodyExist_ = FALSE;
    }
}

@end
