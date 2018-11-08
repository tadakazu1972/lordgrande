//
//  GameScene.m
//  lordgrande
//
//  Created by 中道 忠和 on 2018/11/08.
//  Copyright © 2018年 Tadakazu Nakamichi. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        
        [self initParams];
        [self loadImages];
        [self setMyChara];
        //[self setMap];
        
        //prepare timer
        [NSTimer scheduledTimerWithTimeInterval:0.03f target:self selector:@selector(animation:) userInfo:nil repeats:YES];
    }
    return self;
}

// main loop ****************************************
-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
    //title
    if(gs==0){
        
    } else if (gs==1){
        //[self drawMap]
        [self drawMyChara];
    }
}


// animation counter
-(void)animation:(NSTimer*)timer {
    myChara.counter++;
    if (myChara.counter>19) {
        if ( myChara.i == 0 ) {
            myChara.i = 1;
        } else {
            myChara.i = 0;
        }
        myChara.counter = 0;
    }
}

// touches ******************************************
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (gs==0){
        //
        gs=1;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    // タッチした座標を取得
    CGPoint pt=[[touches anyObject] locationInNode:self];
    
    // タッチ操作量はX方向とY方向のどちらが多いか絶対値で比較する(lastPointとpの座標を取得する構造がゆえに）
    float temp_vx, temp_vy;
    temp_vx=fabs(lastPoint.x-pt.x);
    temp_vy=fabs(lastPoint.y-pt.y);
    
    if (temp_vx > temp_vy) {
        if (lastPoint.x-pt.x<0) {
            touch_direction=2;
        } else {
            touch_direction=4;
        }
    } else {
        if (lastPoint.y-pt.y<0) {
            touch_direction=1;
        } else {
            touch_direction=3;
        }
    }
    //　ステージセレクト用タッチ座標の保存
    tx=lastPoint.x;
    ty=lastPoint.y;
    
    //　さっき取得したタッチの座標をラストポイントに書き換えておく。
    lastPoint = pt;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    /* nothing */
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

// init parameters *****************************************
-(void)initParams {
    //game status
    gs = 1;
}

// load images *********************************************
-(void)loadImages {
    draw = [NSMutableArray array];
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"LordGrande"];
    [ draw addObject:[atlas textureNamed:@"lord01.png"]]; //0
    [ draw addObject:[atlas textureNamed:@"lord02.png"]]; //1
}

// MyChara **************************************************
-(void)setMyChara {
    // set sprite
    sMyChara = [SKSpriteNode spriteNodeWithTexture:draw[0]];
    sMyChara.texture.filteringMode = SKTextureFilteringNearest; //拡大時ぼやけるのを防止
    sMyChara.xScale = 2.0;
    sMyChara.yScale = 2.0;
    sMyChara.position = CGPointMake(0.0f, -64.0f);
    sMyChara.zPosition = 1.0f;
    sMyChara.anchorPoint = CGPointMake(0.0f, 1.0f);
    [self addChild:sMyChara];
    //set parameters
    myChara.x = 10 * 8.0f;
    myChara.y = self.size.height - 10 * 8.0f;
    myChara.wx = myChara.x + 10 * 8.0f;
    myChara.wy = 10 * 8.0f;
    myChara.vx = 0.0f;
    myChara.vy = 0.0f;
    myChara.l = myChara.x;
    myChara.r = myChara.x + 7.0f;
    myChara.t = myChara.y;
    myChara.b = myChara.y - 31.0f;
    myChara.i = 0;
    myChara.counter = 0;
}

-(void)drawMyChara {
    //描画
    sMyChara.texture = draw[myChara.i];
    sMyChara.position = CGPointMake(myChara.x, myChara.y);
    //移動量タッチ判定
    switch (touch_direction){
        case 1:
            myChara.vx = 0.0f;
            myChara.vy = 1.0f;
            break;
        case 2:
            myChara.vx = 1.0f;
            myChara.vy = 0.0f;
            break;
        case 3:
            myChara.vx = 0.0f;
            myChara.vy = -1.0f;
            break;
        case 4:
            myChara.vx = -1.0f;
            myChara.vy = 0.0f;
            break;
    }
    //カベ判定
    //ワールド座標変更
    //画像座標変更
    myChara.x = myChara.x + myChara.vx;
    myChara.y = myChara.y + myChara.vy;
}

@end

