//
//  HelloWorldLayer.m
//  SpaceInvader
//
//  Created by vingosj on 13-11-5.
//  Copyright vingosj 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
#import "GameOverLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"




#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer {
    SDPlayer *_player;
    int score;
    CCLabelTTF *scorelabel;
    CCLabelTTF *_label;
    NSMutableArray *_enemys;
    NSMutableArray *_enemyProjectiles;
    Joystick *_joystick;
    CCSprite *hpbar;
    float upbound;
}

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void)loadResource
{
    //* load resources here
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"ships1.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"enemy1.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"enemy2.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"enemy3.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"enemy4.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"enemy5.plist"];
}

-(void) initJoystick
{
    CCSprite* jsThumb = [CCSprite spriteWithFile: @"joystick.png"];
    CCSprite* jsBackdrop = [CCSprite spriteWithFile: @"dpad.png"];
    _joystick = [Joystick joystickWithThumb: jsThumb
                               andBackdrop: jsBackdrop];
    _joystick.position = ccp(20, 20);
    [self addChild:_joystick z:1000];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        //UIViewControllerBasedStatusBarAppearance = NO;
        
        CCSprite *background = [[CCSprite alloc] initWithFile:@"farback.gif"];
        CGSize wSize = [CCDirector sharedDirector].winSize;
        [background setPosition:ccp(wSize.width/2, wSize.height/2)];
        [self addChild:background z:-1];
        
        [self loadResource];
        _player = [[SDPlayer alloc] initWithLayer:self];
        //_enemy = [[SDEnemy alloc] init];
        //CCSprite *player = [CCSprite spriteWithFile:@"player.png"];
        //player.position = ccp(200, 200);
		//[self addChild:_player._sprite];
        //[self addChild:_enemy._sprite];
        [self schedule:@selector(gameLogic:) interval:1.0];
		_enemys = [[NSMutableArray alloc] init];
        _enemyProjectiles = [[NSMutableArray alloc] init];
        
        
        [self setTouchEnabled:YES];
        [self initJoystick];
        [self schedule:@selector(update:)];
        
        
        
        //*add backgroud music here
        //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:<#(NSString *)#>];
        
        // create and initialize a Label
        score = 0;
        scorelabel = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:12];
        [scorelabel setString: [NSString stringWithFormat:@"Score: %d",score]];

        hpbar = [CCSprite spriteWithFile:@"fullbar.png"];
        //powerBar= [CCProgressTimer progressWithSprite:hpbar];
        upbound = hpbar.contentSize.height/2;
		// ask director for the window size
		// position the label on the center of the screen
        CGSize winSize = [[CCDirector sharedDirector] winSize];

		scorelabel.position =  ccp(winSize.width/6+200,
                                   winSize.height-upbound);
		
		// add the label as a child to this Layer
        
        [self addChild: scorelabel z:1];
        
        // Create a label for display purposes
        _label = [CCLabelTTF labelWithString:@"HP: " fontName:@"Marker Felt" fontSize:12];
        _label.position = ccp(winSize.width/8,
                              winSize.height-upbound);
        [self addChild:_label z:1];
        hpbar.position = ccp(winSize.width/8+_label.contentSize.width+hpbar.contentSize.width/2,
                                winSize.height-upbound);
        [self addChild:hpbar z:1];

        
        // Standard method to create a button
        CCMenuItem *starMenuItem = [CCMenuItemImage
                                    itemWithNormalImage:@"ButtonStar.png" selectedImage:@"ButtonStarSel.png"
                                    target:self selector:@selector(starButtonTapped:)];
        starMenuItem.position = ccp(winSize.width-50,
                                    winSize.height-upbound);
        CCMenu *starMenu = [CCMenu menuWithItems:starMenuItem, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu z:1];
		
        
        
		//
		// Leaderboards and Achievements
		//
		
		// Default font size will be 28 points.
		//[CCMenuItemFont setFontSize:28];
		
		// to avoid a retain-cycle with the menuitem and blocks
		//__block id copy_self = self;
		
		// Achievement Menu Item using blocks
		/*CCMenuItem *itemAchievement = [CCMenuItemFont itemWithString:@"Achievements" block:^(id sender) {
			
			
			GKAchievementViewController *achivementViewController = [[GKAchievementViewController alloc] init];
			achivementViewController.achievementDelegate = copy_self;
			
			AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
			
			[[app navController] presentModalViewController:achivementViewController animated:YES];
			
			[achivementViewController release];
		}];
		*/
		// Leaderboard Menu Item using blocks
		/*CCMenuItem *itemLeaderboard = [CCMenuItemFont itemWithString:@"Leaderboard" block:^(id sender) {
			
			
			GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
			leaderboardViewController.leaderboardDelegate = copy_self;
			
			AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
			
			[[app navController] presentModalViewController:leaderboardViewController animated:YES];
			
			[leaderboardViewController release];
		}];
         */

		
		//CCMenu *menu = [CCMenu menuWithItems:itemAchievement, itemLeaderboard, nil];
		
		//[menu alignItemsHorizontallyWithPadding:20];
		//[menu setPosition:ccp( size.width/2, size.height/2 - 50)];
		
		// Add the menu to the layer
		//[self addChild:menu];

	}
	return self;
}

- (void)gameLogic:(ccTime)dt
{
    [[SDEnemy alloc] initWithArray:_enemys andLayer:self];
    //NSLog(@"projectile number = %d",_player._projectiles.count);
    //NSLog(@"enemy number = %d",_enemys.count);
}

- (void)update:(ccTime)delta
{
    //*move follow the joystick
    if (_joystick.velocity.x!=0 || _joystick.velocity.y!=0 ){
        [_player move:ccp(_joystick.velocity.x, _joystick.velocity.y)];
    }
    
    
    //* main loop update function
    [_player update:self];
    for (SDEnemy *enemy in _enemys) {
        [enemy update:self fireObject:_player._sprite.position projectiles:_enemyProjectiles];
    }
    /*
    for (SDEnemy *enemy in _enemys) {
        for (SDBullet *bullet in enemy._projectiles) {
            if (CGRectIntersectsRect(_player._sprite.boundingBox, bullet._sprite.boundingBox)) {
                if (![_player shooted:bullet._power]) {
                    CCScene *gameOverScene = [GameOverLayer sceneWithWon:NO];
                    [[CCDirector sharedDirector] replaceScene:gameOverScene];
                }
                [enemy._projectiles removeObject:bullet];
                [self removeChild:bullet._sprite cleanup:YES];
            }
        }
    }*/
    NSMutableArray *enemyToDelete = [[NSMutableArray alloc] init];
    for (SDEnemy *enemy in _enemys) {
        if ( CGRectIntersectsRect(_player._sprite.boundingBox, enemy._sprite.boundingBox) ) {
            float percent = _player._health/_player._totalhp;
            hpbar.scaleX = percent;
            CGSize winSize = [[CCDirector sharedDirector] winSize];
            hpbar.position = ccp(winSize.width/8+_label.contentSize.width+hpbar.contentSize.width/2*percent,
                                 winSize.height-upbound);
            //[powerBar.sprite setScale:percent];
            if (![_player shooted:enemy.Crash]) {
                CCScene *gameOverScene = [GameOverLayer sceneWithWon:NO];
                [[CCDirector sharedDirector] replaceScene:gameOverScene];
            }
            [enemyToDelete addObject:enemy];
            [self removeChild:enemy._sprite cleanup:YES];
        }
    }
    for (SDEnemy *enemy in enemyToDelete) {
        CGPoint position = enemy._sprite.position;
        [_enemys removeObject:enemy];
        [self Explosion:position];
    }
    
    NSMutableArray *bulletsToDelete = [[NSMutableArray alloc] init];
    for (SDBullet *bullet in _enemyProjectiles) {
        if (CGRectIntersectsRect(_player._sprite.boundingBox, bullet._sprite.boundingBox)) {
            float percent = _player._health/_player._totalhp;
            hpbar.scaleX = percent;
            CGSize winSize = [[CCDirector sharedDirector] winSize];
            hpbar.position = ccp(winSize.width/8+_label.contentSize.width+hpbar.contentSize.width/2*percent,
                                 winSize.height-upbound);
            //[self addChild:hpbar z:1];
            if (![_player shooted:bullet._power]) {
                CCScene *gameOverScene = [GameOverLayer sceneWithWon:NO];
                [[CCDirector sharedDirector] replaceScene:gameOverScene];
            }
            //[_enemyProjectiles removeObject:bullet];
            [bulletsToDelete addObject:bullet];
            [self removeChild:bullet._sprite cleanup:YES];
        }
    }
    for (SDBullet *bullet in bulletsToDelete) {
        [_enemyProjectiles removeObject:bullet];
    }
    //[bulletsToDelete release];
    
    
    //NSMutableArray *bulletsToDelete = [[NSMutableArray alloc] init];
    [bulletsToDelete removeAllObjects];
    for (SDBullet *bullet in _player._projectiles) {
        
        //NSMutableArray *enemyToDelete = [[NSMutableArray alloc] init];
        [enemyToDelete removeAllObjects];
        for (SDEnemy *enemy in _enemys) {
            if (CGRectIntersectsRect(bullet._sprite.boundingBox, enemy._sprite.boundingBox)) {
                [enemy hurt:bullet._power];
                [enemyToDelete addObject:enemy];
                if (enemy._health >= 0)
                {
                    score++;
                    [scorelabel setString: [NSString stringWithFormat:@"Score: %d",score]];
                    //[self Explosion:enemy._sprite.position];
                }
            }
        }
        
        for (SDEnemy *enemy in enemyToDelete) {
            //[_enemys removeObject:enemy];
            CGPoint position = enemy._sprite.position;
            if (![enemy shooted:self andArray:_enemys])
            {
                [self Explosion:position];
            }
            //[self removeChild:enemy._sprite cleanup:YES];
        }
        
        if (enemyToDelete.count > 0) {
            [bulletsToDelete addObject:bullet];
        }
        //[enemyToDelete release];
    }
    
    for (SDBullet *bullet in bulletsToDelete) {
        [_player._projectiles removeObject:bullet];
        [self removeChild:bullet._sprite cleanup:YES];
    }
    [bulletsToDelete release];
    [enemyToDelete release];
    
}

- (void)Explosion:(CGPoint)position
{
    CCParticleSystem *emitter = [CCParticleExplosion node];
    //set the location of the emitter
    emitter.position = position;
    //set size of particle animation
    emitter.scale = 0.2;
    //set an Image for the particle
    emitter.texture = [[CCTextureCache sharedTextureCache] addImage:@"particle.png"];
    
    //set length of particle animation
    [emitter setLife:0.1f];
    [emitter setLifeVar:0.5f];
    //add to layer ofcourse(effect begins after this step)
    [self addChild: emitter];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [self convertTouchToNodeSpace:touch];
    SDBullet *bullet = [_player fire:_player._sprite.position andDestination:location];
    [self addChild:bullet._sprite];
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[_enemys release];
    [_enemyProjectiles release];
    //[_label release];
    //[scorelabel release];
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
-(void)starButtonTapped:(id)sender {
    [_label setString:@"Pause!"];
}
@end
