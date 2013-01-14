//
//  DrawingLayer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/8/13.
//
//

#import "CCLayer.h"
#import "cocos2d.h"

@class DrawingLayer;

@protocol DrawingLayerDelegate <NSObject>

- (void)drawingLayer:(DrawingLayer *)DrawingLayer endDrawingWithPoints:(NSArray *)points;
- (void)drawingLayer:(DrawingLayer *)DrawingLayer drawingCanceledWithResoution:(NSString *)resolution;

@end

typedef enum DrawingState {
    DrawingStateInitialized,
    DrawingStateProccesing
    
} DrawingState;

@interface DrawingLayer : BaseLayer {
    NSMutableArray * touchesArray_;
    
    BOOL drawingEnabled_;
}

@property (nonatomic, assign) NSMutableArray * touchesArray;

@property (nonatomic,assign) NSObject <DrawingLayerDelegate> * delegate;

@property (nonatomic, assign) DrawingState drawingState;

- (NSArray *) points;


- (void) reset;


@end


