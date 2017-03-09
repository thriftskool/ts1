//
//  ConnectionServer.m
//  webServiceTesting
//
//  Created by Asha on 10/03/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "ConnectionServer.h"
#import <UIKit/UIKit.h>


@implementation ConnectionServer

@synthesize connectionDelegate,serviceName;

static ConnectionServer *sharedConnection = nil;
+ (ConnectionServer*)sharedConnectionWithDelegate:(id)delegate
{
    if(!sharedConnection)
    {
        sharedConnection = [[ConnectionServer alloc] init];
        sharedConnection.serviceName = @"";
    }
    sharedConnection.connectionDelegate = delegate;
    NSLog(@"check for main thread:-%d",[NSThread isMainThread]);
    
    return sharedConnection;
}

-(void)GetStartUp:(id)dic caseName:(NSString*)strCase withToken:(BOOL)checkToken
{
    [self getData:dic caseName:strCase withToken:checkToken];
}

-(void)GetStartUpBlock:(id)dic caseName:(NSString *)strCase onSuccess:(ResponseBlock)onSuccess onFailure:(ResponseBlock)onFailure
{
    NSString *strUrl=[NSString stringWithFormat:@"%@%@",MainURL,strCase];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:strUrl parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: responseObject options:kNilOptions error:nil];
        NSDictionary *response = serializedData[@"Response"];
        
        if ([response[@"status"] integerValue] == 400) {
            onFailure(response);
        } else {
            onSuccess(response);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        onFailure(nil);
    }];
}

- (void)getDataWithPUTRequest:(NSDictionary*)dataDict caseName:(NSString*)strCase
{
    
    ShowNetworkActivityIndicator();
    if([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        NSError *error;
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        NSString *strAuthToken = [[GlobalMethod shareGlobalMethod] getTokenFromProfile];
//        NSString *strToken = [NSString stringWithFormat:@"Token %@",strAuthToken];
//        [configuration setHTTPAdditionalHeaders:@{@"Authorization": strToken}];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        NSString *strUrl=[NSString stringWithFormat:@"%@%@",MainURL,strCase];
        NSURL *url = [NSURL URLWithString:strUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:1000.0];
        
        
        [request setHTTPMethod:@"PUT"];
        
        if(dataDict)
        {
            NSData *postData = [NSJSONSerialization dataWithJSONObject:dataDict options:0 error:&error];
            NSString* postDataLengthString = [[NSString alloc] initWithFormat:@"%ld",(long)[postData length]];
            [request setValue:postDataLengthString forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            //[request addValue:strToken forHTTPHeaderField:@"Authorization"];
         

            [request setHTTPBody:postData];

        }
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request];
       
        
        [postDataTask resume];
    }
    else
    {
        HideNetworkActivityIndicator();
        if ([connectionDelegate respondsToSelector:@selector(ConnectionDidFail:Data:)]) {
            [connectionDelegate ConnectionDidFail:@"Internet connection is not available. Please try again later." Data:nil];
        }
    }
}
-(void)getDataFromServer:(NSString*)strCase
{
    ShowNetworkActivityIndicator();
    if([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
       
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        NSString *strUrl=[NSString stringWithFormat:@"%@%@",MainURL,strCase];
        NSURL *url = [NSURL URLWithString:strUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:1000.0];
        
        
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        
//        NSString *strAuthToken = [[GlobalMethod shareGlobalMethod] getTokenFromProfile];
//        NSString *strToken = [NSString stringWithFormat:@"Token %@",strAuthToken];
//        [request setValue:strToken forHTTPHeaderField:@"Authorization"];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request];
       
        
        [postDataTask resume];
    }
    else
    {
        HideNetworkActivityIndicator();
        if ([connectionDelegate respondsToSelector:@selector(ConnectionDidFail:Data:)]) {
            [connectionDelegate ConnectionDidFail:@"Internet connection is not available. Please try again later." Data:nil];
        }
    }

}
-(void)getDataforGroupStates:(NSString*)strCase
{
    ShowNetworkActivityIndicator();
    if([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        NSString *strUrl=[NSString stringWithFormat:@"%@%@",MainURL,strCase];
        NSURL *url = [NSURL URLWithString:strUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:1000.0];
        
        
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSString *strAuthToken = @"ba51b7717feb96cbef2996b5bdfdc4e841fe1577";//[[GlobalMethod shareGlobalMethod] getTokenFromProfile];
        NSString *strToken = [NSString stringWithFormat:@"Token %@",strAuthToken];
        [request setValue:strToken forHTTPHeaderField:@"Authorization"];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request];
        //        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //
        //        }];
        
        [postDataTask resume];
    }
    else
    {
        HideNetworkActivityIndicator();
        if ([connectionDelegate respondsToSelector:@selector(ConnectionDidFail:Data:)]) {
            [connectionDelegate ConnectionDidFail:@"Internet connection is not available. Please try again later." Data:nil];
        }
    }
    
}
-(void)getDataforGroupDetailStates:(NSString*)strCase
{
    ShowNetworkActivityIndicator();
    if([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        NSString *strUrl=[NSString stringWithFormat:@"%@%@",MainURL,strCase];
        NSURL *url = [NSURL URLWithString:strUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:1000.0];
        
        
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSString *strAuthToken = @"293192505c6ce08c13029f7b3f1bd6c34db8c99a";//[[GlobalMethod shareGlobalMethod] getTokenFromProfile];
        NSString *strToken = [NSString stringWithFormat:@"Token %@",strAuthToken];
        [request setValue:strToken forHTTPHeaderField:@"Authorization"];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request];
        //        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //
        //        }];
        
        [postDataTask resume];
    }
    else
    {
        HideNetworkActivityIndicator();
        if ([connectionDelegate respondsToSelector:@selector(ConnectionDidFail:Data:)]) {
            [connectionDelegate ConnectionDidFail:@"Internet connection is not available. Please try again later." Data:nil];
        }
    }
    
}

- (void)getData:(id)dataDict caseName:(NSString*)strCase withToken:(BOOL)isToken
{
    ShowNetworkActivityIndicator();
    if([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        NSError *error;
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        

        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        NSString *strUrl=[NSString stringWithFormat:@"%@%@",MainURL,strCase];
        NSURL *url = [NSURL URLWithString:strUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:1000.0];
        

        [request setHTTPMethod:@"POST"];
        
        NSLog(@"URl %@",strUrl);
        
        if(dataDict)
        {
            NSData *postData = [NSJSONSerialization dataWithJSONObject:dataDict options:0 error:&error];
            NSString* postDataLengthString = [[NSString alloc] initWithFormat:@"%d", (int)[postData length]];
            [request setValue:postDataLengthString forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            if (isToken)
            {
//                NSString *strAuthToken = [[GlobalMethod shareGlobalMethod] getTokenFromProfile];
//                NSString *strToken = [NSString stringWithFormat:@"Token %@",strAuthToken];
//                 [request setValue:strToken forHTTPHeaderField:@"Authorization"];
            }
           
            [request setHTTPBody:postData];
        }
        else
        {
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            if (isToken)
            {
//                NSString *strAuthToken = [[GlobalMethod shareGlobalMethod] getTokenFromProfile];
//                NSString *strToken = [NSString stringWithFormat:@"Token %@",strAuthToken];
//                [request setValue:strToken forHTTPHeaderField:@"Authorization"];
            }

        }
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request];
        //        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //
        //        }];
        
        [postDataTask resume];
    }
    else
    {
        HideNetworkActivityIndicator();
        if ([connectionDelegate respondsToSelector:@selector(ConnectionDidFail:Data:)]) {
            [connectionDelegate ConnectionDidFail:@"Internet connection is not available. Please try again later." Data:nil];
        }
    }
}
-(void) setParams :(NSData*)imageData2 caseName:(NSString*)strCase2
{
    
    //if(pngData != nil)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        //NSString *strToken = [NSString stringWithFormat:@"Token %@",@"ba51b7717feb96cbef2996b5bdfdc4e841fe1577"];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        NSString *strUrl=[NSString stringWithFormat:@"%@%@",MainURL,strCase2];
        NSURL *url = [NSURL URLWithString:strUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:1000.0];
        
        
        [request setHTTPMethod:@"POST"];
        
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        NSMutableData *postbody = [NSMutableData data];
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"profile_image\"; filename=\"test2.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[NSData dataWithData:imageData2]];
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
//        NSString *strAuthToken = [[GlobalMethod shareGlobalMethod] getTokenFromProfile];
//        NSString *strToken = [NSString stringWithFormat:@"Token %@",strAuthToken];
//        [request setValue:strToken forHTTPHeaderField:@"Authorization"];
        
        [request setHTTPBody:postbody];
        //        [request addValue:[NSString stringWithFormat:@"%d", [body length]] forHTTPHeaderField:@"Content-Length"];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request];
      
        [postDataTask resume];
        
        
     
        
    }
    
}
-(void)getCaloriesDataFromServer:(NSString*)strCase qu:(NSOperationQueue*)opQueue stT:(NSString*)token
{
    ShowNetworkActivityIndicator();
    if([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:opQueue];
        NSString *strUrl=[NSString stringWithFormat:@"%@%@",MainURL,strCase];
        NSURL *url = [NSURL URLWithString:strUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:1000.0];
        
        
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSString *strAuthToken = token;//[[GlobalMethod shareGlobalMethod] getTokenFromProfile];
        NSString *strToken = [NSString stringWithFormat:@"Token %@",strAuthToken];
        [request setValue:strToken forHTTPHeaderField:@"Authorization"];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request];
        //        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //
        //        }];
        
        [postDataTask resume];
    }
    else
    {
        HideNetworkActivityIndicator();
        if ([connectionDelegate respondsToSelector:@selector(ConnectionDidFail:Data:)]) {
            [connectionDelegate ConnectionDidFail:@"Internet connection is not available. Please try again later." Data:nil];
        }
    }

}


#pragma mark - NSURLSession Delegate Methods
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    dataWebService=nil;
    dataWebService=[[NSMutableData alloc] init];
    [dataWebService setLength:0];
    completionHandler(NSURLSessionResponseAllow);
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [dataWebService appendData:data];
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)getError
{
    // dispatch_async(dispatch_get_main_queue(), ^{
    NSHTTPURLResponse *stCode=(NSHTTPURLResponse*)task.response;
    if(getError == nil)
    {
        NSLog(@"status code:%ld",(long)stCode.statusCode);
        NSString *responeString = [[NSString alloc] initWithData:dataWebService encoding:NSUTF8StringEncoding];
        NSLog(@"responeString ==> %@",responeString);
        if ([connectionDelegate respondsToSelector:@selector(ConnectionDidFinish:Data:statuscode:)])
        {
            HideNetworkActivityIndicator();
            [connectionDelegate ConnectionDidFinish:serviceName Data:responeString statuscode:stCode.statusCode];
        }
    }
    else
    {
        NSLog(@"Eror during connection: %@", [getError description]);
        NSError *error = getError;
        NSUInteger statusCode = stCode.statusCode;
        HideNetworkActivityIndicator();
        if (statusCode == 1) {
            NSLog(@"Request Failed Status Code 1");
            if ([connectionDelegate respondsToSelector:@selector(ConnectionDidFail:Data:)]) {
                [connectionDelegate ConnectionDidFail:@"Internet connection is not available. Please try again later." Data:nil];
            }
        }
        else {
            NSLog(@"Request Failed Status Code unknown");
            if ([connectionDelegate respondsToSelector:@selector(ConnectionDidFail:Data:)]) {
                NSString *responeString = [[NSString alloc] initWithData:dataWebService
                                                                encoding:NSUTF8StringEncoding];
                [connectionDelegate ConnectionDidFail:[error description] Data:responeString];
            }
        }
    }
    // });
    
}

@end
