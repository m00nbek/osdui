//
//  NSImage+ColorInvert.m
//  osdui
//
//  Created by m00nbek Melikulov on 1/9/23.
//  
//

//#import "NSImage+ColorInvert.h"
//#import <CoreImage/CIFilter.h>
//
//@implementation NSImage (ColorInvert)
//
//- (NSImage *)imageByInvertingColors
//{
//    CIImage *ciImage = [[CIImage alloc] initWithData:[self TIFFRepresentation]];
//    CIFilter *ciFilter = [CIFilter filterWithName:@"CIColorInvert"];
//    [ciFilter setDefaults];
//    [ciFilter setValue:ciImage forKey:@"inputImage"];
//    CIImage *outputImage = [ciFilter valueForKey:@"outputImage"];
//    NSImage *output = [[NSImage alloc] initWithSize:[outputImage extent].size];
//    NSCIImageRep *rep = [NSCIImageRep imageRepWithCIImage:outputImage];
//    [output addRepresentation:rep];
//    return output;
//}
//
//@end
