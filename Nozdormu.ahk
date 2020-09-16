
Secs := 30

F1 = C:\Keep_on\Nozdormu\Nozdormu\NozdormuSettings.txt
ifnotexist,%f1%
  {
  e4=
  (Ltrim Join`r`n
   ����� ���������:
   �������� ��������:
   
   ������ ����������:
   
   
  )
  Fileappend,%e4%`r`n,%f1%
  }
  
  
 Loop, read, C:\Keep_on\Nozdormu\Nozdormu\NozdormuSettings.txt
{
	
	If( InStr( A_LoopReadLine, "����� ���������:") != 0){ 
				
		TimeString := RegExReplace(A_LoopReadLine, "����� ���������: ")
		
	}
	If( InStr( A_LoopReadLine, "�������� ��������: ") != 0){
		PlaylistLink := RegExReplace(A_LoopReadLine, "�������� ��������: ")
	}
} 

target_time = %TimeString%
target = %A_YYYY%%A_MM%%A_DD%%target_time%00

; < comparison should be safe as long as both are in the *exact* same format.
if (target < A_Now)
{   ; time(today) has passed already, so use time(tomorrow)
    EnvAdd, target, 1, d
}

; Calculate how many seconds until the target time is reached.
EnvSub, target, %A_Now%, Seconds

; Sleep until the target is reached.
Sleep, % target * 1000 ; (milliseconds)

SetTimer, CountDown, 1000
MsgBox, 1, WakeUp Protocol start in 30 seconds, Start LoFi playlist in Spotify?, %Secs%
SetTimer, CountDown, Off

IfMsgBox, Ok
	Secs = -1 ;������� ������� ������ � ����� ������� ���� ����� ��������� �������� ������� �������

if( Secs <= 0  ){
 ;���� �������
	Run %PlaylistLink%
	WinActivate, Spotify
	send #{Up}	;������ ��� + �����
	Send {Home} ;�� ������ ���� �������� ��� ��������� ����
	Sleep 10000 ;SET 10 secs
	MouseClick, left,  712,  268 ;������� ����� �� ����� ���� � ������ ���
	return
  }
else
	ExitApp
 
CountDown:
Secs --
WinSetTitle, WakeUp Protocol start in,, WakeUp Protocol start in %Secs% seconds 
Return





       