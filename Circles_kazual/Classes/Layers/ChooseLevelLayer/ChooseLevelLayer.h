//
//  ChooseLevelLayer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/21/13.
//
//

#import "BaseLayer.h"
#import "ChooseLevelPageLayer.h"

@interface ChooseLevelLayer : BaseLayer <ChooseLevelPageLayerDelegate> {
     NSMutableArray * pages_;
}

@end
