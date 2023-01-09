//
//  BrightnessControl.h
//  osdui
//
//  Created by m00nbek Melikulov on 1/9/23.
//

#import <Foundation/Foundation.h>

#define kBrightnessControlMinValue  0.0f
#define kBrightnessControlMaxValue  1.0f

@interface BrightnessControl : NSObject

@property (readonly, class, getter=getBrightnessLevel) float brightnessLevel;

+ (void)setBrightnessLevel:(float)level;

@end

