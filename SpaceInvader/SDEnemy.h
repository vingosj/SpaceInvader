//
//  SDEnemy.h
//  SpaceInvader
//
//  Created by vingosj on 13-11-6.
//  Copyright (c) 2013年 vingosj. All rights reserved.
//

#import "SDEntity.h"

@interface SDEnemy : SDEntity

@property (assign) float _health;
@property (assign) float _shootCountDown;
@property (readonly) int FireRecovery;
@property (assign) float _power;

- (id)initWithArray:(NSMutableArray *)array;
- (void)initialSprite;
- (void)actionWithArray:(NSMutableArray *)array;
- (void)render;
- (void)update;
- (void)dealloc;


@end
