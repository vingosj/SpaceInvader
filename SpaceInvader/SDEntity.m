//
//  SDEntity.m
//  SpaceInvader
//
//  Created by vingosj on 13-11-5.
//  Copyright (c) 2013年 vingosj. All rights reserved.
//

#import "SDEntity.h"

@implementation SDEntity

- (id)init
{
    if (self = [super init])
    {
        //*base init here
        _WindowSize = [CCDirector sharedDirector].winSize;
    }
    return self;
}

- (void)dealloc
{
    [self._sprite release];
    [super dealloc];
}

@end
