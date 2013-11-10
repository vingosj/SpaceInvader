//
//  SDBullet.m
//  SpaceInvader
//
//  Created by vingosj on 13-11-6.
//  Copyright (c) 2013年 vingosj. All rights reserved.
//

#import "SDBullet.h"

@implementation SDBullet

- (id)initWithPosition:(CGPoint)point andDestination:(CGPoint)dest
{
    if (self = [super init])
    {
        self._power = 1;
        self._speed = 40;
        
        [self initialSpriteWithPosition:point];
        [self action:ccpSub(point, dest)];
    }
    return self;
}

- (void)initialSpriteWithPosition:(CGPoint)point
{
    //*initial the sprite of bullet
    self._sprite = [[CCSprite alloc] initWithFile:@"projectile.png"];
    [self._sprite setPosition:point];
}

- (void)action:(CGPoint)offset
{
    CGPoint realDest;
    float moveDuration;
    if (abs(offset.x/offset.y) >= 0.577)
    {
        int realX = self.WindowSize.width + (self._sprite.contentSize.width/2);
        float ratio = (float) offset.y / (float) offset.x;
        int realY = (realX * ratio) + self._sprite.position.y;
        realDest = ccp(realX, realY);
    
        // Determine the length of how far you're shooting
        int offRealX = realX - self._sprite.position.x;
        int offRealY = realY - self._sprite.position.y;
        float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
        moveDuration = length/self._speed;
    }
    else
    {
        //
        int realY = self.WindowSize.height + (self._sprite.contentSize.height/2);
        float ratio = (float) offset.x / (float) offset.y;
        int realX = (realY * ratio) + self._sprite.position.x;
        realDest = ccp(realX, realY);
        
        // Determine the length of how far you're shooting
        int offRealX = realX - self._sprite.position.x;
        int offRealY = realY - self._sprite.position.y;
        float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
        moveDuration = length/self._speed;
    }
    
    [self._sprite runAction:
     [CCSequence actions:
      [CCMoveTo actionWithDuration:moveDuration position:realDest],
      [CCCallBlockN actionWithBlock:^(CCNode *node) {
         [node removeFromParentAndCleanup:YES];
    }],
      nil]];
}

@end
