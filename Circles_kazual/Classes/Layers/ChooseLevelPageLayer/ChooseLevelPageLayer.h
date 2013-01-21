//
//  ChooseLevelPageLayer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/21/13.
//
//

#import "BaseLayer.h"

@protocol ChooseLevelPageLayerDelegate;


@interface ChooseLevelPageLayer : BaseLayer

@property (nonatomic, assign) id <ChooseLevelPageLayerDelegate> delegate;
@property (nonatomic, assign) NSDictionary *info;

- (void) initialize;

@end



@protocol ChooseLevelPageLayerDelegate <NSObject>



@end