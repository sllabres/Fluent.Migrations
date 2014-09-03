﻿using FluentMigrator;

//using FluentMigrator.Runner.Extensions;

namespace Migrations.Data
{
    [Migration(3, "Insert Data Into Test Table")]
    public class InsertDataIntoTestTable : Migration
    {
        public override void Up()
        {
            Insert.IntoTable("tbl_Test")
                // WithIdentityInsert is a SQL extension which allows us to specificy the identity for an insert
                //.WithIdentityInsert()
                .Row(new { TestColumnA = "TestA", TestColumnB = "TestB" });
        }

        public override void Down()
        {
            Delete.FromTable("tbl_Test").Row(new { TestColumnA = "TestA", TestColumnB = "TestB" });
        }
    }
}