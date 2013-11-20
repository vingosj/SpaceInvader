//
//  HelloWorldLayer.h
//  SpaceInvader
//
//  Created by vingosj on 13-11-5.
//  Copyright vingosj 2013年. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "SDPlayer.h"
#import "SDEnemy.h"
#import "Joystick.h"
#import "CCNodeAdornments.h"
#import "CCNodeExtensions.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayerColor <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
}


// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;


@end
