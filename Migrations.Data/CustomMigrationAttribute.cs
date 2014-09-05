using FluentMigrator;

namespace Migrations.Data
{
    public class CustomMigrationAttribute : MigrationAttribute
    {
        public CustomMigrationAttribute(long version, string author, string description)
            : base(version, description)
        {
            this.Author = author;
        }

        public string Author { get; private set; }
    }
}