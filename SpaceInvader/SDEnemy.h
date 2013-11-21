//
//  SDEnemy.h
//  SpaceInvader
//
//  Created by vingosj on 13-11-6.
//  Copyright (c) 2013年 vingosj. All rights reserved.
//


#import "HelloWorldLayer.h"


@class HelloWorldLayer;
@interface SDEnemy : SDEntity

@property (assign) float _health;
@property (assign) int _shootCountDown;
@property (readonly) int FireRecovery;
@property (readonly) float Crash;
@property (assign) float _power;
//@property (assign) NSMutableArray *_projectiles;
@property (nonatomic, strong) CCSpriteBatchNode *_spriteBatch;
@property (nonatomic, retain) CCAction *_moveAction;

- (id)initWithArray:(NSMutableArray *)array andLayer:(HelloWorldLayer *)layer;
- (void)initialSprite;
- (void)actionWithArray:(NSMutableArray *)array andLayer:(HelloWorldLayer *)layer;
- (void)blink:(NSMutableArray *)array;
- (void)shooted:(HelloWorldLayer *)layer andArray:(NSMutableArray *)array;
- (void)hurt:(float)power;
- (void)render;
- (void)explosion:(HelloWorldLayer *)layer;
- (void)update:(HelloWorldLayer *)layer fireObject:(CGPoint)player
   projectiles:(NSMutableArray *)projectiles;
- (void)dealloc;


@end
