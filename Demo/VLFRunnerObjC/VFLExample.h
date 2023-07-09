//
//  VFLExample.h
//  VLFRunnerObjC
//
//  Created by Sidharth Juyal on 09/07/2023.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, VFLExample) {
  VFLExampleFull,
  VFLExampleHSplit,
  VFLExampleVSplit,
  VFLExampleFixed,
  VFLExampleCenter,
  VFLExampleComplex,
  
  VFLExampleTotal
};

NSString *VFLExampleGetName(VFLExample example);
NSString *VFLExampleGetClassname(VFLExample example);

