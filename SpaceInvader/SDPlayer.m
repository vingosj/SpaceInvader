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

- (id)initWithLayer:(HelloWorldLayer *)layer
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
        //[self initialSprite];
        self._spriteBatch = [CCSpriteBatchNode batchNodeWithFile:@"ships1.png"];
        [layer addChild:self._spriteBatch];
        
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
        for(int i =1; i <=4; ++i) {
            [walkAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"ships1_%d.png", i]]];
        }
        CCAnimation *walkAnim = [CCAnimation
                                 animationWithSpriteFrames:walkAnimFrames delay:0.1f];
        self._sprite = [CCSprite spriteWithSpriteFrameName:@"ships1_1.png"];
        //*position
        [self._sprite setPosition:ccp(self._sprite.contentSize.width/2, self.WindowSize.height/2)];
        self._moveAction = [CCRepeatForever actionWithAction:
                           [CCAnimate actionWithAnimation:walkAnim]];
        [self._sprite runAction:self._moveAction];
        [self._spriteBatch addChild:self._sprite];
        
    }
    return self;
}

- (void)initialSprite
{
    self._spriteBatch = [CCSpriteBatchNode batchNodeWithFile:@"enemy.png"];
    //self._sprite = [[CCSprite alloc] initWithFile:@"player.png"];
    //[self._sprite setPosition:ccp(self._sprite.contentSize.width/2, self.WindowSize.height/2)];
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
    [self._moveAction release];
    [self._sprite release];
    [self._spriteBatch release];
    [self._projectiles release];
    [super dealloc];
}

@end
