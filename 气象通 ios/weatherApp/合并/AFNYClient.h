//
//  AFNYClient.h
//  Meteorological_app
//
//  Created by zhao on 14-6-22.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "AFHTTPClient.h"

@interface AFNYClient : AFHTTPClient

+ (AFNYClient *)sharedClient;
@end
