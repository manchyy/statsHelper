#SingleInstance, force
#If WinActive("ahk_exe main.exe")

;*********
;ui layout
;*********
Gui, Add, Text,x70 , Pick your Class ;class selection
Gui Add, DropDownList, vV1, Dark Lord||Dummy1|Dummy2 

Gui, Add, Text,y+10, Stats per Reset ;stats selection
Gui, Add, DropDownList, vV2, 100|500||1000

Gui, Add, Text, y+10, Number of Resets ;reset input
Gui, Add, Edit, vV3

Gui Add, Button,x25 y+10 w200 h30 gButton1, Confirm ;bottom button

Gui, Add, Text, ,ScrLck = Run                        Pause = Exit

Gui, Show, w250 h210, Stats Helper
return

;******
;labels
;******
Button1:
    Gui, Submit

;*********
;functions
;*********
getTotalPoints(a,b,n)
{
        return (a * (b+n))
}
getStr(num1)
{
    return (num1 * 3/5)
}

getVit()
{
    return 1000
    
}
getEne()
{
    return 300
}
getCmd()
{
    return 300
}

sendReset()
{
    Send, {return}
    Sleep, 150
    SendRaw, /reset
    Sleep, 150
    Send, {return}
}

sendCmd(cmd)
{
    Send, {return}
    Sleep, 150
    SendRaw, /addcmd %cmd%
    Sleep, 150
    Send, {return}
}
sendVit(vit)
{
    Send, {return}
    Sleep, 150
    SendRaw, /addvit %vit%
    Sleep, 150
    Send, {return}
}
sendEne(ene)
{
    Send, {return}
    Sleep, 150
    SendRaw, /addene %ene%
    Sleep, 150
    Send, {return}
}
sendStr(str)
{
    Send, {return}
    Sleep, 150
    SendRaw, /addstr %str%
    Sleep, 150
    Send, {return}
}
sendAgi(agi)
{
    Send, {return}
    Sleep, 150
    SendRaw, /addagi %agi%
    Sleep, 150
    Send, {return}
}


;*************
;main function
;*************
statDistributor(stats,resets)
{
    static globalReset=0
    points := getTotalPoints(stats,resets,globalReset)

    vit:= getVit()
        points -= vit
    ene := getEne()
        points -= ene
    cmd := getCmd()
        points -= cmd
    str := Floor(getStr(points))
        points -= str
    agi := points

    globalReset++

    SetKeyDelay, 40
    sendReset()
    sleep, 2000
    sendCmd(cmd)
    sendVit(vit)
    sendEne(ene)
    sendStr(str)
    sendAgi(agi)
}

;*******
;hotkeys
;*******
sc046::
    statDistributor(V2,V3)
    return
pause::ExitApp