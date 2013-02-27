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


-(void) drawLineWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint  color:(ccColor4F) color width:(CGFloat)width;

@end

@implementation DrawingLayer

@synthesize touchesArray = touchesArray_;
@synthesize delegate;
@synthesize drawingState;

-(id) init {
    if((self = [super init])) {
        touchesArray_ =[[NSMutableArray alloc ] init];
        self.isTouchEnabled = YES;
        shaderProgram_ = [[CCShaderCache sharedShaderCache] programForKey:kCCShader_PositionColor];

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
    } else {
        if ([[self delegate] respondsToSelector:@selector(drawingLayer:startDrawingWithResoution:)]) {
            [[self delegate] drawingLayer:self startDrawingWithResoution:nil];
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
    ccColor4F color = {255, 255, 255, 255};
    float width = 2.0;
    
    for(int i = 0; i < [touchesArray_ count] / 2 * 2; i+=2)
    {
        CGPoint start = CGPointFromString([touchesArray_ objectAtIndex:i]);
        CGPoint end = CGPointFromString([touchesArray_ objectAtIndex:i+1]);

        [self drawLineWithStartPoint:start endPoint:end color:color width:width];
    }
}

-(void) drawLineWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint  color:(ccColor4F) color width:(CGFloat)width
{
    [shaderProgram_ use];
    [shaderProgram_ setUniformLocation:-1 with4fv:(GLfloat*) &color.r count:1];
    
    ccGLEnableVertexAttribs(kCCVertexAttribFlag_Position | kCCVertexAttribFlag_Color );
    GLfloat lineVertices[12];
    CGPoint dir, tan;
    
    dir.x = endPoint.x - startPoint.x;
    dir.y = endPoint.y - startPoint.y;
    float len = sqrtf(dir.x*dir.x+dir.y*dir.y);
    if(len<0.00001)
        return;
    dir.x = dir.x/len;
    dir.y = dir.y/len;
    tan.x = -width*dir.y;
    tan.y = width*dir.x;
    
    lineVertices[0] = startPoint.x + tan.x;
    lineVertices[1] = startPoint.y + tan.y;
    lineVertices[2] = endPoint.x + tan.x;
    lineVertices[3] = endPoint.y + tan.y;
    lineVertices[4] = startPoint.x;
    lineVertices[5] = startPoint.y;
    lineVertices[6] = endPoint.x;
    lineVertices[7] = endPoint.y;
    lineVertices[8] = startPoint.x - tan.x;
    lineVertices[9] = startPoint.y - tan.y;
    lineVertices[10] = endPoint.x - tan.x;
    lineVertices[11] = endPoint.y - tan.y;
    
    ccColor4F vertices[6];
    ccColor4F color1 = {255, 255, 255, 255};
    ccColor4F color2 = {255, 255, 255, 255};
    vertices[0] = color1;
    vertices[1] = color1;
    vertices[2] = color2;
    vertices[3] = color2;
    vertices[4] = color1;
    vertices[5] = color1;
    
    glVertexAttribPointer(kCCVertexAttrib_Position, 2, GL_FLOAT, GL_FALSE, 0, lineVertices);
    glVertexAttribPointer(kCCVertexAttrib_Color, 4, GL_FLOAT, GL_FALSE, 0, vertices);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 6);
    
}



@end
