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
        _Crash = 3;
        self._shootCountDown = self.FireRecovery;
        //self._projectiles = [[NSMutableArray alloc] init];
        
        int value = (arc4random() % 5) + 1;
        self._spriteBatch = [CCSpriteBatchNode batchNodeWithFile:
                             [NSString stringWithFormat:@"enemy%d.png", value]];
        [layer addChild:self._spriteBatch];
        
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
        for(int i =1; i <=6; ++i) {
            [walkAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"e%d_%d.png", value, i]]];
        }
        CCAnimation *walkAnim = [CCAnimation
                                 animationWithSpriteFrames:walkAnimFrames delay:0.1f];
        self._sprite = [CCSprite spriteWithSpriteFrameName:
                        [NSString stringWithFormat:@"e%d_1.png", value]];
        //*position
        //[self._sprite setPosition:ccp(self._sprite.contentSize.width/2, self.WindowSize.height/2)];
        [self initialSprite];
        self._moveAction = [CCRepeatForever actionWithAction:
                            [CCAnimate actionWithAnimation:walkAnim]];
        [self._sprite runAction:self._moveAction];
        [self._spriteBatch addChild:self._sprite];
        
        //* straight line or Bezier Spline
        value = (arc4random() % 2) + 1;
        if (value == 1) {
            [self actionWithArray:array andLayer:layer];
        } else {
            [self actionInBezier:array andLayer:layer];
        }
        
    }
    return self;
}

- (void)initialSprite
{
    //self._sprite = [[CCSprite alloc] initWithFile:@"monster.png"];
    int minY = self._sprite.contentSize.height / 2;
    int maxY = self.WindowSize.height - self._sprite.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    [self._sprite setPosition:ccp(self.WindowSize.width - self._sprite.contentSize.width/2, actualY)];
}

- (void)actionInBezier:(NSMutableArray *)array andLayer:(HelloWorldLayer *)layer
{
    int maxX = self.WindowSize.width - self._sprite.contentSize.width/2;
    int minX = self._sprite.contentSize.width/2;
    int actualX1 = maxX;
    int actualX2 = (maxX-minX)*3/4 + minX;
    int actualX3 = (maxX-minX)*2/4 + minX;
    int actualX4 = (maxX-minX)/4 + minX;
    int actualX5 = minX;
    int minY = self._sprite.contentSize.height / 2;
    int maxY = self.WindowSize.height - self._sprite.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY1 = (arc4random() % rangeY) + minY;
    int actualY2 = (arc4random() % rangeY) + minY;
    int actualY3 = (arc4random() % rangeY) + minY;
    int actualY4 = (arc4random() % rangeY) + minY;
    int actualY5 = (arc4random() % rangeY) + minY;
    //
    ccBezierConfig bezier1;
    bezier1.controlPoint_1 = ccp(actualX1, actualY1);
    bezier1.controlPoint_2 = ccp(actualX2, actualY2);
    bezier1.endPosition = ccp(actualX3, actualY3);
    id bezierForward1 = [CCBezierTo actionWithDuration:3 bezier:bezier1];
    
    ccBezierConfig bezier2;
    bezier2.controlPoint_1 = ccp(actualX3, actualY3);
    bezier2.controlPoint_2 = ccp(actualX4, actualY4);
    bezier2.endPosition = ccp(actualX5, actualY5);
    id bezierForward2 = [CCBezierTo actionWithDuration:3 bezier:bezier2];
    
    CCCallBlockN *actionMoveDone = [CCCallBlockN actionWithBlock: ^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
        [array removeObject:self];
    }];
    CCAction *sequence = [CCSequence actions:bezierForward1, bezierForward2, actionMoveDone, nil];
    sequence.tag = 1;
    [self._sprite runAction:sequence];
    //[layer addChild:self._sprite];
    [array addObject:self];
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
    //[layer addChild:self._sprite];
    [array addObject:self];
}

- (void)blink:(NSMutableArray *)array
{
    //ccColor3B oldColor = self._sprite.color;
    //id tintAction
    //id tintBack = [CCTintTo actionWithDuration:0.5 red:oldColor.r green:oldColor.g blue:oldColor.b];
    //[self._sprite stopAllActions];
    //id oldAction = [self._sprite getActionByTag:1];
    CCAction *blinkAction = [CCBlink actionWithDuration:0.2 blinks:1];
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

- (void)update:(HelloWorldLayer *)layer fireObject:(CGPoint)player projectiles:(NSMutableArray *)projectiles
{
    //*main loop of the player
    //NSLog(@"%d", self._shootCountDown);
    if (self._shootCountDown == 1) {
        SDBullet *bullet = [[SDBullet alloc] initWithPosition:self._sprite.position andDestination:player andArray:projectiles];
        [layer addChild:bullet._sprite];
        [projectiles addObject:bullet];
        self._shootCountDown = self.FireRecovery;
    } else {
        self._shootCountDown--;
    }
    
}
- (void)dealloc
{
    //[self._sprite release];
    //[self._projectiles release];
    NSLog(@"Dealloc enemy!");
    [super dealloc];
}
@end
