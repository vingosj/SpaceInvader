//
//  GameOverLayer.m
//  SpaceInvader
//
//  Created by vingosj on 13-11-10.
//  Copyright (c) 2013年 vingosj. All rights reserved.
//

#import "GameOverLayer.h"
#import "HelloWorldLayer.h"

@implementation GameOverLayer

+ (CCScene *)sceneWithWon:(BOOL)won {
    CCScene *scene = [CCScene node];
    GameOverLayer *layer = [[[GameOverLayer alloc] initWithWon:won] autorelease];
    [scene addChild:layer];
    return scene;
}

- (id)initWithWon:(BOOL)won {
    if(self = [super initWithColor:ccc4(255, 255, 255, 255)]) {
        NSString *message;
        if (won) {
            message = @"You won!";
        } else {
            message = @"You lose :[";
        }
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCLabelTTF * label = [CCLabelTTF labelWithString:message fontName:@"Arial" fontSize:32];
        label.color = ccc3(0,0,0);
        label.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:label];
        
        [self runAction:
         [CCSequence actions:
          [CCDelayTime actionWithDuration:3],
          [CCCallBlockN actionWithBlock:^(CCNode *node) {
             [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
         }],
          nil]];
    }
    return self;
}

@end
