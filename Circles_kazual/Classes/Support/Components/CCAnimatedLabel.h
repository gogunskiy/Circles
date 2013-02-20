//
//  CCAnimatedLabel.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 2/20/13.
//
//

#import "CCLabelFX.h"

@interface CCAnimatedLabel : CCLabelFX

@property (nonatomic, assign) float delay;
@property (nonatomic, assign) float delta;

@property (nonatomic, assign) int   currentValue;
@property (nonatomic, assign) int   startValue;
@property (nonatomic, assign) int   endValue;

- (void)setString:(NSString *)str animated:(BOOL)animated;


@end
