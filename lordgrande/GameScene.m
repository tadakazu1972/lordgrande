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
        self.backgroundColor = [SKColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        
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

/*
- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    // Get label node from scene and store it for use later
    _label = (SKLabelNode *)[self childNodeWithName:@"//helloLabel"];
    
    _label.alpha = 0.0;
    [_label runAction:[SKAction fadeInWithDuration:2.0]];
    
    CGFloat w = (self.size.width + self.size.height) * 0.05;
    
    // Create shape node to use during mouse interaction
    _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w, w) cornerRadius:w * 0.3];
    _spinnyNode.lineWidth = 2.5;
    
    [_spinnyNode runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI duration:1]]];
    [_spinnyNode runAction:[SKAction sequence:@[
                                                [SKAction waitForDuration:0.5],
                                                [SKAction fadeOutWithDuration:0.5],
                                                [SKAction removeFromParent],
                                                ]]];
}


- (void)touchDownAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor greenColor];
    [self addChild:n];
}

- (void)touchMovedToPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor blueColor];
    [self addChild:n];
}

- (void)touchUpAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor redColor];
    [self addChild:n];
}
*/

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
    sMyChara.position = CGPointMake(0.0f, -64.0f);
    sMyChara.zPosition = 1.0f;
    sMyChara.anchorPoint = CGPointMake(0.0f, 1.0f);
    [self addChild:sMyChara];
    //set parameters
    myChara.x = 5*8.0f;
    myChara.y = 5*8.0f;
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
    sMyChara.texture = draw[myChara.i];
    sMyChara.position = CGPointMake(myChara.x, myChara.y);
}

@end
