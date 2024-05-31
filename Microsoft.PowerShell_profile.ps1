# variables
$w='$HOME\Documents\MY\workspace'
# temp
$a='127.0.0.1:62025'

#alias
# set-alias mkv 'C:\Program Files\MKVToolNix\mkvextract.exe'
# set-alias vi vim
Set-Alias np notepad

if(-not [string]::isNullOrEmpty($Alias:wget)){
	Remove-Item alias:/wget
}

# function
function run([string] $c_filename)
{
    gcc -std=c99 $c_filename;
    .\a.exe;
}

function du([string] $filename)
{
	(ls $filename).length/1mb
}

function Get-SongName(){
	$path="$HOME\Music\"
	$SongNamePath=$path+"SongName.txt"
	$dirnames=(ls  -exclude "GetSongName.ps1","SongName.txt","NullName","StrangeName" $path).name
	'' > $SongNamePath
	foreach ($dirname in $dirnames){
	    "`n"+$dirname+":" >> $SongNamePath
	    (ls $path$dirname\*.mp3).Name >> $SongNamePath
		"`n" >> $SongNamePath
	}
}

#adb forward
function af([int] $port){
	switch ($port){
		{$_ -eq 1} { adb -s 127.0.0.1:62001 forward tcp:50005 tcp:50005}
		{$_ -eq 2} { 
			#adb connect 127.0.0.1:5555
			adb -s emulator-5554 forward tcp:50005 tcp:50005
			
			#adb logcat -s emulator-5554
		}
		{$_ -eq 3} { adb -s 127.0.0.1:5555 forward tcp:50005 tcp:50005 }
	}
}

# other
#chcp 65001
#[Reflection.Assembly]::LoadFrom("c:\Windows\System32\taglib-sharp.dll") | out-null
#Import-Module posh-git
