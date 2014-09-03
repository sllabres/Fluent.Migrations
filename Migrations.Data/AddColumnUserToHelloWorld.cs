using FluentMigrator;

namespace Migrations.Data
{
    [Migration(2, "Adding Column To Test Table")]
    public class AddColumnToTestTable : Migration
    {
        public override void Up()
        {
            Alter.Table("tbl_Test")
                 .AddColumn("TestColumnB")
                 .AsString(30)
                 .WithDefaultValue("");
        }

        public override void Down()
        {
            Delete
                .Column("TestColumnB")
                .FromTable("tbl_Test");
        }
    }
}