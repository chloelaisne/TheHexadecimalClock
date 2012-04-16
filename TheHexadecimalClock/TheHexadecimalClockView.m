//
//  TheHexadecimalClockView.m
//  TheHexadecimalClock
//
//  Created by Chloé Laisné on 4/13/12.
//  Copyright (c) 2012 Chloé Laisné. All rights reserved.
//

#import "TheHexadecimalClockView.h"

@implementation TheHexadecimalClockView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    
    if (self)
    {
        // Register font
        
        NSArray *arrayFonts = [[NSBundle bundleForClass:[self class]] URLsForResourcesWithExtension:nil subdirectory:@"Fonts"];
        
        CTFontManagerRegisterFontsForURLs((CFArrayRef)arrayFonts, kCTFontManagerScopeProcess, nil);
        
        [arrayFonts release];
        
        // Create attributes
        
        NSArray *objectAttributes = [NSArray arrayWithObjects:[NSFont fontWithName:@"Akagi-Thin" size:50], [NSColor whiteColor], [NSNumber numberWithDouble:0.5], nil];
        
        NSArray *keyAttributes = [NSArray arrayWithObjects:NSFontAttributeName, NSForegroundColorAttributeName, NSKernAttributeName, nil];
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObjects:objectAttributes forKeys:keyAttributes];
        
        // Start timer
        
        NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1 target:self selector:@selector(onTimeChange:) userInfo:nil repeats:YES];
        
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        
        [runloop addTimer:timer forMode:NSDefaultRunLoopMode];
        
        [timer release];
        
        // Initialize background
        
        screensaverBackground = NSMakeRect(0, 0, [self bounds].size.width, [self bounds].size.height);
        
        // Set time
        
        dateUnits = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
         
        time = [calendar components:dateUnits fromDate:[NSDate date]];
        
        // Set RGB colors
        
        red = (CGFloat)[time hour] / 23.0;
        
        green = (CGFloat)[time minute] / 59.0;
        
        blue = (CGFloat)[time second] / 59.0;
        
        // Format time
        
        NSString *stringTime = [NSString stringWithFormat:@"%02i:%02i:%02i", ([time hour]), ([time minute]), ([time second])];
        
        timeFormat = [[[NSMutableAttributedString alloc] initWithString:stringTime attributes:attributes] autorelease];
        
        [stringTime release];
        
        
        
        [self setAnimationTimeInterval:1/30.0];
    }
    
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    // Draw background
    
    [[NSColor colorWithDeviceRed:red green:green blue:blue alpha:1.0] set];
    
    NSRectFill(screensaverBackground);
    
    // Draw time
    
    [timeFormat drawInRect:NSMakeRect([self bounds].size.width / 2 - timeFormat.size.width / 2, [self bounds].size.height / 2 - timeFormat.size.height / 2, timeFormat.size.width, timeFormat.size.height)];
}

-(void)onTimeChange:(NSTimer *)timer
{
    // Set time
    
    time = [calendar components:dateUnits fromDate:[NSDate date]];
    
    // Set colors
    
    red = (CGFloat)[time hour] / 23.0;
    
    green = (CGFloat)[time minute] / 59.0;
    
    blue = (CGFloat)[time second] / 59.0;
    
    // Format time
    
    NSString *stringTime = [NSString stringWithFormat:@"%02i:%02i:%02i", ([time hour]), ([time minute]), ([time second])];
    
    [timeFormat replaceCharactersInRange:NSMakeRange(0, [stringTime length])  withString:stringTime];
    
    // Redraw NSView
    
    [self setNeedsDisplay:YES];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
