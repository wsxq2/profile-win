#NoEnv
#SingleInstance force

CoordMode Mouse, Window

;script control
!Home::Pause
!Esc::ExitApp
Capslock & l::
    SendMessage,0x112,0xF170,2,,Program Manager
return
;Capslock & b::Winset, AlwaysOnTop, , A
Capslock & b::
    ;将当前激活窗口存入变量w
    WinGetActiveTitle, w
    ;对w窗口置顶，Toggle表示在on 与 off 中切换
    Winset, AlwaysOnTop, Toggle, %w%
    ;返回执行
return


ToolTip1s(text){
    ToolTip %text%
    Sleep 1000
    ToolTip
}

test()
{
    ToolTip1s("Hello the World!")
}

~Capslock & t::test()

;start virtualbox VM
~Capslock & v::
    run "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm Arch-Linux --type headless,,Hide
return

;stop VirtualBox VM
~Capslock & s::
    run "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm Arch-Linux acpipowerbutton,,Hide
return

;MTPutty
~Capslock & p::
    run "C:\P rogram Files (x86)\MTPuTTY\mtputty.exe",,Hide
    Sleep 500
    WinWaitActive % "MTPuTTY (Multi-Tabbed PuTTY)"
    Click 93,191
    Send {Enter}

return

;program
^!m::run "D:\Program Files\MATLAB\R2017b\bin\matlab.exe",C:\Users\wsxq2\Documents\MATLAB,Hide

;use AHK editor edit myself
~Capslock & c::run "C:\Program Files\AutoHotkey\SciTE\SciTE.exe" %A_ScriptFullPath%,,

;reload myself to update
~Capslock & r::Reload

;avoid shift+space to switch between 全角 and 半角
+space::return

;avoid ctrl+. to switch between ， and ,
^.::return

::]d::  ; 此热字串通过后面的命令把 "]d" 替换成当前日期和时间.
    FormatTime, CurrentDateTime,,yyyy-MM-dd ; 看起来会像 9/1/2005 3:53 PM 这样
    SendInput %CurrentDateTime%
return

#Hotstring O C
::wg@::wsxq222222@gmail.com
::wio@::wsxq21.55555.io
::wi@::wsxq2.55555.io
::wip@::93.179.114.2
::goo@::www.google.com
::bai@::www.baidu.com
::bin@::www.bing.com
::ar@::192.168.56.24
::lo@::127.0.0.1
::3m@::255.255.255.0
::0@::0.0.0.0
::sj@::17815162858
::sfz@::500222199710044314
::114@::114.114.114.114
::w@::wsxq2@qq.com
::wa@::wangzhiqiang
::a@::anonymous
::sc@::set follow-fork-mode child
::sp@::set print pretty on
::spe0@::set print elements 0
::sdo@::set disassemble-next-line on
::spo@::set pagination off
