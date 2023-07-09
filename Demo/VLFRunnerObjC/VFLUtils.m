//
//  VFLUtils.m
//  VLFRunnerObjC
//
//  Created by Sidharth Juyal on 09/07/2023.
//

#import "VFLUtils.h"

UIColor *vfl_CreateRandomColor(void)
{
  return [UIColor colorWithHue:arc4random()/(CGFloat)UINT32_MAX saturation:0.7 brightness:0.7 alpha:1];
}

NSDictionary *vfl_CreateUIEdgeInsetsMetrics(UIEdgeInsets insets)
{
  return [NSDictionary dictionaryWithObjectsAndKeys:
          [NSNumber numberWithDouble:insets.top], @"top",
          [NSNumber numberWithDouble:insets.bottom], @"bottom",
          [NSNumber numberWithDouble:insets.left], @"left",
          [NSNumber numberWithDouble:insets.right], @"right",
          nil];
}
