//
//  SDEnemy.m
//  SpaceInvader
//
//  Created by vingosj on 13-11-6.
//  Copyright (c) 2013年 vingosj. All rights reserved.
//

#import "SDEnemy.h"

@implementation SDEnemy

@synthesize _health;
@synthesize _shootCountDown;

- (id)initWithArray:(NSMutableArray *)array andLayer:(HelloWorldLayer *)layer
{
    if (self = [super init])
    {
        //*init the enemy staff here
        _FireRecovery = 60;
        self._health = 5;
        //self._hurt = 0;
        self._shootCountDown = self.FireRecovery;
        self._projectiles = [[NSMutableArray alloc] init];
        
        [self initialSprite];
        [self actionWithArray:array andLayer:layer];
    }
    return self;
}

- (void)initialSprite
{
    self._sprite = [[CCSprite alloc] initWithFile:@"monster.png"];
    int minY = self._sprite.contentSize.height / 2;
    int maxY = self.WindowSize.height - self._sprite.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    [self._sprite setPosition:ccp(self.WindowSize.width - self._sprite.contentSize.width/2, actualY)];
}

- (void)actionWithArray:(NSMutableArray *)array andLayer:(HelloWorldLayer *)layer
{
    CCMoveTo *actionMove = [CCMoveTo actionWithDuration:4
                                               position:ccp(-self._sprite.contentSize.width/2, self._sprite.position.y)];
    CCCallBlockN *actionMoveDone = [CCCallBlockN actionWithBlock: ^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
        [array removeObject:self];
    }];
    CCAction *sequence = [CCSequence actions:actionMove, actionMoveDone, nil];
    sequence.tag = 1;
    [self._sprite runAction:sequence];
    [layer addChild:self._sprite];
    [array addObject:self];
}

- (void)blink:(NSMutableArray *)array
{
    //ccColor3B oldColor = self._sprite.color;
    //id tintAction
    //id tintBack = [CCTintTo actionWithDuration:0.5 red:oldColor.r green:oldColor.g blue:oldColor.b];
    //[self._sprite stopAllActions];
    //id oldAction = [self._sprite getActionByTag:1];
    CCAction *blinkAction = [CCBlink actionWithDuration:1 blinks:1];
    [[[CCDirector sharedDirector] actionManager] addAction:blinkAction target:self._sprite paused:YES];
    
    //[[CCActionManager sharedManager] addAction:blinkAction target:self._sprite paused:NO];
    //[self._sprite runAction:blinkAction];
    //NSLog(@"here");
}

- (void)shooted:(HelloWorldLayer *)layer andArray:(NSMutableArray *)array
{
    if (self._health <= 0) {
        [array removeObject:self];
        [self explosion:layer];
    }
    else
    {
        [self blink:array];
    }
    /*
    self._health -= power;
    if (self._health <= 0) {
        [self explosion];
    }
    [self blink:array];
     */
}

- (void)hurt:(float)power
{
    [self set_health:(self._health - power)];
}

- (void)render
{
    //*enemy render here
}

- (void)explosion:(HelloWorldLayer *)layer
{
    [layer removeChild:self._sprite cleanup:YES];
    //*add explosion effects here
}

- (void)update:(HelloWorldLayer *)layer fireObject:(CGPoint)player
{
    //*main loop of the player
    //NSLog(@"%d", self._shootCountDown);
    if (self._shootCountDown == 1) {
        SDBullet *bullet = [[SDBullet alloc] initWithPosition:self._sprite.position andDestination:player andArray:self._projectiles];
        [layer addChild:bullet._sprite];
        [self._projectiles addObject:bullet];
        self._shootCountDown = self.FireRecovery;
        NSLog(@"hehe enemy");
    } else {
        self._shootCountDown--;
    }
    
}
- (void)dealloc
{
    NSLog(@"Dealloc enemy!");
    [super dealloc];
}
@end
