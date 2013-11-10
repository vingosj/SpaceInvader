//
//  SDPlayer.m
//  SpaceInvader
//
//  Created by vingosj on 13-11-5.
//  Copyright (c) 2013年 vingosj. All rights reserved.
//

#import "SDPlayer.h"
//#import "HelloWorldLayer.h"


@implementation SDPlayer

@synthesize _dead;
@synthesize _speed;
@synthesize _fireRecovery;

- (id)init
{
    if(self = [super init])
    {
        self._dead = false;
        self._speed = 20.0;
        self._fireRecovery = 0.8;
        
        [self initialSprite];
    }
    return self;
}

- (void)initialSprite
{
    self._sprite = [[CCSprite alloc] initWithFile:@"player.png"];
    [self._sprite setPosition:ccp(self._sprite.contentSize.width/2, self.WindowSize.height/2)];
}

- (void)move
{
    //*the action of player
}

- (void)fire
{
    //*fire!
}

- (void)update
{
    //*main loop of the player
    
    
}

@end
