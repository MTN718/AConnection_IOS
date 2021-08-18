//
//  Utils.h
//  xiaokeyou
//
//  Created by BoHuang on 3/4/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WNAActivityIndicator.h"

@interface Utils : NSObject

+(UIColor*)colorWithHexString:(NSString*)hex;
+(void) showErrorDialog:(NSString *)msg;
+ (void)addActivityIndicator:(UIView *) parentView;
+ (void)removeActivityIndicator:(UIView *) parentView;
+ (NSString *) getImageUrl:(NSString *) imgUrl;
+ (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font;
+(void) initDiscoverType;
+(NSString *) getDiscoverText:(NSString *) did;
+(NSString *) getDiscoverPropertyText:(NSString *) did;
+(NSString *) getDiscoverTypeText:(NSString *) did;
+(void) setUnderline:(UITextField *) editField;

+(void) addShadow:(UIView *) view:(NSString * ) color;
+(void) addProgress:(int) percent:(UIView *) ownerView;
+(void) setRating:(UIImageView *) imgStar1 :(UIImageView *) imgStar2:(UIImageView *) imgStar3:(UIImageView*) imgStar4:(UIImageView *) imgStar5:(float) rating;


@end
