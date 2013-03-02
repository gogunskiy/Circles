
#import "cocos2d.h"
#import "Box2D.h"


#define PTM_RATIO 32

typedef enum BODY_STATE {
    JUST_CREATED,
    SLEEPING,
    MOVING,
    OUT
    
} BODY_STATE;

@interface PhysicsObject : CCSprite
{
	b2Body			*body_ ;
	b2World			*world_;

	float			restitution_ ;
	float			density_ ;
	float			friction_ ;
    
    BOOL            physicsBodyExist_;
    
    b2Vec2 previousPosition_;
}

@property (nonatomic, assign) BODY_STATE state;
@property (nonatomic, assign) CGPoint gravityScale;
@property (nonatomic, assign) CGPoint previousPos;

- (b2Body *) body ;

-(void) setWorld:(b2World *)theWorld;


- (id) initWithPosition:(CGPoint) position filename:(NSString*)filename indefiener:(int)indefiener;
- (id) initWithPosition:(CGPoint) position frameName:(NSString*)frameName indefiener:(int)indefiener;

- (id) initWithFileName:(NSString*) filename ;

- (void) initCircleBodyWithPosition:(CGPoint)position 
							 radius:(float) radius 
						restitution:(float)restitution 
							density:(float) density
						   friction:(float) friction
						   bodyType:(b2BodyType)bodyType;


- (void) initSquareBodyWithPosition:(CGPoint)position 
							  width:(float)width
							 height:(float) height
						restitution:(float)restitution 
							density:(float) density
						   friction:(float) friction
						   bodyType:(b2BodyType)bodyType ;

- (void) initPolygonBodyWithPosition:(CGPoint)position 
						   verticles:(NSArray*)verticles
						 restitution:(float)restitution 
							 density:(float) density
							friction:(float) friction
							bodyType:(b2BodyType)bodyType ;


- (void) generateCirlceBodyWithRadius:(float) radius ;
- (void) generateSquareBodyWithWidth:(float) width height:(float)height ;
- (void) generatePolygonBodyWithVerticles:(NSArray*)verticles ;

- (void) generateCirlceBodyWithRadius:(float) radius  bodyType:(b2BodyType)bodyType ;
- (void) generateSquareBodyWithWidth:(float) width height:(float)height bodyType:(b2BodyType)bodyType ;
- (void) generatePolygonBodyWithVerticles:(NSArray*)verticles bodyType:(b2BodyType)bodyType ;

- (void) setRestitution:(float)restitution ;
- (void) setDensity:(float)density ;
- (void) setFriction:(float)friction ;
- (void) setLinearDamping:(float)linearDamping ;
- (void) setAngularDamping:(float)angularDamping ;

@end
