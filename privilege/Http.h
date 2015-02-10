//
//  Http.h
//  privilege
//
//  Created by 吴佰清 on 14/12/30.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Http : NSObject

+ (void) httpRequest:(NSString *)requestUrl collctionView:(NSObject *)collectionView currentPage:(int)page isRefreing:(int)isRefre;

@end
