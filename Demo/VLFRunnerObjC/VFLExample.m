//
//  VFLExample.m
//  VLFRunnerObjC
//
//  Created by Sidharth Juyal on 09/07/2023.
//

#import "VFLExample.h"

NSString *VFLExampleGetName(VFLExample example)
{
  switch (example) {
    case VFLExampleFull: return @"Screen Full Layout";
    case VFLExampleHSplit: return @"Horizontal Equal Split";
    case VFLExampleVSplit: return @"Vertical Equal Split";
    case VFLExampleFixed: return @"Fixed Size View";
    case VFLExampleCenter: return @"Center View";
    case VFLExampleComplex: return @"Complex Example";
    case VFLExampleTotal: return @"";
  }
  return @"";
}

NSString *VFLExampleGetClassname(VFLExample example)
{
  switch (example) {
    case VFLExampleFull: return @"VFLExampleFullView";
    case VFLExampleHSplit: return @"VFLExampleHSplitView";
    case VFLExampleVSplit: return @"VFLExampleVSplitView";
    case VFLExampleFixed: return @"VFLExampleFixedView";
    case VFLExampleCenter: return @"VFLExampleCenterView";
    case VFLExampleComplex: return @"VFLExampleComplexView";
    case VFLExampleTotal: return nil;
  }
  return nil;
}
