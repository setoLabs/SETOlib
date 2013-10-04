//
//  SETOCommon.m
//  SETOlibDemo
//
//  Created by Sebastian Stenzel on 04.10.13.
//  Copyright (c) 2013 setolabs.com. All rights reserved.
//

#import "SETOCommon.h"

@implementation SETOCommon

+ (BOOL)isBeforeSystemVersion:(NSString *)version {
	return [[UIDevice currentDevice].systemVersion compare:version options:NSNumericSearch] == NSOrderedAscending;
}

@end
