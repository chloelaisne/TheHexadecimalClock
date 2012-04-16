//
//  TheHexadecimalClockView.h
//  TheHexadecimalClock
//
//  Created by Chloé Laisné on 4/13/12.
//  Copyright (c) 2012 Chloé Laisné. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>

@interface TheHexadecimalClockView : ScreenSaverView
{
    unsigned dateUnits;
    
    NSCalendar *calendar;
    
    NSDateComponents *time;
    
    NSRect screensaverBackground;
    
    CGFloat red, green, blue;
    
    NSMutableAttributedString *timeFormat;
}

@end
