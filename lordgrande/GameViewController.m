//
//  GameViewController.m
//  lordgrande
//
//  Created by 中道 忠和 on 2018/11/08.
//  Copyright © 2018年 Tadakazu Nakamichi. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    SKView *skView = (SKView *)self.view;
    
    //set the view only once, if the device orientation is
    //rotating viewWillLayoutSubviews will be called again
    if (!skView.scene)
    {
        skView.showsFPS = NO;
        skView.showsNodeCount = NO;
        /* Sprite Kit applies additional optimizations to improve rendering perfomance */
        skView.ignoresSiblingOrder = YES;
        
        CGSize gameSize;
        gameSize.width = 320;
        if (skView.frame.size.height>240){
            //iPhone5~
            gameSize.height = 568;
        } else {
            //iPhone4s
            gameSize.height = 480;
        }
        
        GameScene *scene = [GameScene sceneWithSize:gameSize];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene
        [skView presentScene:scene];
    }
}

/*- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
}
*/

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
