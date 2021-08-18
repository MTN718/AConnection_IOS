//
//  Globals.m
//  xiaokeyou
//
//  Created by BoHuang on 3/3/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import "Globals.h"



NSMutableArray *g_lstComplete;
WNAActivityIndicator *activityIndicator;
int g_cardNo;
int g_moveCount;

@implementation Globals


+(void) saveUserInfo
{
    NSUserDefaults *preference = [NSUserDefaults standardUserDefaults];
//    if (mAccount.mEmail != nil && ![mAccount.mEmail isKindOfClass:[NSNull class]])
//        [preference setObject:mAccount.mEmail forKey:@"email"];
//    if (mAccount.mPassword != nil && ![mAccount.mPassword isKindOfClass:[NSNull class]])
//        [preference setObject:mAccount.mPassword forKey:@"password"];
//    [preference synchronize];
}
+(void) loadUserInfo
{
    NSUserDefaults *preference = [NSUserDefaults standardUserDefaults];
//    mAccount = [[UserModel alloc] init];
//    mAccount.mEmail = [preference objectForKey:@"email"];
//    if (mAccount.mEmail == nil)
//        mAccount.mEmail = @"";
//    mAccount.mPassword = [preference objectForKey:@"password"];
//    if (mAccount.mPassword == nil)
//        mAccount.mPassword = @"";
    
}


@end
