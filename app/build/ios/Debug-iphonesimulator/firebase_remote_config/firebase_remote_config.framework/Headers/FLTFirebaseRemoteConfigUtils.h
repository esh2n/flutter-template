// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
#import <TargetConditionals.h>
#import <Foundation/Foundation.h>

@interface FLTFirebaseRemoteConfigUtils : NSObject
+ (NSDictionary *)ErrorCodeAndMessageFromNSError:(NSError *)error;
@end
