//
//  GameViewController.h
//  Angle Connection
//
//  Created by my on 2020/6/30.
//  Copyright © 2020 my. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblMoves;
@property (weak, nonatomic) IBOutlet UIButton *btnCompleted;
@property (weak, nonatomic) IBOutlet UIView *vwMain;
@property (weak, nonatomic) IBOutlet UIImageView *imgAngle;
@property (weak, nonatomic) IBOutlet UIView *vwButtons;
@property (weak, nonatomic) IBOutlet UIButton *btnRefresh;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csMain;

@property (strong, nonatomic) NSMutableArray *gameCurrent;
@property (strong, nonatomic) NSMutableArray *gameButtons;
@property (strong, nonatomic) NSDictionary *gameMatchcase;
@property (strong, nonatomic) NSArray *gameCase;
@property (strong, nonatomic) NSMutableArray *gameSelections;

@property float centerX1,centerY1,centerX2,centerY2,radius;
@property bool isClicklock;
@property int selectCount;

@end

NS_ASSUME_NONNULL_END
