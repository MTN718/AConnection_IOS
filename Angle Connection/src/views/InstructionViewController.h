//
//  InstructionViewController.h
//  Angle Connection
//
//  Created by my on 2020/6/30.
//  Copyright © 2020 my. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InstructionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UIImageView *imgScreenshot;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property int currentPage;
@end

NS_ASSUME_NONNULL_END
