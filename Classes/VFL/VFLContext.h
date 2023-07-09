//
//  VFLContext.h
//  Created by Sidharth Juyal on 08/07/2023.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
typedef UIView VFLView ;

@interface VFLContext : NSObject
+ (instancetype)context;
+ (instancetype)contextWithView:(VFLView *)view;

- (void)addSubviewsWithBindings:(NSDictionary *)dictionary;

- (void)addConstraintsWithFormats:(NSArray *)formats;
- (void)addConstraints:(NSArray *)constraints;
- (void)removeAllConstraints;

- (void)addFormatOptions:(NSLayoutFormatOptions)options;
- (void)removeAllFormatOptions;

- (void)addMetrics:(NSDictionary *)metrics;
- (void)removeAllMetrics;

- (void)reloadConstraints;

@property (nonatomic, strong) VFLView *parentView;

@end
