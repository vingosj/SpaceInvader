//
//  GameOverLayer.h
//  SpaceInvader
//
//  Created by vingosj on 13-11-10.
//  Copyright (c) 2013年 vingosj. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface GameOverLayer : CCLayerColor

+ (CCScene *) sceneWithWon:(BOOL)won;
- (id)initWithWon:(BOOL)won;
@end
