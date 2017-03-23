//
//  DBDaoHelper.h
//  E-Book
//

/*******************************************************
 类名：DBDaoHelper.h
 功能描述：实现对SQLite数据库的创建，和对user表按用户名和密码查询数据的功能
 
 */

#import <Foundation/Foundation.h>
#import "FMResultSet.h"

@interface DBDaoHelper : NSObject

//创建数据库表
+(BOOL)createTableWithSql:(NSString *)sql;

//更新数据库
+(BOOL)executeUpdate:(NSString*)sql, ...;

//输入sql语句来更新数据库
+(BOOL)updateTableData:(NSString *)sql;

//查询方法
+(FMResultSet *)selectDataWithSql:(NSString *)sql;

//查询缓存
+(float)cacheByteCount;

//清空缓存
+(void)removeAllCache;

@end
