
//
//  SQLiteAccess.m
//  Eventz
//
//  Created by Jon Mandell on 3/11/11.
//  Copyright 2011 MandellMobileApps. All rights reserved.
//

#import "SQLiteAccess.h"
#import <sqlite3.h>
#import "GlobalMethods.h"



@implementation SQLiteAccess


static int singleRowCallback(void *queryValuesVP, int columnCount, char **values, char **columnNames) {
    NSMutableDictionary *queryValues = (__bridge NSMutableDictionary *)queryValuesVP;
    int i;
    for(i=0; i<columnCount; i++) {
        [queryValues setObject:values[i] ? [NSString stringWithUTF8String:values[i]] : [NSString string] //[NSNull null]
                        forKey:[NSString stringWithFormat:@"%s", columnNames[i]]];
    }
    return 0;
}


static int multipleRowCallback(void *queryValuesVP, int columnCount, char **values, char **columnNames) {
    NSMutableArray *queryValues = (__bridge NSMutableArray *)queryValuesVP;
    NSMutableDictionary *individualQueryValues = [NSMutableDictionary dictionary];
    int i;
    for(i=0; i<columnCount; i++) {
        [individualQueryValues setObject:values[i] ? [NSString stringWithUTF8String:values[i]] :  [NSString string] //[NSNull null]
                                  forKey:[NSString stringWithFormat:@"%s", columnNames[i]]];
    }
    [queryValues addObject:[NSDictionary dictionaryWithDictionary:individualQueryValues]];
    return 0;
}



+ (NSNumber *)executeSQL:(NSString *)sql withCallback:(void *)callbackFunction context:(id)contextObject
{
    NSInteger numberOfRetries = 0;
    NSInteger maxNumberOfRetries = 5;
    BOOL retry = NO;
    NSString *path = [self dataFilePathofDocuments:@"Retirement.sqlite"];
    //DLog(@"path %@",path);

    do {
        
        retry   = YES;
        sqlite3 *db = NULL;
        int rc = SQLITE_OK;
        NSInteger lastRowId = 0;
        
        rc = sqlite3_open([path UTF8String], &db);
        
        if (SQLITE_OK != rc)
        {
            usleep(20);
            if (numberOfRetries > maxNumberOfRetries)
            {
                sqlite3_close(db);
                return nil;
            }
             [SQLiteAccess addToTextLog:[NSString stringWithFormat:@"SQL %@\n", sql]];
             [SQLiteAccess addToTextLog:[NSString stringWithFormat:@"Database open error %li: %s\n",numberOfRetries, sqlite3_errmsg(db)]];
            numberOfRetries++;
        }
        else
        {
              char *zErrMsg = NULL;
        
              rc = sqlite3_exec(db, [sql UTF8String], callbackFunction, (__bridge void*)contextObject, &zErrMsg);
            if (SQLITE_OK != rc)
            {
                usleep(20);
                if (numberOfRetries > maxNumberOfRetries) {
                    sqlite3_close(db);
                    return nil;
                }
                [SQLiteAccess addToTextLog:[NSString stringWithFormat:@"SQL %@\n", sql]];
                [SQLiteAccess addToTextLog:[NSString stringWithFormat:@"Can't run query %li: %s\n",numberOfRetries, sqlite3_errmsg(db)]];
                numberOfRetries++;

            }
            else
            {
                lastRowId = sqlite3_last_insert_rowid(db);
                sqlite3_close(db);
                NSNumber *lastInsertRowId = nil;
                if(0 != lastRowId) {
                    lastInsertRowId = [NSNumber numberWithInteger:lastRowId];
                }
                return lastInsertRowId;
                retry = NO;  // should never get here;
            }
        }
    }
    while (retry);
    return nil;
}

//    ALTER TABLE table_name
//    ADD new_column_name column_definition;

//    SELECT *
//    FROM INFORMATION_SCHEMA.COLUMNS
//    --WHERE TABLE_NAME = N'YourTableName'

+(void)addColumn:(NSString*)columnName ofType:(NSInteger)type toTable:(NSString*)tableName
{

    //    //  alter table myTable
    //    //add column newColumn INTEGER default 0;
//    NSArray* dbs = [SQLiteAccess selectManyValuesWithSQL:@"SELECT name FROM sqlite_master WHERE type = \"table\""];

    NSArray* columns = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"PRAGMA table_info(%@);",tableName]];
    BOOL columnDoesNoteExist = YES;
    
    for (NSDictionary* column in columns)
    {
        NSString* thisColumnName = [column objectForKey:@"name"];
        if ([thisColumnName isEqualToString:columnName])
        {
            columnDoesNoteExist = NO;
        }
    }
    if (columnDoesNoteExist)
    {
        NSString* thisType;
        if (type == ColumnTypeInteger)
        {
            thisType = @"INTEGER";
            
        }
        else if (type == ColumnTypeText)
        {
            thisType = @"TEXT";
            
        }
        NSString* sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ %@",tableName,columnName,thisType];
        [SQLiteAccess updateWithSQL:sql];
    }
 
}


+ (NSNumber *)oldexecuteSQL:(NSString *)sql withCallback:(void *)callbackFunction context:(id)contextObject
    {
// add @try here
    NSString *path = [self dataFilePathofDocuments:@"Retirement.sqlite"];
    sqlite3 *db = NULL;
    int rc = SQLITE_OK;
    NSInteger lastRowId = 0;
    rc = sqlite3_open([path UTF8String], &db);
    
    // suggestion to prevent sqlite from caching your queries and slowly consuming all of your memory.
//    const char *pragmaSql = "PRAGMA cache_size = 50";
//    if (sqlite3_exec(db, pragmaSql, NULL, NULL, NULL) != SQLITE_OK) {
//
//
//        NSAssert1(0, @"Error: failed to execute pragma statement with message '%s'.", sqlite3_errmsg(db));
//    }
    
    if(SQLITE_OK != rc)
    {
        [SQLiteAccess addToTextLog:[NSString stringWithFormat:@"Can't open database: %s\n", sqlite3_errmsg(db)]];
        sqlite3_close(db);
        return nil;
    }
    else
    {
        char *zErrMsg = NULL;
  
        rc = sqlite3_exec(db, [sql UTF8String], callbackFunction, (__bridge void*)contextObject, &zErrMsg);
        if(SQLITE_OK != rc) {
        [SQLiteAccess addToTextLog:[NSString stringWithFormat:@"Can't run query '%@' error message: %s\n", sql, sqlite3_errmsg(db)]];
            sqlite3_free(zErrMsg);
        }
        lastRowId = sqlite3_last_insert_rowid(db);
        sqlite3_close(db);
  
    }
    NSNumber *lastInsertRowId = nil;
    if(0 != lastRowId) {
        lastInsertRowId = [NSNumber numberWithInteger:lastRowId];
    }
    return lastInsertRowId;
}

+ (NSString *)selectOneValueSQL:(NSString *)sql {
    NSMutableDictionary *queryValues = [NSMutableDictionary dictionary];
    [self executeSQL:sql withCallback:singleRowCallback context:queryValues];
    NSString *value = nil;
    if([queryValues count] == 1) {
        value = [[queryValues objectEnumerator] nextObject];
    }
    return value;
}

+ (NSArray *)selectManyValuesWithSQL:(NSString *)sql {
    NSMutableArray *queryValues = [NSMutableArray array];
    [self executeSQL:sql withCallback:multipleRowCallback context:queryValues];
    NSMutableArray *values = [NSMutableArray array];
    for(NSDictionary *dict in queryValues) {
        [values addObject:[[dict objectEnumerator] nextObject]];
    }
    return values;
}

+ (NSDictionary *)selectOneRowWithSQL:(NSString *)sql {
    NSMutableDictionary *queryValues = [NSMutableDictionary dictionary];
    [self executeSQL:sql withCallback:singleRowCallback context:queryValues];
    return [NSDictionary dictionaryWithDictionary:queryValues];
}

+ (NSArray *)selectManyRowsWithSQL:(NSString *)sql {
    NSMutableArray *queryValues = [NSMutableArray array];
    [self executeSQL:sql withCallback:multipleRowCallback context:queryValues];
    return [NSArray arrayWithArray:queryValues];
}

+ (NSNumber *)insertWithSQL:(NSString *)sql {
    sql = [NSString stringWithFormat:@"BEGIN TRANSACTION; %@; COMMIT TRANSACTION;", sql];
    return [self executeSQL:sql withCallback:NULL context:NULL];
}

+ (void)updateWithSQL:(NSString *)sql {
    sql = [NSString stringWithFormat:@"BEGIN TRANSACTION; %@; COMMIT TRANSACTION;", sql];
    [self executeSQL:sql withCallback:NULL context:nil];
}

+ (void)deleteWithSQL:(NSString *)sql {
    sql = [NSString stringWithFormat:@"BEGIN TRANSACTION; %@; COMMIT TRANSACTION;", sql];
    [self executeSQL:sql withCallback:NULL context:nil];
}


//   ****************************************************************************
//   File methods
//   ****************************************************************************


+ (NSString *)dataFilePathofDocuments:(NSString *)nameoffile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:nameoffile];
    return documentsPath ;
}

+ (NSString *)dataFilePathofBundle:(NSString *)nameoffile {
    NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:nameoffile];
    return bundlePath;
}

+(void)addToTextLog:(NSString*)message
{

    DLog(@"Added to TextLog %@",message);
    NSString* dateString = [GlobalMethods debugFormattedTime];

    NSString* log = [NSString stringWithFormat:@"%@\n%@\n\n",dateString,message];

    NSString *content;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString* path = [GlobalMethods dataFilePathofDocuments:@"TextLog.txt"];
    if(![fileManager fileExistsAtPath:path])
    {
      [log writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    else
    {
        content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    }
    
    if (content.length > 100000)
    {
        content = [content substringFromIndex:50000];

    }
    content = [content stringByAppendingString:log];
    [content writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
