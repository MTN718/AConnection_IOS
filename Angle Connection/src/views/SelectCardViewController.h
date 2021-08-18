//
//  SelectCardViewController.h
//  Angle Connection
//
//  Created by my on 2020/6/30.
//  Copyright © 2020 my. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectCardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnCard5;
@property (weak, nonatomic) IBOutlet UIButton *btnCard6;
@property (weak, nonatomic) IBOutlet UIButton *btnCard7;
@property (weak, nonatomic) IBOutlet UIButton *btnCard8;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;


@property int currentCard;

@end

NS_ASSUME_NONNULL_END
