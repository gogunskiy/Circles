

#import "PhysicsObject.h"



@implementation PhysicsObject

@synthesize gravityScale;
@synthesize state;
@synthesize previousPos;

- (b2Body *) body {
    return body_;
}

-(void) setWorld:(b2World *)theWorld {
    world_ = theWorld;
}


- (id) init
{
	self = [super init];

    physicsBodyExist_ = FALSE;
    
	restitution_ = .5 ;
	density_ = 0.2 ;
	friction_ = 0.1 ;
    
	return self;
}

- (id) initWithFileName:(NSString*) filename
{
	self = [super initWithFile:filename];
    
    restitution_ = .5 ;
	density_ = 0.2 ;
	friction_ = 0.1 ;
    
    physicsBodyExist_ = FALSE;
    
	return self;
}

- (id) initWithPosition:(CGPoint) position filename:(NSString*)filename indefiener:(int)indefiener
{
    if (filename && ![filename isEqualToString:@""]) {
        self = [self initWithFileName:filename];
    } else {
        self = [self init];
    }
	
	[self setTag:indefiener];
    position_ = position ;
    
	return self;
}

- (id) initWithPosition:(CGPoint) position frameName:(NSString*)frameName indefiener:(int)indefiener {
    
    if (frameName && ![frameName isEqualToString:@""]) {
        self = [super initWithSpriteFrameName:frameName];
    } else {
        self = [self init];
    }
    
    [self setTag:indefiener];
    position_ = position ;
    
    
    restitution_ = .5 ;
	density_ = 0.2 ;
	friction_ = 0.1 ;
    
    physicsBodyExist_ = FALSE;

    
    return self;
}

- (void) generateCirlceBodyWithRadius:(float) radius
{
	[self initCircleBodyWithPosition:position_ radius:radius restitution:restitution_ density:density_ friction:friction_ bodyType:b2_dynamicBody];
}

- (void) generateSquareBodyWithWidth:(float) width height:(float)height
{
	[self initSquareBodyWithPosition:position_ width:width height:height restitution:restitution_ density:density_ friction:friction_ bodyType:b2_dynamicBody];
}

- (void) generatePolygonBodyWithVerticles:(NSArray*)verticles
{
	[self initPolygonBodyWithPosition:position_ verticles:verticles restitution:restitution_ density:density_ friction:friction_ bodyType:b2_dynamicBody];
}

- (void) generateCirlceBodyWithRadius:(float) radius  bodyType:(b2BodyType)bodyType
{
	[self initCircleBodyWithPosition:position_ radius:radius restitution:restitution_ density:density_ friction:friction_ bodyType:bodyType];
}

- (void) generateSquareBodyWithWidth:(float) width height:(float)height bodyType:(b2BodyType)bodyType
{
	[self initSquareBodyWithPosition:position_ width:width height:height restitution:restitution_ density:density_ friction:friction_ bodyType:bodyType];
}

- (void) generatePolygonBodyWithVerticles:(NSArray*)verticles bodyType:(b2BodyType)bodyType
{
	[self initPolygonBodyWithPosition:position_ verticles:verticles restitution:restitution_ density:density_ friction:friction_ bodyType:bodyType];
}





- (void) setLinearDamping:(float)linearDamping
{
	body_->SetLinearDamping(linearDamping);
}


- (void) setAngularDamping:(float)angularDamping
{
	body_->SetAngularDamping(angularDamping);
}

- (void) setRestitution:(float)restitution
{
	restitution_ = restitution ;
	b2Fixture* f = body_->GetFixtureList() ;	
	f->SetRestitution(restitution);
}

- (void) setDensity:(float)density
{
	density_ = density ;
	b2Fixture* f = body_->GetFixtureList() ;	
	f->SetDensity(density);
}


- (void) setFriction:(float)friction
{
	friction_ = friction ;
	b2Fixture* f = body_->GetFixtureList() ;	
	f->SetDensity(friction_);
}



- (void) initCircleBodyWithPosition:(CGPoint)position
							 radius:(float) radius 
						restitution:(float)restitution 
							density:(float) density
						   friction:(float) friction
							bodyType:(b2BodyType)bodyType
{							
	
    [self setAnchorPoint:ccp(0.5,0.5)];
    
    b2BodyDef bodyDef;
    bodyDef.type = bodyType;
    bodyDef.linearDamping = 0.5;
    bodyDef.angularDamping = 0.5;
    bodyDef.position.Set(position.x/PTM_RATIO, position.y/PTM_RATIO);
    
    self.position = ccp( position.x, position.y);
    
    bodyDef.userData = self;
	
    body_ = world_->CreateBody(&bodyDef);
    
    // Define another box shape for our dynamic body_.
    b2CircleShape circle;
    circle.m_radius = radius/PTM_RATIO;
    // Define the dynamic body_ fixture.
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &circle;
    
    fixtureDef.restitution = restitution;
    fixtureDef.density = density;
    fixtureDef.friction = friction;
    
    body_->CreateFixture(&fixtureDef);
    
    
    physicsBodyExist_ = TRUE;
}

- (void) initSquareBodyWithPosition:(CGPoint)position
							  width:(float)width
							height:(float) height
						restitution:(float)restitution 
							density:(float) density
						   friction:(float) friction
						   bodyType:(b2BodyType)bodyType
{							
	[self setAnchorPoint:ccp(0.5,0.5)];
    
	b2BodyDef bodyDef;
	bodyDef.type = bodyType;
	bodyDef.linearDamping = 0.5;
	bodyDef.angularDamping = 0.5;
	bodyDef.position.Set(position.x/PTM_RATIO, position.y/PTM_RATIO);
	
	self.position = ccp( position.x, position.y);
    
    bodyDef.userData = self;
	
	body_ = world_->CreateBody(&bodyDef);
	
	// Define another box shape for our dynamic body_.
	b2PolygonShape square;
	square.SetAsBox(width/PTM_RATIO, height/PTM_RATIO);
	
	// Define the dynamic body_ fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &square;	
	
	fixtureDef.restitution = restitution;
	fixtureDef.density = density;
	fixtureDef.friction = friction;
	
	body_->CreateFixture(&fixtureDef);
    
    physicsBodyExist_ = TRUE;
	
}

- (void) initPolygonBodyWithPosition:(CGPoint)position
						   verticles:(NSArray*)verticles
						restitution:(float)restitution 
							density:(float) density
						   friction:(float) friction
						   bodyType:(b2BodyType)bodyType
{							
	
    [self setAnchorPoint:ccp(0,0)];
    
	b2BodyDef bodyDef;
	bodyDef.type = bodyType;
	bodyDef.linearDamping = 0.5;
	bodyDef.angularDamping = 0.5;
	bodyDef.position.Set(position.x/PTM_RATIO, position.y/PTM_RATIO);
	
	self.position = ccp( position.x, position.y);
    
    bodyDef.userData = self;
	
	body_ = world_->CreateBody(&bodyDef);
	
	// Define another box shape for our dynamic body_.
	b2PolygonShape square;
    
    // FIX !!!
	b2Vec2 verts[8] ;
	for (unsigned int i=0; i < [verticles count]; i++) 
	{
		b2Vec2 vect ;
		vect.x = CGPointFromString([verticles objectAtIndex:i]).x/PTM_RATIO ;
		vect.y = CGPointFromString([verticles objectAtIndex:i]).y/PTM_RATIO ;
		
		verts[i] = vect ;
	}
	
	square.Set(verts, [verticles count]);
	
	// Define the dynamic body_ fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &square;	
	
	fixtureDef.restitution = restitution;
	fixtureDef.density = density;
	fixtureDef.friction = friction;
	
	body_->CreateFixture(&fixtureDef);
	
    physicsBodyExist_ = TRUE;
}

-(BOOL) dirty
{
	return YES;
}

// returns the transform matrix according the Chipmunk Body values
-(CGAffineTransform) nodeToParentTransform
{
    if (body_ == NULL) {
        return [super nodeToParentTransform];
    }
    
	b2Vec2 pos  = body_->GetPosition();
	
	float x = pos.x * PTM_RATIO;
	float y = pos.y * PTM_RATIO;
	
	if ( ignoreAnchorPointForPosition_ ) {
		x += anchorPointInPoints_.x;
		y += anchorPointInPoints_.y;
	}
	
	// Make matrix
	float radians = body_->GetAngle();
	float c = cosf(radians);
	float s = sinf(radians);
	
	if( ! CGPointEqualToPoint(anchorPointInPoints_, CGPointZero) ){
		x += c*-anchorPointInPoints_.x + -s*-anchorPointInPoints_.y;
		y += s*-anchorPointInPoints_.x + c*-anchorPointInPoints_.y;
	}
	
	// Rot, Translate Matrix
	transform_ = CGAffineTransformMake( c,  s,
									   -s,	c,
									   x,	y );
	
	return transform_;
}


- (void) dealloc
{
	[super dealloc];
}

@end






