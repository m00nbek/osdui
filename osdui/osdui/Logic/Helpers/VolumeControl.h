//
//  VolumeControl.h
//  osdui
//
//  Created by m00nbek Melikulov on 1/9/23.
//

#import <Foundation/Foundation.h>

#define kVolumeControlMinValue  0.0f
#define kVolumeControlMaxValue  1.0f

@interface VolumeControl : NSObject

@property (readwrite, class, getter=getVolumeLevel) Float32 volumeLevel;
@property (readwrite, class, getter=isAudioMuted) BOOL muted;
@property (readwrite, class, getter=volume) float volume;

@end
