# iRonFMDBDemo
FMDB Demo / FMDB 使用例子

<pre><code>
    #import "iRonFMDB.h"

    [iRonFMDB databaseWithDBName:@"MyDBName"];
    
    /* 创建名为person的表 */
    [iRonFMDB createTable:@"person" withPrimaryKey:@"id"];
    
    /* person表中插入一行数据 */
    [iRonFMDB insertIntoTable:@"person" withParam:@{@"id":@"11",@"name":@"aaa",@"age":@"18 ",@"number":@"999"}];
    
    /* person表中删除id为123的行 */
    [iRonFMDB delete:@"123" fromTable:@"person"];
    
    /* 获取person表中的所有年龄 */
//    [iRonFMDB selectAllFromTable:@"person" withColumn:@"person_age"];
    NSLog(@"%@",[iRonFMDB selectAllFromTable:@"person" withColumn:@"person_age"]);
    
    [iRonFMDB closeDatabase];
    
</code></pre>
