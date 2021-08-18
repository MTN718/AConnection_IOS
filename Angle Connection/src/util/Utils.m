//
//  Utils.m
//  xiaokeyou
//
//  Created by BoHuang on 3/4/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import "Utils.h"
#import "Globals.h"
#import "Config.h"
#import <MapKit/MapKit.h>

@implementation Utils






+(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+(void) showErrorDialog:(NSString *)msg
{
    UIAlertView *errDlg = [[UIAlertView alloc] initWithTitle:msg message:@""delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [errDlg show];
}
+ (void)addActivityIndicator  :(UIView *) parentView
{
    if (activityIndicator == nil) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        activityIndicator = [[WNAActivityIndicator alloc] initWithFrame:screenRect];
        [activityIndicator setHidden:NO];
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    if (![activityIndicator isDescendantOfView:parentView]) {
        [parentView addSubview:activityIndicator];
    }
}
+ (void)removeActivityIndicator :(UIView *) parentView
{
    [activityIndicator setHidden:YES];
    [activityIndicator removeFromSuperview];
    activityIndicator = nil;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
+ (NSString *)getImageUrl:(NSString *) imgUrl;
{
    if ([imgUrl hasPrefix:@"https://graph.facebook.com/"])
        return imgUrl;
    NSString *url = [c_imageBaseUrl stringByAppendingString:imgUrl];
    return url;
}
+ (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    CGFloat result = font.pointSize + 4;
    if (text)
    {
        CGSize textSize = { widthValue, CGFLOAT_MAX };       //Width and height of text area
        CGSize size;
        CGRect frame = [text boundingRectWithSize:textSize
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{ NSFontAttributeName:font }
                                          context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height+1);
        result = MAX(size.height, result); //At least one row
    }
    return result;
}
+(void) setUnderline:(UITextField *) editField
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(editField.frame.origin.x, editField.frame.size.height - borderWidth, editField.frame.size.width, editField.frame.size.height);
    border.borderWidth = borderWidth;
    [editField.layer addSublayer:border];
    editField.layer.masksToBounds = YES;
    
}

+(void) addProgress:(int) percent:(UIView *) ownerView
{
    float width = ownerView.frame.size.width  / 100.0f * percent;
    UIView *percentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, ownerView.frame.size.height)];
    percentView.backgroundColor = [Utils colorWithHexString:@"BCFF79"];
    [ownerView addSubview:percentView];
    
}

+(void) addShadow:(UIView *) view:(NSString * ) color
{
    view.layer.shadowColor = [[Utils colorWithHexString:color] CGColor];
    view.layer.shadowOffset = CGSizeMake(2, 2);
    view.layer.shadowOpacity = 0.16f;
    view.layer.shadowRadius = 1.0;
}
+(void) setRating:(UIImageView *) imgStar1 :(UIImageView *) imgStar2:(UIImageView *) imgStar3:(UIImageView*) imgStar4:(UIImageView *) imgStar5:(float) rating
{
    [imgStar1 setImage:[UIImage imageNamed:@"ic_star_empty.png"]];
    [imgStar2 setImage:[UIImage imageNamed:@"ic_star_empty.png"]];
    [imgStar3 setImage:[UIImage imageNamed:@"ic_star_empty.png"]];
    [imgStar4 setImage:[UIImage imageNamed:@"ic_star_empty.png"]];
    [imgStar5 setImage:[UIImage imageNamed:@"ic_star_empty.png"]];
    
    if (rating >= 1 && rating < 2)
    {
        [imgStar1 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
    }
    else if (rating >= 2 && rating < 3)
    {
        [imgStar1 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
        [imgStar2 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
    }
    else if (rating >= 3 && rating < 4)
    {
        [imgStar1 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
        [imgStar2 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
        [imgStar3 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
    }
    else if (rating >= 4 && rating < 4.7)
    {
        [imgStar1 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
        [imgStar2 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
        [imgStar3 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
        [imgStar4 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
    }
    else if (rating >= 4.7 && rating < 5)
    {
        [imgStar1 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
        [imgStar2 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
        [imgStar3 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
        [imgStar4 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
        [imgStar5 setImage:[UIImage imageNamed:@"ic_star_full.png"]];
    }
    
    
}
@end
