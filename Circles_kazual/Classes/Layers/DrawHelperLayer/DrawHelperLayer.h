//
//  DrawHelperLayer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/27/13.
//
//

#import "DrawingLayer.h"

@interface DrawHelperLayer : DrawingLayer {
    NSInteger pointer_;
}

@property (nonatomic, retain) NSArray * pointsToDraw;


- (void) setupWithPoints:(NSArray *)points;

- (NSInteger) pointer;

- (void) start;
- (void) stop;

@end
