//
//  SDBullet.h
//  SpaceInvader
//
//  Created by vingosj on 13-11-6.
//  Copyright (c) 2013年 vingosj. All rights reserved.
//

#import "SDEntity.h"

@interface SDBullet : SDEntity

@property (assign) float _speed;
@property (assign) float _power;

- (id)initWithPosition:(CGPoint) point andDestination:(CGPoint)dest;

@end
