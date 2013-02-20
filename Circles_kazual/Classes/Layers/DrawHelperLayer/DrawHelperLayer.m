//
//  DrawHelperLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/27/13.
//
//

#import "DrawHelperLayer.h"

@interface DrawHelperLayer()

- (void) clear;

@end

@implementation DrawHelperLayer

@synthesize pointsToDraw;


- (id)init
{
    self = [super init];
    if (self) {
        [self setIsTouchEnabled:FALSE];
    }
    return self;
}

- (void) setupWithPoints:(NSArray *)points {
    
    pointer_ = 0;
    [self setPointsToDraw:points];
}

- (NSInteger) pointer {
    
    if ( pointer_ > [[self pointsToDraw] count] - 2) {
        [self clear];
    }
    
    pointer_ ++;
    
    return pointer_;
}


- (void) start {
    [self schedule:@selector(update) interval:0.03];
}

- (void) stop {
    [self unschedule:@selector(update)];
    [self clear];
}

- (void) update {
    [touchesArray_ addObject:[[self pointsToDraw] objectAtIndex:[self pointer]]];
}


- (void) clear {
    pointer_ = 0;
    [touchesArray_ removeAllObjects];
}

- (NSArray *) points {
    return touchesArray_;
}



@end
