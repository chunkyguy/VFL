//
//  VFLContext.m
//  Created by Sidharth Juyal on 08/07/2023.
//

#import "VFLContext.h"

@interface VFLContext () {
  NSMutableDictionary *_views;
  NSMutableDictionary *_metrics;
  NSLayoutFormatOptions _options;
  NSMutableArray *_constraints;
}
@end

@implementation VFLContext

+ (instancetype)contextWithView:(VFLView *)view
{
  return [[VFLContext alloc] initWithView:view];
}

+ (instancetype)context
{
  return [[VFLContext alloc] initWithView:nil];
}

- (instancetype)initWithView:(VFLView *)view
{
  self = [super init];
  if (self) {
    _views = [NSMutableDictionary dictionary];
    _metrics = [NSMutableDictionary dictionary];
    _options = 0;
    _constraints = [NSMutableArray array];
    self.parentView = view;
  }
  return self;
}

- (void)addSubviewsWithBindings:(NSDictionary *)views;
{
  for (VFLView *view in [views allValues]) {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.parentView addSubview:view];
  }
  _views = [NSMutableDictionary dictionaryWithDictionary:views];
}

- (void)addSubview:(VFLView *)view named:(NSString *)name
{
  view.translatesAutoresizingMaskIntoConstraints = NO;
  [self.parentView addSubview:view];
  [_views setObject:view forKey:name];
}

- (void)addConstraintsWithFormats:(NSArray *)formats
{
  NSMutableArray *constraints = [NSMutableArray array];
  for (NSString *format in formats) {
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:format options:_options metrics:_metrics views:_views]];
  }
  [self addConstraints:constraints];
}
- (void)addConstraints:(NSArray *)constraints
{
  [NSLayoutConstraint activateConstraints:constraints];
  [_constraints addObjectsFromArray:constraints];
}
- (void)removeAllConstraints
{
  [NSLayoutConstraint deactivateConstraints:_constraints];
  [_constraints removeAllObjects];
}
- (void)reloadConstraints
{
  [self.parentView layoutIfNeeded];
}

- (void)addFormatOptions:(NSLayoutFormatOptions)options
{
  _options |= options;
}
- (void)removeAllFormatOptions
{
  _options = 0;
}

- (void)addMetrics:(NSDictionary *)metrics
{
  [_metrics addEntriesFromDictionary:metrics];
}
- (void)removeAllMetrics
{
  [_metrics removeAllObjects];
}

@end
