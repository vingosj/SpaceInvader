//
//  SDPlayer.h
//  SpaceInvader
//
//  Created by vingosj on 13-11-5.
//  Copyright (c) 2013年 vingosj. All rights reserved.
//

#import "SDBullet.h"
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"

@class HelloWorldLayer;
@interface SDPlayer : SDEntity


@property (assign) int _level;
@property (assign) float _health;
@property (assign) float _speed;
@property (assign) BOOL _dead;
@property (assign) int _fireRecovery;
@property (assign) int _fireCountDown;
@property (assign) float _power;
@property (readonly) float UpBound;
@property (readonly) float DownBound;
@property (readonly) float LeftBound;
@property (readonly) float RightBound;
@property (nonatomic, strong) CCSpriteBatchNode *_spriteBatch;
@property (assign) NSMutableArray *_projectiles;
@property (nonatomic, retain) CCAction *_moveAction;


- (id)initWithLayer:(HelloWorldLayer *)layer;
- (void)initialSprite;
- (void)move:(CGPoint)direction;
- (void)blink;
- (id)fire:(CGPoint) point andDestination:(CGPoint)dest;
- (void)update:(HelloWorldLayer *)layer;
- (BOOL)shooted:(float) health;
- (void)levelup;
- (void)dealloc;
@end
