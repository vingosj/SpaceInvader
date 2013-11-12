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

- (id)initWithArray:(NSMutableArray *)array
{
    if (self = [super init])
    {
        //*init the enemy staff here
        _FireRecovery = 8;
        self._health = 5;
        self._shootCountDown = self.FireRecovery;
        
        [self initialSprite];
        [self actionWithArray:array];
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

- (void)actionWithArray:(NSMutableArray *)array
{
    CCMoveTo *actionMove = [CCMoveTo actionWithDuration:4
                                               position:ccp(-self._sprite.contentSize.width/2, self._sprite.position.y)];
    CCCallBlockN *actionMoveDone = [CCCallBlockN actionWithBlock: ^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
        [array removeObject:self];
    }];
    [self._sprite runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}

- (void)render
{
    //*enemy render here
}

- (void)update
{
    //*enemy update here
}

- (void)dealloc
{
    NSLog(@"Dealloc enemy!");
    [super dealloc];
}
@end
