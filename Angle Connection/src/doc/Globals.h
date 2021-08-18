//
//  Globals.h
//  xiaokeyou
//
//  Created by BoHuang on 3/3/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WNAActivityIndicator.h"



extern NSMutableArray *g_lstComplete;
extern WNAActivityIndicator *activityIndicator;
extern int g_cardNo;
extern int g_moveCount;

@interface Globals : NSObject


+(void) saveUserInfo;
+(void) loadUserInfo;


@end
