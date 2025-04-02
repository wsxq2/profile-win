# variables
$w='$HOME\Documents\MY\workspace'
$bl='C:\Users\wsxq2\Documents\MY\workspace\wsxq2.github.io\_posts'

# alias
set-alias v nvim
Set-Alias np notepad
set-Alias p pushd
set-Alias po popd


#if(-not [string]::isNullOrEmpty($Alias:wget)){
#	Remove-Item alias:/wget
#}

# function
function vd
{ nvim -d $args 
}
function gs
{ git status $args 
}
function ga
{ git add $args 
}
function git_commit
{ git commit $args 
}
function gpu
{ git push $args 
}
function git_pull
{ git pull $args 
}
function git_checkout
{ git checkout $args 
}

Set-Alias gc git_checkout -Force
Set-Alias gp git_pull -Force
Set-Alias gm git_commit -Force


function run([string] $c_filename)
{
  gcc -std=c99 $c_filename;
  .\a.exe;
}

#adb forward
function af([int] $port)
{
  switch ($port)
  {
    {$_ -eq 1}
    { adb -s 127.0.0.1:62001 forward tcp:50005 tcp:50005
    }
    {$_ -eq 2}
    { 
      #adb connect 127.0.0.1:5555
      adb -s emulator-5554 forward tcp:50005 tcp:50005
			
      #adb logcat -s emulator-5554
    }
    {$_ -eq 3}
    { adb -s 127.0.0.1:5555 forward tcp:50005 tcp:50005 
    }
  }
}

# other
#chcp 65001
#[Reflection.Assembly]::LoadFrom("c:\Windows\System32\taglib-sharp.dll") | out-null
#Import-Module posh-git

function Set-Proxy
{
  param (
    [string]$ProxyUrl,
    [string]$Username,
    [string]$Password
  )

  if ($Username -and $Password)
  {
    $ProxyUrl = "http://$Username`:$Password@$ProxyUrl"
  }

  $env:HTTP_PROXY = $ProxyUrl
  $env:HTTPS_PROXY = $ProxyUrl

  Write-Host "Proxy set to $ProxyUrl"
}

function Remove-Proxy
{
  Remove-Item Env:HTTP_PROXY
  Remove-Item Env:HTTPS_PROXY

  Write-Host "Proxy removed"
}

Set-Proxy http://127.0.0.1:7890

# fnm(fast node manager) is similar to nvm. get node and npm cmd.
fnm env --use-on-cd | Out-String | Invoke-Expression

<#
.SYNOPSIS
获取指定进程的所有直接子进程。

.DESCRIPTION
通过进程ID或进程名查询其所有子进程，支持Windows（WMI）和Linux/macOS（ps命令）。

.PARAMETER ProcessId
目标父进程的ID（优先级高于ProcessName）。

.PARAMETER ProcessName
目标父进程的名称（如"explorer"），若存在多个同名进程则检查所有实例。

.EXAMPLE
Get-ChildProcesses -ProcessId 1234
获取PID为1234的进程的所有子进程。

.EXAMPLE
Get-ChildProcesses -ProcessName "pwsh"
获取所有名为"pwsh"的进程的子进程。
#>
function Get-ChildProcesses
{
  [CmdletBinding()]
  param (
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias("Id")]
    [int]$ProcessId,

    [Parameter(ValueFromPipelineByPropertyName)]
    [string]$ProcessName
  )

  begin
  {
    # 确保至少提供一个参数
    if (-not $ProcessId -and -not $ProcessName)
    {
      Write-Error "必须指定 ProcessId 或 ProcessName 参数。"
      return
    }
  }

  process
  {
    try
    {
      # 如果通过ProcessName查询，获取所有匹配的进程ID
      $targetProcessIds = if ($ProcessName)
      {
        (Get-Process -Name $ProcessName -ErrorAction Stop).Id
      } else
      {
        ,$ProcessId  # 转换为数组
      }

      if (-not $targetProcessIds)
      {
        Write-Error "未找到匹配的进程。"
        return
      }

      # 区分平台处理
      if ($IsWindows -or ($PSVersionTable.PSVersion.Major -le 5))
      {
        # Windows: 使用 WMI 查询 ParentProcessId 匹配的进程
        $childProcesses = Get-CimInstance -ClassName Win32_Process | 
          Where-Object { $_.ParentProcessId -in $targetProcessIds } |
          ForEach-Object {
            $proc = Get-Process -Id $_.ProcessId -ErrorAction SilentlyContinue
            if ($proc)
            {
              [PSCustomObject]@{
                ParentProcessId = $_.ParentProcessId
                Id             = $_.ProcessId
                ProcessName    = $_.Name
                Path           = $_.ExecutablePath
              }
            }
          }
      } else
      {
        # Linux/macOS: 使用 ps 命令递归查找
        $childProcesses = foreach ($pid in $targetProcessIds)
        {
          ps -eo ppid,pid,comm,args | 
            Where-Object { ($_ -split '\s+', 4)[0] -eq $pid } |
            ForEach-Object {
              $fields = $_ -split '\s+', 4
              [PSCustomObject]@{
                ParentProcessId = [int]$fields[0]
                Id             = [int]$fields[1]
                ProcessName    = $fields[2]
                CommandLine    = $fields[3]
              }
            }
        }
      }

      if ($childProcesses)
      {
        $childProcesses
      } else
      {
        Write-Output "未找到子进程。"
      }
    } catch
    {
      Write-Error "查询失败: $_"
    }
  }
}

