//
//  BasePopupLayer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/20/13.
//
//

#import "BaseLayer.h"

@interface BasePopupLayer : BaseLayer

@property (nonatomic, assign) CGFloat fadeDuration;

- (void) show;
- (void) hide;

@end
