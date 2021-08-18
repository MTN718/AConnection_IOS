//
//  CompletedViewController.h
//  Angle Connection
//
//  Created by my on 2020/7/1.
//  Copyright © 2020 my. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompletedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblCase;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@end

NS_ASSUME_NONNULL_END
