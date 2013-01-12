//
//  DrawingLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/8/13.
//
//

#import "DrawingLayer.h"

@interface DrawingLayer()

- (NSArray *) approximateValuesForPoints:(NSArray *)points;

@end

@implementation DrawingLayer

@synthesize touchesArray = touchesArray_;
@synthesize delegate;

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



- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  
    UITouch *touch = [ touches anyObject];
    CGPoint new_location = [touch locationInView: [touch view]];
    new_location = [[CCDirector sharedDirector] convertToGL:new_location];
    
    if (!CGRectContainsPoint(CGRectMake(60, 60, 904, 648), new_location)) {
        return;
    }
    
    [touchesArray_ removeAllObjects];
    
}


-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event  {
    
    UITouch *touch = [ touches anyObject];
    CGPoint new_location = [touch locationInView: [touch view]];
    new_location = [[CCDirector sharedDirector] convertToGL:new_location];
    
    if (!CGRectContainsPoint(CGRectMake(60, 60, 904, 648), new_location)) {
        return;
    }
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    // add my touches to the naughty touch array
    [touchesArray_ addObject:NSStringFromCGPoint(new_location)];
    [touchesArray_ addObject:NSStringFromCGPoint(oldTouchLocation)];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [ touches anyObject];
    CGPoint new_location = [touch locationInView: [touch view]];
    new_location = [[CCDirector sharedDirector] convertToGL:new_location];
    
    if (!CGRectContainsPoint(CGRectMake(60, 60, 904, 648), new_location)) {
        return;
    }
    
    NSArray * points = [self approximateValuesForPoints:touchesArray_];
    
    if ([delegate respondsToSelector:@selector(drawingLayer:endDrawingWithPoints:)]) {
        [delegate drawingLayer:self endDrawingWithPoints:points];
    }
}


- (NSArray *) approximateValuesForPoints:(NSArray *)points {

    return points;
}


-(void)draw
{
	glLineWidth(7);
    
    for(int i = 0; i < [touchesArray_ count]; i+=2)
    {
        CGPoint start = CGPointFromString([touchesArray_ objectAtIndex:i]);
        CGPoint end = CGPointFromString([touchesArray_ objectAtIndex:i+1]);
        ccDrawLine(start, end);
    }
}


@end
