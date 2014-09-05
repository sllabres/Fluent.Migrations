using FluentMigrator;

namespace Migrations.Data
{
    [CustomMigrationAttribute(2, "Seb", "Add column to tbl_Test TestColumnB")]
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