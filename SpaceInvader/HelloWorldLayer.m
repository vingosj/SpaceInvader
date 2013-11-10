//
//  HelloWorldLayer.m
//  SpaceInvader
//
//  Created by vingosj on 13-11-5.
//  Copyright vingosj 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "SDPlayer.h"
#import "SDEnemy.h"
#import "SDBullet.h"



#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer {
    SDPlayer *_player;
    SDEnemy *_enemy;
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
	if( (self=[super initWithColor:ccc4(255, 255, 255, 255)]) ) {
        
        _player = [[SDPlayer alloc] init];
        //_enemy = [[SDEnemy alloc] init];
        //CCSprite *player = [CCSprite spriteWithFile:@"player.png"];
        //player.position = ccp(200, 200);
		[self addChild:_player._sprite];
        //[self addChild:_enemy._sprite];
        [self schedule:@selector(gameLogic:) interval:1.0];
		NSLog(@"the speed is %f.", _player._speed);
        NSLog(@"the width is %f.", _player._sprite.contentSize.width);
        
        [self setTouchEnabled:YES];
        
        // create and initialize a Label
		//CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

		// ask director for the window size
		//CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		//label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		//[self addChild: label];
		
		
		
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
    //
    SDEnemy *newEnemy = [[SDEnemy alloc] init];
    [self addChild:newEnemy._sprite];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [self convertTouchToNodeSpace:touch];
    SDBullet *bullet = [[SDBullet alloc] initWithPosition:_player._sprite.position andDestination:location];
    [self addChild:bullet._sprite];
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
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
@end
