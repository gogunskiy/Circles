//
//  Bonus.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/10/13.
//
//


@interface Bonus : CCSprite

@property (nonatomic, assign) CGFloat value;

- (id)initWithDictionary:(NSDictionary *)dict;

+ (NSMutableDictionary *) bonusDataByType:(NSString *) bonusType;

- (BOOL) intersectWithPosition:(CGPoint)position size:(CGSize)size ;

@end
