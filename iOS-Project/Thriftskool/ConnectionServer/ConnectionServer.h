//
//  ConnectionServer.h
//  webServiceTesting
//
//  Created by Asha on 10/03/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^ ResponseBlock)(NSDictionary*);

@protocol ConnectionDelegate <NSObject>

- (void)ConnectionDidFinish: (NSString*)nState Data: (NSString*)nData statuscode:(NSInteger )strstatuscode;
- (void)ConnectionDidFail:(NSString*)nState Data: (NSString*)nData;

@end

@interface ConnectionServer : NSObject<NSURLSessionDataDelegate,NSURLSessionTaskDelegate>
{
@private
    id<ConnectionDelegate> connectionDelegate;
    NSMutableData *dataWebService;
}
@property (nonatomic, strong) id connectionDelegate;
@property (nonatomic, retain) NSString *serviceName;

+ (ConnectionServer*)sharedConnectionWithDelegate:(id)delegate;
//-(void)GetStartUp:(NSDictionary*)dic caseName:(NSString*)strCase withToken:(BOOL)checkToken;
-(void)GetStartUp:(id)dic caseName:(NSString*)strCase withToken:(BOOL)checkToken;
-(void)GetStartUpBlock:(id)dic caseName:(NSString*)strCase onSuccess:(ResponseBlock)onSuccess onFailure:(ResponseBlock)onFailure;

-(void)getDataWithPUTRequest:(NSDictionary*)dataDict caseName:(NSString*)strCase;
-(void)getDataFromServer:(NSString*)strCase;
-(void)getDataforGroupStates:(NSString*)strCase;
-(void)getDataforGroupDetailStates:(NSString*)strCase;
-(void) setParams :(NSData*)imageData2 caseName:(NSString*)strCase2;
-(void)getCaloriesDataFromServer:(NSString*)strCase qu:(NSOperationQueue*)opQueue stT:(NSString*)token;


@end
