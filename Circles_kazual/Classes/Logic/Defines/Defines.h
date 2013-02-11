//
//  Defines.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/22/13.
//
//

#define RESOURCE_FILE(file) [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:(file)]

#pragma mark - SETTINGS KEYS -

static NSString * const SETTINGS_KEY_CHOOSE_LEVEL_ACTIVE_PAGE = @"ChooseLevel_ActivePage";



#pragma mark - GAME RESULT KEYS -

static NSString * const GAME_RESULT     = @"GAME_RESULT";
static NSString * const WIN_RESULT      = @"WIN";
static NSString * const LOSE_RESULT     = @"LOSE";



#pragma mark - WORLD LAYER KEYS -

static NSString * const WORLD_LAYERS                    = @"Layers";
static NSString * const WORLD_LAYER_IMAGE               = @"imageName";
static NSString * const WORLD_LAYER_ORDER               = @"order";
static NSString * const WORLD_LAYER_OPACITY             = @"opacity";

static NSString * const WORLD_OBJECTS                   = @"Objects";
static NSString * const WORLD_OBJECT_IMAGE              = @"imageName";
static NSString * const WORLD_OBJECT_ORDER              = @"order";
static NSString * const WORLD_OBJECT_POSITION           = @"position";
static NSString * const WORLD_OBJECT_ACTIONS            = @"actions";
static NSString * const WORLD_OBJECT_ACTION_TYPE        = @"type";
static NSString * const WORLD_OBJECT_ACTION_DURATION    = @"duration";
static NSString * const WORLD_OBJECT_ACTION_VALUE       = @"value";
static NSString * const WORLD_OBJECT_ACTION_MOVE_BY     = @"moveBy";
static NSString * const WORLD_OBJECT_ACTION_DELAY       = @"delay";
static NSString * const WORLD_OBJECT_ACTION_FADE_TO     = @"fadeTo";



#pragma mark - CHARACTER KEYS -

static NSString * const CHARACTER_TYPE                  = @"CharacterType";
static NSString * const CHARACTER_NAME                  = @"Name";
static NSString * const CHARACTER_ROLE                  = @"Role";
static NSString * const CHARACTER_ROLE_POSITIVE         = @"Positive";
static NSString * const CHARACTER_ROLE_NEGATIVE         = @"Negative";
static NSString * const CHARACTER_ROLE_LONELY           = @"Lonely";
static NSString * const CHARACTER_SPRITE                = @"SpriteName";
static NSString * const CHARACTER_GEOMETRY              = @"Geometry";
static NSString * const CHARACTER_GRAVITYSCALE          = @"Gravity";
static NSString * const CHARACTER_GEOMETRY_TYPE         = @"Type";
static NSString * const CHARACTER_GEOMETRY_TYPE_SQUARE  = @"Square";
static NSString * const CHARACTER_GEOMETRY_TYPE_CIRCLE  = @"Circle";
static NSString * const CHARACTER_GEOMETRY_TYPE_POLYGON = @"Polygon";
static NSString * const CHARACTER_GEOMETRY_POINTS       = @"Points";
static NSString * const CHARACTER_GEOMETRY_RADIUS       = @"Radius";
static NSString * const CHARACTER_FILE                  = @"File";
static NSString * const CHARACTER_POSITION              = @"Position";

#pragma mark - BONUS KEYS -

static NSString * const BONUS_FILE                      = @"File";
static NSString * const BONUS_POSITION                  = @"Position";
static NSString * const BONUS_NAME                      = @"Name";
static NSString * const BONUS_SPRITE                    = @"SpriteName";
static NSString * const BONUS_VALUE                     = @"Value";


