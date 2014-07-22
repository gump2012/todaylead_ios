//
//  logdef.h
//  todayios
//
//  Created by lishiming on 14-7-22.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#ifndef todayios_logdef_h
#define todayios_logdef_h

#define DEBUG_Net 0
#if DEBUG_Net
#define LOG_Net(log, ...) NSLog(log, ##__VA_ARGS__)
#else
#define LOG_Net(log, ...)
#endif

#define DEBUG_Test 1
#if DEBUG_Test
#define LOG_Test(log, ...) NSLog(log, ##__VA_ARGS__)
#else
#define LOG_Test(log, ...)
#endif

#define DEBUG_Error 1
#if DEBUG_Error
#define LOG_Error(log, ...) NSLog(log, ##__VA_ARGS__)
#else
#define LOG_Error(log, ...)
#endif

#endif
