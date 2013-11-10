//
//  SDPlayer.h
//  SpaceInvader
//
//  Created by vingosj on 13-11-5.
//  Copyright (c) 2013年 vingosj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDEntity.h"

@interface SDPlayer : SDEntity

@property (assign) float _health;
@property (assign) float _speed;
@property (assign) BOOL _dead;
@property (assign) float _fireRecovery;
@property (assign) float _power;

- (id)init;
- (void)initialSprite;
- (void)move;
- (void)fire;
- (void)update;
@end
