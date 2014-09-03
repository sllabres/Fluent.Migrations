properties {	
}

task default -depends Compile, Migrate

task Compile {
	msbuild Migrations.Data.sln /m /nr:False /t:Rebuild /p:Configuration=Release /verbosity:quiet
}

task MigrateOne {
    Migrate.exe --connection "Data Source=./Data/TestDatabase.sdf;Persist Security Info=False;" --db SqlServerCe --target "./Migrations.Data/bin/Release/Migrations.Data.dll" --verbose true --version 1 --outputFilename ./MigrateOne.sql --output true --transaction-per-session true
}

task Migrate {
    Migrate.exe --connection "Data Source=./Data/TestDatabase.sdf;Persist Security Info=False;" --db SqlServerCe --target "./Migrations.Data/bin/Release/Migrations.Data.dll" --verbose true --outputFilename ./Migrate.sql --output true --transaction-per-session true
}

task MigratePreview {
	Migrate.exe --connection "Data Source=./Data/TestDatabase.sdf;Persist Security Info=False;" --db SqlServerCe --target "./Migrations.Data/bin/Release/Migrations.Data.dll" --verbose true --preview true --outputFilename ./MigratePreview.sql --output true --transaction-per-session true
}

task Rollback {
	Migrate.exe --connection "Data Source=./Data/TestDatabase.sdf;Persist Security Info=False;" --db SqlServerCe --target "./Migrations.Data/bin/Release/Migrations.Data.dll" --verbose true --task rollback --outputFilename ./Rollback.sql --output true --transaction-per-session true
}

task RollbackAll {
	Migrate.exe --connection "Data Source=./Data/TestDatabase.sdf;Persist Security Info=False;" --db SqlServerCe --target "./Migrations.Data/bin/Release/Migrations.Data.dll" --verbose true --task rollback:all --outputFilename ./RollbackAll.sql --output true --transaction-per-session true
}

