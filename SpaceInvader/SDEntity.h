//
//  SDEntity.h
//  SpaceInvader
//
//  Created by vingosj on 13-11-5.
//  Copyright (c) 2013年 vingosj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SDEntity : NSObject

@property (nonatomic, strong) CCSprite *_sprite;
@property (readonly) CGSize WindowSize;

- (id)init;
- (void)dealloc;

@end
