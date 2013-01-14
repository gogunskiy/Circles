//
//  DrawingLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/8/13.
//
//

#import "DrawingLayer.h"

static NSString * DRAW_MORE_THAN_ONE_LINE_ERROR  =  @"Cannot draw more than one line per level";

@interface DrawingLayer()


@end

@implementation DrawingLayer

@synthesize touchesArray = touchesArray_;
@synthesize delegate;
@synthesize drawingState;

-(id) init {
    if((self = [super init])) {
        touchesArray_ =[[NSMutableArray alloc ] init];
        self.isTouchEnabled = YES;
        
    }
    return self;
}



- (void) dealloc
{
    [touchesArray_ release];
    [super dealloc];
}

- (void) reset {
    
    [touchesArray_ removeAllObjects];
    [self setDrawingState:DrawingStateInitialized];
    drawingEnabled_ = TRUE;
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  
    drawingEnabled_ = ([self drawingState] == DrawingStateInitialized);
    
    [self setDrawingState:DrawingStateProccesing];
    
    if (!drawingEnabled_) {

        if ([[self delegate] respondsToSelector:@selector(drawingLayer:drawingCanceledWithResoution:)]) {
            [[self delegate] drawingLayer:self drawingCanceledWithResoution:DRAW_MORE_THAN_ONE_LINE_ERROR];
        }
    }
}


-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event  {
    
    if (drawingEnabled_) {
        UITouch *touch = [ touches anyObject];
        CGPoint new_location = [touch locationInView: [touch view]];
        new_location = [[CCDirector sharedDirector] convertToGL:new_location];
        
        
        CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
        oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
        oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
        
        [touchesArray_ addObject:NSStringFromCGPoint(new_location)];
        [touchesArray_ addObject:NSStringFromCGPoint(oldTouchLocation)];
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

}


- (NSArray *) points {

    NSArray * points = [NSArray arrayWithArray:touchesArray_];
    
    return points;
}


-(void)draw
{
	glLineWidth(7);
    
    for(int i = 0; i < [touchesArray_ count] / 2 * 2; i+=2)
    {
        CGPoint start = CGPointFromString([touchesArray_ objectAtIndex:i]);
        CGPoint end = CGPointFromString([touchesArray_ objectAtIndex:i+1]);
        ccDrawLine(start, end);
    }
}


@end
