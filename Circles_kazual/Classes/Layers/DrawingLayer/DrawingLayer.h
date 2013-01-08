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

@end

@interface DrawingLayer : CCLayer {
        NSMutableArray * touchesArray_;
}

@property (nonatomic, assign) NSMutableArray * touchesArray;

@property (nonatomic,assign) NSObject <DrawingLayerDelegate> * delegate;

@end


