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
        
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
        // @"enemy1_default.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
         @"enemy2.plist"];
        _player = [[SDPlayer alloc] initWithLayer:self];
        //_enemy = [[SDEnemy alloc] init];
        //CCSprite *player = [CCSprite spriteWithFile:@"player.png"];
        //player.position = ccp(200, 200);
		//[self addChild:_player._sprite];
        //[self addChild:_enemy._sprite];
        [self schedule:@selector(gameLogic:) interval:1.0];
		_enemys = [[NSMutableArray alloc] init];
        
        
        [self setTouchEnabled:YES];
        [self schedule:@selector(update:)];
        
        
        
        //*add backgroud music here
        //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:<#(NSString *)#>];
        
        // create and initialize a Label
        score = 0;
        scorelabel = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:12];
        [scorelabel setString: [NSString stringWithFormat:@"Score: %d",score]];

		// ask director for the window size
		// position the label on the center of the screen
		scorelabel.position =  ccp( 100 , 100 );
		
		// add the label as a child to this Layer
		
        CCProgressTimer* powerBar= [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"fullbar.png"]];
        powerBar.type = kCCProgressTimerTypeBar;
        powerBar.midpoint = ccp(0,0); // starts from left
        powerBar.barChangeRate = ccp(1,0); // grow only in the "x"-horizontal direction
        powerBar.percentage = 100; // (0 - 100)
        powerBar.position = ccp(190, 100);
        [scorelabel addChild:powerBar z:1];
		
        [self addChild: scorelabel z:1];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // Create a label for display purposes
        _label = [CCLabelTTF labelWithString:@"Test" fontName:@"Marker Felt" fontSize:12];
        _label.position = ccp(winSize.width/2,
                              winSize.height-(_label.contentSize.height/2));
        [self addChild:_label z:1];
        
        // Standard method to create a button
        CCMenuItem *starMenuItem = [CCMenuItemImage
                                    itemWithNormalImage:@"ButtonStar.png" selectedImage:@"ButtonStarSel.png"
                                    target:self selector:@selector(starButtonTapped:)];
        starMenuItem.position = ccp(60, 60);
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
    //* main loop update function
    [_player update:self];
    for (SDEnemy *enemy in _enemys) {
        [enemy update:self fireObject:_player._sprite.position];
    }
    
    
    NSMutableArray *bulletsToDelete = [[NSMutableArray alloc] init];
    for (SDBullet *bullet in _player._projectiles) {
        
        NSMutableArray *enemyToDelete = [[NSMutableArray alloc] init];
        for (SDEnemy *enemy in _enemys) {
            if (CGRectIntersectsRect(bullet._sprite.boundingBox, enemy._sprite.boundingBox)) {
                [enemy hurt:bullet._power];
                [enemyToDelete addObject:enemy];
                if (enemy._health == 0)
                {
                    score++;
                    [scorelabel setString: [NSString stringWithFormat:@"Score: %d",score]];
                }
            }
        }
        
        for (SDEnemy *enemy in enemyToDelete) {
            //[_enemys removeObject:enemy];
            [enemy shooted:self andArray:_enemys];
            //[self removeChild:enemy._sprite cleanup:YES];
        }
        
        if (enemyToDelete.count > 0) {
            [bulletsToDelete addObject:bullet];
        }
        [enemyToDelete release];
    }
    
    for (SDBullet *bullet in bulletsToDelete) {
        [_player._projectiles removeObject:bullet];
        [self removeChild:bullet._sprite cleanup:YES];
    }
    [bulletsToDelete release];
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
    _enemys = nil;
    [_label release];
    _label = nil;
    [scorelabel release];
    scorelabel = nil;
    
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
    [_label setString:@"Last button: *"];
}
@end
