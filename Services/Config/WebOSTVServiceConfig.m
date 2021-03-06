//
//  WebOSTVServiceConfig.m
//  Connect SDK
//
//  Created by Jeremy White on 12/9/13.
//  Copyright (c) 2014 LG Electronics.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "WebOSTVServiceConfig.h"

@implementation WebOSTVServiceConfig

- (instancetype) initWithJSONObject:(NSDictionary *)dict
{
    self = [super init];

    if (self)
    {
        self.clientKey = dict[@"clientKey"];
        self.SSLCertificates = dict[@"SSLCertificates"];
    }

    return self;
}

- (NSDictionary *) toJSONObject
{
    NSDictionary *superDictionary = [super toJSONObject];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:superDictionary];

    dictionary[@"class"] = NSStringFromClass([self class]);

    if (self.clientKey) dictionary[@"clientKey"] = self.clientKey;
    if (self.SSLCertificates) dictionary[@"SSLCertificates"] = self.SSLCertificates;

    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (void) addObservers
{
    [super addObservers];

    [self addObserver:self forKeyPath:@"clientKey" options:0 context:nil];
    [self addObserver:self forKeyPath:@"SSLCertificates" options:0 context:nil];
}

- (void) removeObservers
{
    [super removeObservers];

    [self removeObserver:self forKeyPath:@"clientKey"];
    [self removeObserver:self forKeyPath:@"SSLCertificates"];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self.delegate serviceConfigUpdate:self];
}

@end
