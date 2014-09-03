using FluentMigrator;

namespace Migrations.Data
{
    [Migration(1, "Create Test Table")]
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
