//
//  SearchCurrencyOperation.m
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import "SearchCurrencyOperation.h"

@interface SearchCurrencyOperation ()<NSXMLParserDelegate>

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) SearchCompletionHandler completion;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *result;

@end

@implementation SearchCurrencyOperation

- (instancetype)initWithSession:(NSURLSession *)session
                            URL:(NSURL *)url
                     completion:(SearchCompletionHandler)completion {
    self = [super init];
    if (self) {
        _session = session;
        _url = url;
        _completion = completion;
    }
    return self;
}

- (NSMutableDictionary<NSString *, NSNumber *> *)result {
    if (_result == nil) {
        _result = [@{
                    @"EUR" : @1,
                    @"USD" : @1,
                    @"GBP" : @1,
                    } mutableCopy];
    }
    return _result;
}

- (void)doStart {
    NSURLSessionDataTask *task =
    [self.session dataTaskWithURL:self.url
                completionHandler:^(NSData * _Nullable data,
                                    NSURLResponse * _Nullable response,
                                    NSError * _Nullable error) {
                    if (error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.completion(nil, error);
                        });
                    } else
                    if (data) {
                        NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:data];
                        [myParser setDelegate:self];
                        [myParser setShouldResolveExternalEntities: YES];
                        [myParser parse];
                    }
                }];
    [task resume];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.completion(self.result, nil);
    });
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    if (attributeDict[@"currency"]) {
        NSString *currency = attributeDict[@"currency"];
        NSString *rate = attributeDict[@"rate"];
        if (self.result[currency]) {
            NSNumberFormatter *formatter = [NSNumberFormatter new];
            formatter.numberStyle = NSNumberFormatterDecimalStyle;
            self.result[currency] = [formatter numberFromString:rate];
        }
    }
}

@end
