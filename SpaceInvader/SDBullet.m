//
//  SDBullet.m
//  SpaceInvader
//
//  Created by vingosj on 13-11-6.
//  Copyright (c) 2013年 vingosj. All rights reserved.
//

#import "SDBullet.h"

@implementation SDBullet

- (id)initWithPosition:(CGPoint)point
              andArray:(NSMutableArray *)array
{
    if (self = [super init]) {
        self._power = 1;
        self._speed = 60;
        
        [self initialSpriteWithPosition:point];
        [self action:array];
    }
    return self;
}

- (id)initWithPosition:(CGPoint)point andDestination:(CGPoint)dest
              andArray:(NSMutableArray *)array
{
    if (self = [super init])
    {
        self._power = 1;
        self._speed = 40;
        
        [self initialSpriteWithPosition:point];
        [self action:ccpSub(point, dest) andArray:array];
    }
    return self;
}

- (void)initialSpriteWithPosition:(CGPoint)point
{
    //*initial the sprite of bullet
    self._sprite = [[CCSprite alloc] initWithFile:@"projectile.png"];
    [self._sprite setPosition:point];
}

- (void)action:(NSMutableArray *)array
{
    CGPoint realDest = ccp(self.WindowSize.width + self._sprite.contentSize.width/2,
                           self._sprite.position.y);
    float moveDuration = (realDest.x - self._sprite.position.x)/self._speed;
    [self._sprite runAction:
     [CCSequence actions:
      [CCMoveTo actionWithDuration:moveDuration position:realDest],
      [CCCallBlockN actionWithBlock:^(CCNode *node) {
         [node removeFromParentAndCleanup:YES];
         [array removeObject:self];
     }],
      nil]];
}

- (void)action:(CGPoint)offset andArray:(NSMutableArray *)array
{
    CGPoint realDest;
    float moveDuration;
    //NSLog(@"%f", fabs(offset.x/offset.y));
    float radius = sqrtf(self.WindowSize.width*self.WindowSize.width + self.WindowSize.height*self.WindowSize.height);
    moveDuration = radius/self._speed;
    float z = sqrtf(offset.x*offset.x+offset.y*offset.y);
    float realX = self._sprite.position.x - radius*offset.x/z;
    float realY = self._sprite.position.y - radius*offset.y/z;
    realDest = ccp(realX, realY);
    /*if (abs(offset.x/offset.y) >= )
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
     //if (offset.y < 0)
     //    realY = 0;
     realY = 0;
     float ratio = (float) offset.x / (float) offset.y;
     int realX = (realY * ratio) + self._sprite.position.x;
     realDest = ccp(realX, realY);
     
     // Determine the length of how far you're shooting
     int offRealX = realX - self._sprite.position.x;
     int offRealY = realY - self._sprite.position.y;
     float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
     moveDuration = length/self._speed;
     }*/
    
    [self._sprite runAction:
     [CCSequence actions:
      [CCMoveTo actionWithDuration:moveDuration position:realDest],
      [CCCallBlockN actionWithBlock:^(CCNode *node) {
         [node removeFromParentAndCleanup:YES];
         [array removeObject:self];
     }],
      nil]];
    [self._sprite runAction:
     [CCSequence actions:
      [CCRotateTo actionWithDuration:moveDuration angle:1800*self._power],
      [CCCallBlockN actionWithBlock:^(CCNode *node) {
         [node removeFromParentAndCleanup:YES];
         [array removeObject:self];
     }],
      nil]];
}

- (void)dealloc
{
    NSLog(@"release bullet");
    [super dealloc];
}
@end
