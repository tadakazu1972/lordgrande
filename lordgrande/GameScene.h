//
//  GameScene.h
//  lordgrande
//
//  Created by 中道 忠和 on 2018/11/08.
//  Copyright © 2018年 Tadakazu Nakamichi. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#define MAXSTAGE 1
#define MX 20  // map max X
#define MY 20  // map max Y

@interface GameScene : SKScene {
    int WIDTH;
    int HEIGHT;
    CGContextRef context;
    NSMutableArray* draw;
    
    CGPoint lastPoint;
    float tx; // touch point x
    float ty; // touch point y
    int touch_direction; // 0:stop 1:up 2:right 3:down 4:left
    
    int gs;
    
    struct player {
        float x;
        float y;
        float wx;
        float wy;
        float vx;
        float vy;
        float l;
        float r;
        float t;
        float b;
        int   i; // png index
        int   counter; // animation counter
    };
    struct player myChara;
    SKSpriteNode *sMyChara;
    
    int stage;
    uint32_t MAP[MAXSTAGE][MY][MX];
    SKSpriteNode *smap[MY][MX];
    SKSpriteNode *sbg;
    float mapx;
    float mapy;
    
}

@end
