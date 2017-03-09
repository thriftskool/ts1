//
//  GlobalMethod.m
//  Cubie
//
//  Created by Harshil on 02/03/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "GlobalMethod.h"
#import <SystemConfiguration/SystemConfiguration.h>

static GlobalMethod *shareMethod = nil;
@implementation GlobalMethod
@synthesize strUserName,userID,notificationCount;


+(GlobalMethod*) shareGlobalMethod
{
    
//    if(!shareMethod){
//        shareMethod = [[GlobalMethod alloc] init];
//    }
//    
//    return shareMethod;
    
    static GlobalMethod *shareMethod = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareMethod = [[GlobalMethod alloc] init];
       
    });
    return shareMethod;
    
}

-(void) afterUserSet {
    if ([ self userID]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue: [NSString stringWithFormat:@"%d",[self userID]] forKey:@"user_id"];
        
        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUpBlock:dict caseName:@"notification" onSuccess:^(NSDictionary * data) {
            NSArray *extracted = [data valueForKey:@"Result_message"];
            NSInteger count = [extracted count];
            [UIApplication sharedApplication].applicationIconBadgeNumber = count;
        } onFailure:^(NSDictionary * data) {
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }];
    }
}


//MARK:- Internet Availability Method
-(BOOL) connectedToNetwork
{
    const char *host_name = "www.google.com";
    BOOL _isDataSourceAvailable = NO;
    Boolean success;
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL,host_name);
    SCNetworkReachabilityFlags flags;
    success = SCNetworkReachabilityGetFlags(reachability, &flags);
    _isDataSourceAvailable = success &&
    (flags & kSCNetworkFlagsReachable) &&
    !(flags & kSCNetworkFlagsConnectionRequired);
    
    CFRelease(reachability);
    return _isDataSourceAvailable;
}

-(NSString*)getUserID
{
    UIDevice *device = [UIDevice currentDevice];

    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    return currentDeviceId;
}


#pragma mark -
- (NSString*)DateDisplayInCell1:(NSString*)strDate
{
    //current Date -------------
    NSDate *startDate = [NSDate date];
    NSUInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSCalendar *calendar123 = [[NSCalendar alloc] initWithCalendarIdentifier:currentCalendar.calendarIdentifier];
//    calendar123.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents* components123 = [calendar123 components:flags fromDate:startDate];
    startDate = [calendar123 dateFromComponents:components123];
    
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"dd-LLL-yy";
    
    
    //End Date -------------
    
    
    NSDateFormatter *dateformate= [[NSDateFormatter alloc]init];
//    [dateformate setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateformate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *endDate =  [dateformate dateFromString:strDate];
    
    if (endDate == nil) {
        [dateformate setDateFormat:@"yyyy-MM-dd"];
        endDate =  [dateformate dateFromString:strDate];
    }
    if (endDate == nil) {
        [dateformate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        endDate =  [dateformate dateFromString:strDate];
    }

    
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    format1.dateFormat = @"dd-LLL-yyyy";
    NSLog(@"%@", [format1 stringFromDate:endDate]);
    
    
    NSDateComponents *components;
    NSInteger days;
    
    components = [[NSCalendar currentCalendar] components: NSDayCalendarUnit
                                                 fromDate: startDate toDate: endDate options: 0];
    days = [components day];
    
    
    NSString *str;
    if (days < 0) {
        str = @"Expired";
    }
    else if (days == 0)
    {
        str = @"Expires Today";
    }
    else if (days == 1)
    {
        str = [NSString stringWithFormat:@"Expires in %ld Day",(long)days];
    }
    else
    {
    str = [NSString stringWithFormat:@"Expires in %ld Days",(long)days];
    }
    return str;
    
    
}

- (NSString*)DateDisplayWithMonthName:(NSString*)strDate firstMonth:(BOOL)monthNameFirst
{
    
    
    NSDateFormatter *dateformate= [[NSDateFormatter alloc]init];
//    [dateformate setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];// change date
    [dateformate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];

    NSDate *endDate =  [dateformate dateFromString:strDate];
    
    if (endDate == nil) {
        [dateformate setDateFormat:@"yyyy-MM-dd"];
        endDate =  [dateformate dateFromString:strDate];
    }
    if (endDate == nil)
    {
        [dateformate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        endDate =  [dateformate dateFromString:strDate];


    }
    
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
//    if (monthNameFirst == YES)
    {
         format1.dateFormat = @"LLLL dd, yyyy";
    }
//    else
//    {
//    format1.dateFormat = @"dd LLLL yy,";
//    }
    
    NSDateComponents *components;
    NSInteger days;
    
    components = [[NSCalendar currentCalendar] components: NSDayCalendarUnit
                                                 fromDate: [NSDate date] toDate: endDate options: 0];
    days = [components day];


    NSString *str;
    str = [format1 stringFromDate:endDate];
    str =  [str stringByReplacingOccurrencesOfString:@"*" withString:[self suffixForDayInDate:endDate]];
    
    NSLog(@"str %@",str);
    return str;
    
    
}

-(NSString*)ExpiredDateDisplayWithMonthName:(NSString*)strDate
{
    
    
    NSDateFormatter *dateformate= [[NSDateFormatter alloc]init];
//    [dateformate setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateformate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *endDate =  [dateformate dateFromString:strDate];
    
    if (endDate == nil) {
        [dateformate setDateFormat:@"yyyy-MM-dd"];
        endDate =  [dateformate dateFromString:strDate];
    }
    
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    format1.dateFormat = @"LLLL dd, yyyy";
    
    NSDateComponents *components;
    NSInteger days;
    
    components = [[NSCalendar currentCalendar] components: NSDayCalendarUnit
                                                 fromDate: [NSDate date] toDate: endDate options: 0];
    days = [components day];
    
    NSString *str;

    if (days<0) {
        str = @"Expired";
    }
    else{
    str = [format1 stringFromDate:endDate];
    }
    
    NSLog(@"str %@",str);
    return str;
    
    
}
- (NSString *)suffixForDayInDate:(NSDate *)date
{
    NSInteger day = [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSDayCalendarUnit fromDate:date] day];
    if (day >= 11 && day <= 13) {
        return @"th";
    } else if (day % 10 == 1) {
        return @"st";
    } else if (day % 10 == 2) {
        return @"nd";
    } else if (day % 10 == 3) {
        return @"rd";
    } else {
        return @"th";
    }
}


-(void)displayNoconnectionLabel:(UIView*)Addview
{
    
    //        self.navigationController.navigationBar.hidden = YES;
    //        self.tabBarController.tabBar.hidden = YES;
    
    if (!imageview) {
        imageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    }
    else
    {
        imageview.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        
    }
    imageview.image = [UIImage imageNamed:@"bg.png"];
    [Addview addSubview:imageview];
    
    if (!lblnetwork) {
        lblnetwork = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, screenWidth-20, 60)];
        
    }
    else{
        lblnetwork.frame = CGRectMake(10, 20, screenWidth-20, 60);
    }
    lblnetwork.text = @"Your device is not connected with Internet. Please check your device Internet settings.";
    lblnetwork.numberOfLines = lblnetwork.frame.size.height/lblnetwork.font.lineHeight;
    lblnetwork.font = FontRegular14;
    lblnetwork.textColor = [UIColor whiteColor];
    lblnetwork.textAlignment = NSTextAlignmentCenter;
    [Addview addSubview:lblnetwork];
    
    if (!tryAgain) {
        tryAgain = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/2-50, 100, 100, 30)];
        
    }
    else{
        tryAgain.frame = CGRectMake(screenWidth/2-50, 100, 100, 30);
    }
    [tryAgain setTitle:@"Try Again" forState:UIControlStateNormal];
    tryAgain.layer.cornerRadius = 6.0;
    tryAgain.layer.borderWidth = 1.0;
    tryAgain.layer.borderColor = [UIColor whiteColor].CGColor;
    tryAgain.titleLabel.font = FontRegular16;
    [Addview addSubview:tryAgain];
    
}



@end
