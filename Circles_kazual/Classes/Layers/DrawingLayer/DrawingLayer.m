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
    [touchesArray_ removeAllObjects];
    
}


-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event  {
    
    UITouch *touch = [ touches anyObject];
    CGPoint new_location = [touch locationInView: [touch view]];
    new_location = [[CCDirector sharedDirector] convertToGL:new_location];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    // add my touches to the naughty touch array
    [touchesArray_ addObject:NSStringFromCGPoint(new_location)];
    [touchesArray_ addObject:NSStringFromCGPoint(oldTouchLocation)];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSArray * points = [self approximateValuesForPoints:touchesArray_];
    
    if ([delegate respondsToSelector:@selector(drawingLayer:endDrawingWithPoints:)]) {
        [delegate drawingLayer:self endDrawingWithPoints:points];
    }
}


- (NSArray *) approximateValuesForPoints:(NSArray *)points {
    
    NSMutableArray * approximatePoints = [[NSMutableArray alloc] initWithArray:points];
    
    if ([approximatePoints count] <= 4) {
        return [approximatePoints autorelease];
    }

    NSMutableArray * pointsToAdd    = [[NSMutableArray alloc] init];
    NSMutableArray * pointsToDelete = [[NSMutableArray alloc] init];
    
    
    for (int i=1; i < [points count] - 5; i+=4) {
        CGPoint point = CGPointFromString([points objectAtIndex:i]);
        
        for (int j=1; j <4; j++) {
            
            NSString * pointValue = [points objectAtIndex:i+j];
            CGPoint nextPoint = CGPointFromString(pointValue);
            
            CGFloat distance = ccpDistance(point, nextPoint);
            
            if (distance > 50) {
                
                NSInteger numberOfPoints = distance/25;
                
                CGFloat deltaX = (nextPoint.x - point.x) / numberOfPoints ;
                CGFloat deltaY = (nextPoint.y - point.y) / numberOfPoints ;
                
                
                for (int k = 0; k < numberOfPoints; k++) {
                    CGPoint newPoint = ccp((point.x + k * deltaX), (point.y + k * deltaY));
                    
                    [pointsToAdd addObject:NSStringFromCGPoint(newPoint)];
                    
                }
            }
        }
    }
    
    for (int i=1; i < [points count] - 5; i+=4) {
        CGPoint point = CGPointFromString([points objectAtIndex:i]);
        
        for (int j=1; j <4; j++) {
            
            NSString * pointValue = [points objectAtIndex:i+j];
            CGPoint nextPoint = CGPointFromString(pointValue);
            
            CGFloat distance = ccpDistance(point, nextPoint);
            
            if (distance < 2) {
                [pointsToDelete addObject:pointValue];
            }
        }
    }
    
    [approximatePoints removeObjectsInArray:pointsToDelete];
    [approximatePoints addObjectsFromArray:pointsToAdd];

    [pointsToAdd release];
    [pointsToDelete release];
    
    return [approximatePoints autorelease];
}


-(void)draw
{
	glLineWidth(2.5);
    
    for(int i = 0; i < [touchesArray_ count]; i+=2)
    {
        CGPoint start = CGPointFromString([touchesArray_ objectAtIndex:i]);
        CGPoint end = CGPointFromString([touchesArray_ objectAtIndex:i+1]);
        ccDrawLine(start, end);
    }
}


@end
