############################   CONFIGURATION   ####################################################

	$Server			=		"."					#	Server Instanse Name
	
	$AtlasDB		=		"AtlasGTS"			# 	Atlas Database Name
	
	$LogDB			=		"LogGTS"			#	Log Database Name
	
	$User			=		"sa"				#	SQL Server Username
	
	$Password		=		"123@tlas"			#	SQL Server Password
	
	$Path			=		"D:"				#	Installation Path
	
	$License		=		""					#	License Key
	
	$WSPort			=		"81"				#	Webservice IIS Port
	
	$AtlasPort		=		"80"				#	Atlas Publish IIS Port

###################################################################################################












### Unistall ELE Service ##########################################################################

if ( Test-Path "$Path\_ATLAS_\ELE" ) 
{ 
	Write-Host "Unistall ELE Service..." ;
	Invoke-Item "$Path\_ATLAS_\ELE\installutil.exe /u $Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe" ;
	Write-Host "Finish.`r`n" ;
}

### Detach Databse ################################################################################

Write-Host "Detach Atlas Database..." ; 
Invoke-Sqlcmd -Query "ALTER DATABASE [$AtlasDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE ; DROP DATABASE [$AtlasDB] ;" -ServerInstance $Server -Username $User -Password $Password -QueryTimeout 120 ;
Write-Host "Finish.`r`n" ; 

Write-Host "Detach Log Database..." ; 
Invoke-Sqlcmd -Query "ALTER DATABASE [$LogDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE ; DROP DATABASE [$LogDB] ;" -ServerInstance $Server -Username $User -Password $Password -QueryTimeout 120 ;
Write-Host "Finish.`r`n" ; 

### Copy ATLAS Files ##############################################################################

if ( Test-Path "$Path\_ATLAS_" ) 
{ 
	Write-Host "Remove ATLAS Directory..." ;
	Remove-Item "$Path\_ATLAS_" -Force -Recurse ; 
	Write-Host "Finish.`r`n" ; 
}

$ScriptDir = Split-Path $MyInvocation.MyCommand.Path ;

Write-Host "Copy ATLAS Directory..." ;
Copy-Item "$ScriptDir\_ATLAS_" "$Path\" -Force -Recurse ; 
Write-Host "Finish.`r`n" ;

### Configuration #################################################################################

(Get-Content "$Path\_ATLAS_\ATLAS\Web.config") | Foreach-Object {$_ -replace "%Server%",$Server}  	| Out-File "$Path\_ATLAS_\ATLAS\Web.config"
(Get-Content "$Path\_ATLAS_\ATLAS\Web.config") | Foreach-Object {$_ -replace "%AtlasDB%",$AtlasDB}  | Out-File "$Path\_ATLAS_\ATLAS\Web.config"
(Get-Content "$Path\_ATLAS_\ATLAS\Web.config") | Foreach-Object {$_ -replace "%LogDB%",$LogDB}  	| Out-File "$Path\_ATLAS_\ATLAS\Web.config"
(Get-Content "$Path\_ATLAS_\ATLAS\Web.config") | Foreach-Object {$_ -replace "%User%",$User}  		| Out-File "$Path\_ATLAS_\ATLAS\Web.config"
(Get-Content "$Path\_ATLAS_\ATLAS\Web.config") | Foreach-Object {$_ -replace "%Password%",$Password}| Out-File "$Path\_ATLAS_\ATLAS\Web.config"
(Get-Content "$Path\_ATLAS_\ATLAS\Web.config") | Foreach-Object {$_ -replace "%Path%",$Path}  		| Out-File "$Path\_ATLAS_\ATLAS\Web.config"
(Get-Content "$Path\_ATLAS_\ATLAS\Web.config") | Foreach-Object {$_ -replace "%License%",$License}  | Out-File "$Path\_ATLAS_\ATLAS\Web.config"
(Get-Content "$Path\_ATLAS_\ATLAS\Web.config") | Foreach-Object {$_ -replace "%WSPort%",$WSPort}  	| Out-File "$Path\_ATLAS_\ATLAS\Web.config"

(Get-Content "$Path\_ATLAS_\GTSWS\Web.config") | Foreach-Object {$_ -replace "%Server%",$Server}  	| Out-File "$Path\_ATLAS_\GTSWS\Web.config"
(Get-Content "$Path\_ATLAS_\GTSWS\Web.config") | Foreach-Object {$_ -replace "%AtlasDB%",$AtlasDB}  | Out-File "$Path\_ATLAS_\GTSWS\Web.config"
(Get-Content "$Path\_ATLAS_\GTSWS\Web.config") | Foreach-Object {$_ -replace "%LogDB%",$LogDB}  	| Out-File "$Path\_ATLAS_\GTSWS\Web.config"
(Get-Content "$Path\_ATLAS_\GTSWS\Web.config") | Foreach-Object {$_ -replace "%User%",$User}  		| Out-File "$Path\_ATLAS_\GTSWS\Web.config"
(Get-Content "$Path\_ATLAS_\GTSWS\Web.config") | Foreach-Object {$_ -replace "%Password%",$Password}| Out-File "$Path\_ATLAS_\GTSWS\Web.config"
(Get-Content "$Path\_ATLAS_\GTSWS\Web.config") | Foreach-Object {$_ -replace "%Path%",$Path}  		| Out-File "$Path\_ATLAS_\GTSWS\Web.config"
(Get-Content "$Path\_ATLAS_\GTSWS\Web.config") | Foreach-Object {$_ -replace "%License%",$License}  | Out-File "$Path\_ATLAS_\GTSWS\Web.config"
(Get-Content "$Path\_ATLAS_\GTSWS\Web.config") | Foreach-Object {$_ -replace "%WSPort%",$WSPort}  	| Out-File "$Path\_ATLAS_\GTSWS\Web.config"

(Get-Content "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config") | Foreach-Object {$_ -replace "%Server%",$Server}  		| Out-File "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config"
(Get-Content "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config") | Foreach-Object {$_ -replace "%AtlasDB%",$AtlasDB}  	| Out-File "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config"
(Get-Content "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config") | Foreach-Object {$_ -replace "%LogDB%",$LogDB}  		| Out-File "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config"
(Get-Content "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config") | Foreach-Object {$_ -replace "%User%",$User}  			| Out-File "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config"
(Get-Content "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config") | Foreach-Object {$_ -replace "%Password%",$Password}	| Out-File "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config"
(Get-Content "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config") | Foreach-Object {$_ -replace "%Path%",$Path}  			| Out-File "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config"
(Get-Content "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config") | Foreach-Object {$_ -replace "%License%",$License}  	| Out-File "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config"
(Get-Content "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config") | Foreach-Object {$_ -replace "%WSPort%",$WSPort}  		| Out-File "$Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe.config"

(Get-Content "$Path\_ATLAS_\Assembly\AddAssembly.sql") | Foreach-Object {$_ -replace "%Server%",$Server}  	| Out-File "$Path\_ATLAS_\Assembly\AddAssembly.sql"
(Get-Content "$Path\_ATLAS_\Assembly\AddAssembly.sql") | Foreach-Object {$_ -replace "%AtlasDB%",$AtlasDB}  | Out-File "$Path\_ATLAS_\Assembly\AddAssembly.sql"
(Get-Content "$Path\_ATLAS_\Assembly\AddAssembly.sql") | Foreach-Object {$_ -replace "%User%",$User}  		| Out-File "$Path\_ATLAS_\Assembly\AddAssembly.sql"
(Get-Content "$Path\_ATLAS_\Assembly\AddAssembly.sql") | Foreach-Object {$_ -replace "%Path%",$Path}  		| Out-File "$Path\_ATLAS_\Assembly\AddAssembly.sql"

(Get-Content "$Path\_ATLAS_\Queries\Restore Database\AtlasDB.sql") | Foreach-Object {$_ -replace "%AtlasDB%",$AtlasDB}  | Out-File "$Path\_ATLAS_\Queries\Restore Database\AtlasDB.sql"
(Get-Content "$Path\_ATLAS_\Queries\Restore Database\AtlasDB.sql") | Foreach-Object {$_ -replace "%LogDB%",$LogDB}  	| Out-File "$Path\_ATLAS_\Queries\Restore Database\AtlasDB.sql"
(Get-Content "$Path\_ATLAS_\Queries\Restore Database\AtlasDB.sql") | Foreach-Object {$_ -replace "%Path%",$Path}  		| Out-File "$Path\_ATLAS_\Queries\Restore Database\AtlasDB.sql"
             
(Get-Content "$Path\_ATLAS_\Queries\Restore Database\LogDB.sql") | Foreach-Object {$_ -replace "%AtlasDB%",$AtlasDB}  	| Out-File "$Path\_ATLAS_\Queries\Restore Database\LogDB.sql"
(Get-Content "$Path\_ATLAS_\Queries\Restore Database\LogDB.sql") | Foreach-Object {$_ -replace "%LogDB%",$LogDB}  		| Out-File "$Path\_ATLAS_\Queries\Restore Database\LogDB.sql"
(Get-Content "$Path\_ATLAS_\Queries\Restore Database\LogDB.sql") | Foreach-Object {$_ -replace "%Path%",$Path}  		| Out-File "$Path\_ATLAS_\Queries\Restore Database\LogDB.sql"

### Restore Database ##############################################################################

Write-Host "Database Atlas Restored..." ;
Invoke-Sqlcmd -InputFile "$Path\_ATLAS_\Queries\Restore Database\Atlas.sql" -ServerInstance $Server -Username $User -Password $Password -QueryTimeout 120 ;
Write-Host "Finish.`r`n" ; 

Write-Host "Database Log Restored..." ;
Invoke-Sqlcmd -InputFile "$Path\_ATLAS_\Queries\Restore Database\Log.sql" -ServerInstance $Server -Username $User -Password $Password -QueryTimeout 120 ;
Write-Host "Finish.`r`n" ; 

### Assembly Database #############################################################################

Write-Host "Database Assembly Attached..." ;
Invoke-Sqlcmd -InputFile "$Path\_ATLAS_\Assembly\Create&AddFunctions.sql" -ServerInstance $Server -Username $User -Password $Password -QueryTimeout 120 ;
Write-Host "Finish.`r`n" ; 

### IIS Configs ###################################################################################

Import-Module "WebAdministration"  

cd IIS:\

if ( Test-Path "IIS:\AppPools\ATLAS" ) 
{ 
	Write-Host "Remove ATLAS AppPool..." ; 
	Remove-WebAppPool "ATLAS" ; 
	Write-Host "Finish.`r`n" ; 
}

Write-Host "Create ATLAS AppPool..." ;	
New-WebAppPool "ATLAS" -Force | Out-Null ; 
Write-Host "Finish.`r`n" ; 

Set-ItemProperty ("IIS:\AppPools\" + "ATLAS") -name managedRuntimeVersion 		-value "v4.0" ;
Set-ItemProperty ("IIS:\AppPools\" + "ATLAS") -name enable32BitAppOnWin64 		-value "True" ;
Set-ItemProperty ("IIS:\AppPools\" + "ATLAS") -name managedPipelineMode 		-value "Classic" ;
Set-ItemProperty ("IIS:\AppPools\" + "ATLAS") -name processModel.identityType 	-value 2 ;
Set-ItemProperty ("IIS:\AppPools\" + "ATLAS") -name processModel.idleTimeout 	-value "0" ;

if ( Test-Path "IIS:\AppPools\GTSWS" ) 
{ 
	Write-Host "Remove GTSWS AppPool..." ;
	Remove-WebAppPool "GTSWS" ; 
	Write-Host "Finish.`r`n" ;
}

Write-Host "Create GTSWS AppPool..." ;
New-WebAppPool "GTSWS" -Force | Out-Null ; 
Write-Host "Finish.`r`n" ;

Set-ItemProperty ("IIS:\AppPools\" + "GTSWS") -name managedRuntimeVersion 		-value "v4.0" ;
Set-ItemProperty ("IIS:\AppPools\" + "GTSWS") -name enable32BitAppOnWin64 		-value "True" ;
Set-ItemProperty ("IIS:\AppPools\" + "GTSWS") -name managedPipelineMode 		-value "Classic" ;
Set-ItemProperty ("IIS:\AppPools\" + "GTSWS") -name processModel.identityType 	-value 2 ;
Set-ItemProperty ("IIS:\AppPools\" + "GTSWS") -name processModel.idleTimeout 	-value "0" ;

if ( Test-Path "IIS:\Sites\Default Web Site" ) 
{ 
	Write-Host "Remove Default Web Site..." ;
	Remove-Website "Default Web Site" ; 
	Write-Host "Finish.`r`n" ;
}

if ( Test-Path "IIS:\Sites\ATLAS" ) 
{ 
	Write-Host "Remove ATLAS Web Site..." ;
	Remove-Website "ATLAS" ; 
	Write-Host "Finish.`r`n" ;
}

Write-Host "Create ATLAS Web Site..." ;
New-Item "IIS:\Sites\ATLAS" -bindings @{protocol="http";bindingInformation=":$AtlasPort:"} -physicalPath "$Path\_ATLAS_\ATLAS" -Force | Out-Null ;
Write-Host "Finish.`r`n" ;

Set-ItemProperty ("IIS:\Sites\" + "ATLAS") -name applicationPool -value "ATLAS" ;

if ( Test-Path "IIS:\Sites\GTSWS" ) 
{ 
	Write-Host "Remove GTSWS Web Site..." ;
	Remove-Website "GTSWS" ; 
	Write-Host "Finish.`r`n" ;
}

Write-Host "Create GTSWS Web Site..." ;
New-Item "IIS:\Sites\GTSWS" -bindings @{protocol="http";bindingInformation=":$WSPort:"} -physicalPath "$Path\_ATLAS_\GTSWS" -Force | Out-Null ;
Write-Host "Finish.`r`n" ;

Set-ItemProperty ("IIS:\Sites\" + "GTSWS") -name applicationPool -value "GTSWS" ;

Set-WebConfiguration "/system.webServer/security/isapiCgiRestriction/add[@path='%windir%\Microsoft.NET\Framework\v4.0.30319\aspnet_isapi.dll']/@allowed" -value "True" -PSPath:IIS:\ ;
 
Set-WebConfiguration "/system.webServer/security/isapiCgiRestriction/add[@path='%windir%\Microsoft.NET\Framework64\v4.0.30319\aspnet_isapi.dll']/@allowed" -value "True" -PSPath:IIS:\ ;
 
### ELE Install ###################################################################################

Write-Host "Install ELE Service..." ;
Invoke-Item "$Path\_ATLAS_\ELE\installutil.exe /i $Path\_ATLAS_\ELE\GTS.Clock.ELESchedulingService.exe" ;
Write-Host "Finish.`r`n" ;

### Extract Publish ###############################################################################

Write-Host "Extract Publish..." ;
$shell_app=new-object -com shell.application ;
$filename = "Atlas.zip" ;
$zip_file = $shell_app.namespace("$Path\_ATLAS_\ATLAS" + "\$filename") ;
$destination = $shell_app.namespace("$Path\_ATLAS_\ATLAS") ;
$destination.Copyhere($zip_file.items()) ;
Write-Host "Finish.`r`n" ;

###################################################################################################