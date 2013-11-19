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
        self._level = 1;
        self._dead = false;
        self._speed = 20.0;
        self._fireRecovery = 300;
        self._fireCountDown = 300;
        self._health = 100;
        self._projectiles = [[NSMutableArray alloc] init];
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

- (id)fire
{
    SDBullet *bullet = [[SDBullet alloc] initWithPosition:self._sprite.position
                                                                    andArray:__projectiles];
    [__projectiles addObject:bullet];
    return bullet;
}

- (id)fire:(CGPoint) point andDestination:(CGPoint)dest
{
    //*fire!
    SDBullet *bullet = [[SDBullet alloc] initWithPosition:self._sprite.position
                                           andDestination:dest andArray:__projectiles];
    [__projectiles addObject:bullet];
    return bullet;
}

- (BOOL)shooted:(float)health
{
    self._health -= health;
    if (self._health <= 0) {
        return false;
    }
    return true;
}

- (void)levelup
{
    self._fireRecovery -= 5;
    self._health++;
    self._power++;
    self._speed+=5;
}

- (void)update:(HelloWorldLayer *)layer
{
    //*main loop of the player
    if (self._fireCountDown == 1) {
        SDBullet *bullet = [[SDBullet alloc] initWithPosition:self._sprite.position
                                                     andArray:self._projectiles];
        [layer addChild:bullet._sprite];
        [self._projectiles addObject:bullet];
        self._fireCountDown = self._fireRecovery;
    } else {
        self._fireCountDown--;
    }
    
}

- (void)dealloc
{
    [self._projectiles release];
    [super dealloc];
}

@end
