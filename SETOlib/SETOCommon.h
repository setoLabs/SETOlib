//
//  SETOCommon.h
//  SETOlibDemo
//
//  Created by Sebastian Stenzel on 04.10.13.
//  Copyright (c) 2013 setolabs.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SETOCommon : NSObject

/*!
 * \brief true, if iOS version is greater than or equal to version
 */
+ (BOOL)systemVersionIsGreaterThanOrEqualToVersion:(NSString *)version;

@end
