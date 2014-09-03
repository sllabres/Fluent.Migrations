function Generate-Common-Assembly-Info
{
    param(
        [string]$file = $(throw "file is a required parameter."),
        [string]$product,
        [string]$version
    )
    
    $asmInfo = "using System;
using System.Reflection;
using System.Runtime.CompilerServices;

[assembly: AssemblyCompanyAttribute(""DRL Limited"")]
[assembly: AssemblyProductAttribute(""$product"")]
[assembly: AssemblyVersionAttribute(""$version"")]
[assembly: AssemblyCopyrightAttribute(""Copyright (c) 2012, DRL Limited"")]
[assembly: AssemblyInformationalVersionAttribute(""$version / $commit"")]
[assembly: AssemblyFileVersionAttribute(""$version"")]
[assembly: AssemblyDelaySignAttribute(false)]
"
    $dir = [System.IO.Path]::GetDirectoryName($file)
    $dir = Resolve-Path $dir
    if ((Test-Path $dir) -eq "false")
    {
        Write-Host "Creating directory $dir"
        [System.IO.Directory]::CreateDirectory($dir)
    }
    Write-Host "Generating assembly info file: $file"
    Write-Output $asmInfo > $file
}

function GetMappedDrive([string]$driveLetter, [ref]$pathName, [string]$username, [string]$sourcePassword)
{
    if ($username)
    {
        try
        {
            UnMapDrive $driveLetter $username
        }
        catch [Exception] { }

        #Exec { NET USE "$driveLetter" ($pathName.Value) $password /USER:$username }
		
		$password = ConvertTo-SecureString $sourcePassword -asplaintext -force
		$credential = New-Object System.Management.Automation.PSCredential($username,$password)
		$drive = new-object -com wscript.network
		$drive.MapNetworkDrive("$driveLetter",($pathName.Value),$false,$credential.UserName,$credential.GetNetworkCredential().Password)
        
        $pathName.Value = "FILESYSTEM::P:"
    }
    else
    {
        return $pathName
    }
}

function UnMapDrive([string]$driveLetter, [string]$username)
{
    if ($username)
    {
        Exec { NET USE $driveLetter /DELETE }
    }	
}

function Copy-Files
{
    param(
        [string]$sourcePath,
        [string]$targetPath,
        [array]$excludePatterns
    )

    if ((Test-Path $targetPath) -ne $True) {
        new-item $targetPath -itemType directory
    }
    
    if ($targetPath.StartsWith('\\') -ne $true) {
        $targetPath = Resolve-Path $targetPath
    }
    $sourcePath = Resolve-Path $sourcePath
    
    $filesToCopy = Get-ChildItem $sourcePath -Recurse -Exclude $excludePatterns

    Write-Host "Copying files from" $sourcePath "to" $targetPath

    $filesCopied = 0
    
    ForEach ($item in $filesToCopy) { `
      $itemTargetPath = Join-Path $targetPath $item.FullName.Substring($sourcePath.length)
      $pathToTest = [System.IO.Path]::GetDirectoryName($itemTargetPath.Replace("FILESYSTEM::",""))

      if (([System.IO.Directory]::Exists($pathToTest)) -eq $True) {
        Copy-Item $item $itemTargetPath -force
        $filesCopied = $filesCopied + 1
      }
    }
    
    Write-Host "Copied" $filesCopied "files"
}