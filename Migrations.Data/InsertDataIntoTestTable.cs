using FluentMigrator;
//using FluentMigrator.Runner.Extensions;

namespace Migrations.Data
{
    //[Migration(3, "Duplicate Migration Testing")]
    //public class DuplicateMigration : Migration
    //{
    //    public override void Up()
    //    {
    //    }

    //    public override void Down()
    //    {
    //    }
    //}

    [CustomMigrationAttribute(3, "Seb", "Insert data into table")]
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
