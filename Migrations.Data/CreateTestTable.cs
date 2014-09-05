using FluentMigrator;

namespace Migrations.Data
{
    [CustomMigrationAttribute(1, "Seb", "Create Table tbl_Test")]
    public class CreateTestTable : AutoReversingMigration
    {
        public override void Up()
        {
            Create.Table("tbl_Test")
                .WithColumn("Id")
                .AsInt32()
                .Identity()
                .PrimaryKey()
                .WithColumn("TestColumnA")
                .AsString(30);
        }
    }
}
