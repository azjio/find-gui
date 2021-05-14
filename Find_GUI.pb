; план
; 1. Если нет возможности создать ini и соответственно прочитать, то не задаются состояние элементов по умолчанию
; 2. Сейчас Wildcard применяется к имени -name, надо ещё добавить более редкий случай к пути -path -ipath
; 3. Запуск справки своей
; 4. "Добавить ключи" - добавить позицию добавления (редактируемая ком-строка делает эту фичу менее нужной)
; 5. Вкладка "Настройки" и в ней: "Заморозить историю", параметры генерации файлов

; Автор AZJIO 2021.03.24

EnableExplicit

; Определение языка интерфейса и применение

; Определяет язык ОС

Define i, tmp$
Global UserIntLang$, PathLang$
If ExamineEnvironmentVariables()
	While NextEnvironmentVariable()
		If Left(EnvironmentVariableName(), 4) = "LANG"
			; 		   	LANG=ru_RU.UTF-8
			; 		   	LANGUAGE=ru
			UserIntLang$ = Left(EnvironmentVariableValue(), 2)
			Break
		EndIf
	Wend
EndIf
; Debug UserIntLang$

#CountStrLang = 116 ; число строк перевода и соответсвенно массива

Global Dim Lng.s(#CountStrLang)
Lng(1) = "days"
Lng(2) = "minutes"
Lng(3) = "Files"
Lng(4) = "Path"
Lng(5) = "Mask"
Lng(6) = "Not"
Lng(7) = "Except those specified in the mask"
Lng(8) = "Case insensitive"
Lng(9) = "* - any set ,? - one any character"
Lng(10) = "Regular expression"
Lng(11) = "RE engine"
Lng(12) = "type"
Lng(13) = "All"
Lng(14) = "Folders"
Lng(15) = "Other"
Lng(16) = "d blocks"
Lng(17) = "d folder"
Lng(18) = "f file"
Lng(19) = "l symbolic link"
Lng(20) = "File Size"
Lng(21) = "b block, 512 bytes"
Lng(22) = "c byte"
Lng(23) = "w 2 byte words"
Lng(24) = "k kilobytes"
Lng(25) = "M megabyte"
Lng(26) = "G gigabyte"
Lng(27) = "Less, no rounding"
Lng(28) = "Less than specified"
Lng(29) = "More than specified"
Lng(30) = "Date files"
Lng(31) = "Created"
Lng(32) = "Modified"
Lng(33) = "Open"
Lng(34) = "ago"
Lng(35) = "Set"
Lng(36) = "Exactly"
Lng(37) = "Older"
Lng(38) = "Under"
Lng(39) = "Period"
Lng(40) = "-daystart - count from the beginning of the day"
Lng(41) = "Attributes"
Lng(42) = "Set"
Lng(43) = "Only reading"
Lng(44) = "Only executable"
Lng(45) = "Search depth"
Lng(46) = "0 - all, recursive; 1 - current; 2 or more - nesting levels"
Lng(47) = "Add keys:"
Lng(48) = "Flags"
Lng(49) = "-xdev - do not change to other filesystems"
Lng(50) = "-nouser - files not owned by existing users"
Lng(51) = "No entry in / etc / passwd"
Lng(52) = "-L - Access symbolic link objects"
Lng(53) = "The process may take several minutes."
Lng(54) = "-H - like -P, but allows them in com-line"
Lng(55) = "Allows you to specify a symlink to a folder in a com-line"
Lng(56) = "-P - Ignore symbolic links"
Lng(57) = "Shows the links, does not go to the link objects"
Lng(58) = "Output"
Lng(59) = "-printf formatted output"
Lng(60) = "Enable and select a string in the table"
Lng(61) = "Formatting string"
Lng(62) = "The data will be displayed in this format"
Lng(63) = "Preview"
Lng(64) = "Sorting"
Lng(65) = "Sort"
Lng(66) = "Number"
Lng(67) = "In reverse order"
Lng(68) = "Escape {} () | for terminal"
Lng(69) = "In regular expressions, characters will not be treated as part of bash code."
Lng(70) = "Output result"
Lng(71) = "To file"
Lng(72) = "In the clipboard"
Lng(73) = "Add info"
Lng(74) = "Reference"
Lng(75) = "Opens a help page on the Internet (English)"
Lng(76) = "Search/Replacement"
Lng(77) = "Do not use"
Lng(78) = "grep, Search (UTF8)"
Lng(79) = "sed, Replacement (UTF8)"
Lng(80) = "Search"
Lng(81) = "Replacement"
Lng(82) = "Display only files"
Lng(83) = "Display the line number"
Lng(84) = "Globally, all"
Lng(85) = "Extended regexp"
Lng(86) = "Doesn't require screening meta-symbols"
Lng(87) = "Case insensitive"
Lng(88) = "Form com-line"
Lng(89) = "Show in status bar"
Lng(90) = "Copy com-line"
Lng(91) = "Copy to use in terminal"
Lng(92) = "Start"
Lng(93) = "Perform search and return result"
Lng(94) = "Open ini file to add masks and printf"
Lng(95) = "Reset"
Lng(96) = "Open conf."
Lng(97) = "Save conf."
Lng(98) = "Failed to parse the comstr parameter, it is used by default."
Lng(99) = "Choose a path"
Lng(100) = "Done!"
Lng(101) = "No data for execution"
Lng(102) = "Nothing found"
Lng(103) = "Execution time: "
Lng(104) = "Strings: "
Lng(105) = "Done! Result in the clipboard"
Lng(106) = "Set interval"
Lng(107) = "Please enter 2 dates in the format"
Lng(108) = "yyyy.mm.dd-hh:m, separated by 3 dots"
Lng(109) = " h "
Lng(110) = " m "
Lng(111) = " s "
Lng(112) = " ms "
Lng(113) = "Not specified the path"
Lng(114) = "Not specified search data"
Lng(115) = "Turn off the sorting"
Lng(116) = "Turn off the formatted output"

PathLang$ ="/usr/share/locale/" + UserIntLang$ + "/LC_MESSAGES/Find_GUI.txt"



; Если языковой файл существует, то использует его
If FileSize(PathLang$) > 100
	
	If ReadFile(0, PathLang$) ; Если удалось открыть дескриптор файла, то
		i=0
	    While Eof(0) = 0        ; Цикл, пока не будет достигнут конец файла. (Eof = 'Конец файла')
	    	tmp$ =  ReadString(0) ; читаем строку
; 	    	If Left(tmp$, 1) = ";"
; 	    		Continue
; 	    	EndIf
	    	tmp$ = ReplaceString(tmp$ , #CR$ , "") ; коррекция если в Windows
	    	If tmp$ And Left(tmp$, 1) <> ";"
	    		i+1
	    		If i > #CountStrLang ; массив Lng() уже задан, но если строк больше нужного, то не разрешаем лишнее
	    			Break
	    		EndIf
	    		Lng(i) = tmp$
	    	Else
	    		Continue
	    	EndIf
	    Wend
	    CloseFile(0)
	EndIf
; Else
; 	SaveFile_Buff(PathLang$, ?LangFile, ?LangFileend - ?LangFile)
EndIf


#Window_Main = 0

; Гаджеты
Enumeration
	#CmbPath
	#btnOpPa
	#CmbMask
	#btnStart
	#btnComStr
	#btnCopyStr
	#btnReset
	#StatusBar
	#t1
	#t2
	#t3
	#t4
	#t5
	#t6
	#t7
	#t8
	#t9
	#t10
	#t11
	#t12
	#t13
	#t14
	#t15
	#t16
	#t17
	#ChNot
	#ChSimLinkNot
	#ChSimLinkReal
	#ChSimLinkH
	#inpMaxDepth
	#OptType1
	#OptType2
	#OptType3
	#OptType4
	#CmbType
	#CmbSize
	#CntSz
	#OptSize1
	#OptSize2
	#OptSize3
	#CmbAtr
	#ChAtrAny
	#ChAtrR
	#ChAtrX
	#ChRex
	#ChWiCa
	#CmbErgRE
	#Panel
	#ChPrintf
	#ChNoCase
	#ChXdev
	#ChNoUser
	#LFormarStr
	#ChSort
	#ChSrtNum
	#ChSrtInvert
	#ChCB
	#ChSaveF
	#ChEsc
	#LinkHelp
	#LinkHelp2
	#InpMy
	#ChInfo
	#btnOpINI
	#CntDate
	#CntDate2
	#OptDate1
	#OptDate2
	#OptDate3
	#ChDayStart
	#OptExact
	#OptOld
	#OptUnd
	#OptPeriod
	#CmbTime
	#btnSetDate
	#btnSvConf
	#btnOpConf
	#OptNotSR
	#OptGrep
	#OptSed
	#CmbSea
	#CmbRepl
	#ChGlob
	#ChName
	#ChNstr
	#ChNoCase2
	#ChERE
	#Cnv1
	#Cnv2
	#Cnv3
	#Cnv4
	#Cnv5
	#btnExe
	#btnSetFile
; 	#ChForm
; 	#OptFound
EndEnumeration

Structure WindowSize
	w.f
	h.f
EndStructure



Declare.s FormTime(time)
Declare.s Ver()
Declare SaveSetINI(ini$)
Declare ReCombo(ComboID, *NotChange)
Declare.s FormComStr()
Declare ExeComStr(*a)
Declare ForceDirectories(Dir.s)
Declare SaveFile_Buff(File.s, *Buff, Size)
Declare SwitchDate(e)
Declare date_interval()
Declare OpenSetINI(ini$, fo=1)
Declare BtnStart(flag=0)
Declare.s GetFileName(modeF=0, modeN=0)


Global k.WindowSize
Global Co_Items = 30
Global shell$
Global comstr$
Global day$ = Lng(1), min$ = Lng(2), LastDate$
Global FormFileFind$ = "f%n.txt"

Global editor$, browser$
Global NotHold

Global CmbPathNotChange.b = 1
Global CmbMaskNotChange.b = 1
Global CmbReplNotChange.b = 1
Global CmbSeaNotChange.b = 1
Global StatusBarNotChange.b = 1

Define PathHelp$

DataSection
	ini:
	IncludeBinary "sample.ini"
	iniend:
EndDataSection
Global ini$, flINI = 0
ini$ = GetPathPart(ProgramFilename()) + GetFilePart(ProgramFilename(), #PB_FileSystem_NoExtension) + ".ini"


If FileSize(ini$) < 8
	; 	Если рядом с прогой файла нет, то прога не портабельная и ищем конфиг в папках конфигов
	CompilerSelect #PB_Compiler_OS
		CompilerCase #PB_OS_Windows
; 			Чтобы оболочка была легко тестируемой в Windows
			ini$ = GetPathPart(ProgramFilename()) + GetFilePart(ProgramFilename(), #PB_FileSystem_NoExtension) + ".ini"
	    CompilerCase #PB_OS_Linux
			ini$ = GetHomeDirectory() + ".config/Find_GUI/Find_GUI.ini"
	CompilerEndSelect
	If FileSize(ini$) < 8 And ForceDirectories(GetPathPart(ini$)) And SaveFile_Buff(ini$, ?ini, ?iniend - ?ini) And OpenPreferences(ini$) And PreferenceGroup("path")
		WritePreferenceString("1", GetHomeDirectory()) ; если создали ini, то впишем путь на домашнюю пользователя
	EndIf
EndIf

; См. строку 708
; Если программе передаётся путь к папке и/или файлу *.ini, то папка является путём поиска, а  файл является конфигурацией
; это удобно для добавления в контекстное меню файлового менеджера.
Define Param1$ = "", CountParam
CountParam = CountProgramParameters()
If CountParam
	tmp$ = ProgramParameter()
	i = FileSize(tmp$)
	If i = -2 ; если путь является существующий папкой, то в строке 708 применяем его как путь поиска
		Param1$ = tmp$
	; 	If Right(Param1$, 1) <> #PS$
	; 		Param1$ + #PS$
	; 	EndIf
		If CountParam = 2
			tmp$ = ProgramParameter()
			i = FileSize(tmp$)
			If i > 2 And Right(tmp$, 4) = ".ini" ; если путь является файлом с расширением .ini, то назначаем его файлом конфигом
				ini$ = tmp$
			EndIf
		EndIf
	ElseIf i > 2 And Right(tmp$, 4) = ".ini"
		ini$ = tmp$
	EndIf
EndIf

Global w = 680, h = 600
; читаем настройки
If FileSize(ini$) > 3 And OpenPreferences(ini$) And PreferenceGroup("set")
	flINI=1
	Co_Items = ReadPreferenceInteger("Count_Items", Co_Items)
	If Co_Items > 50 Or Co_Items < 2
		Co_Items = 30
		WritePreferenceInteger("Count_Items", Co_Items)
	EndIf
	w = ReadPreferenceInteger("WinWidth", w)
	If w > 1280 Or w < 500
		w = 680
		WritePreferenceInteger("WinWidth", w)
	EndIf
	h = ReadPreferenceInteger("WinHeight", h)
	If h > 1024 Or h < 500
		h = 600
		WritePreferenceInteger("WinHeight", h)
	EndIf
	ClosePreferences()
EndIf


; иконка окну
UseGIFImageDecoder()
; https://www.purebasic.fr/english/viewtopic.php?p=531374#p531374
ImportC ""
	gtk_window_set_icon(a.l,b.l)
EndImport

DataSection
	IconTitle:
	IncludeBinary "Find_GUI.gif"
	IconTitleend:
EndDataSection
CatchImage(0, ?IconTitle)
; Смотрите gtk_window_set_icon_() под OpenWindow
; конец => иконка окну



k\w = w/100
k\h = h/100


; w = k\w * 100
; h = k\h * 100
OpenWindow(#Window_Main, 0, 0, w, h, "Find_GUI" + Ver(), #PB_Window_SystemMenu | #PB_Window_ScreenCentered | #PB_Window_SizeGadget | #PB_Window_MaximizeGadget | #PB_Window_MinimizeGadget)

WindowBounds(#Window_Main, 680, 600, #PB_Ignore, #PB_Ignore)
CompilerIf #PB_Compiler_OS= #PB_OS_Linux
gtk_window_set_icon_(WindowID(#Window_Main), ImageID(0)) ; назначаем иконку в заголовке
CompilerEndIf

PanelGadget(#Panel, 2, 2, w-4, k\h*82)
AddGadgetItem(#Panel, -1, Lng(3))

TextGadget(#t1, 5, 5, 44, 20, Lng(4))
ComboBoxGadget(#CmbPath, k\w * 8, 5, 560, 28, #PB_ComboBox_Editable)
ResizeGadget(#CmbPath, #PB_Ignore, #PB_Ignore, k\w * 83, #PB_Ignore)
; SetGadgetText(#CmbPath, GetHomeDirectory())


ButtonGadget(#btnOpPa, k\w * 92, 5, 40, 30, "...")

; CanvasGadget(#Cnv1, 0, 39, 680, 2)
TextGadget(#t2, 5, k\h * 8, 44, 20, Lng(5))
; FrameGadget(#t2, 5, 36, 530, 107, Lng(5))
ComboBoxGadget(#CmbMask, k\w * 8, k\h*8, 335, 28, #PB_ComboBox_Editable)
ResizeGadget(#CmbMask, k\w * 8, k\h*8, k\w*56, #PB_Ignore)
; AddGadgetItem(#CmbMask, -1, "*.ini")
; AddGadgetItem(#CmbMask, -1, "*.txt")
; AddGadgetItem(#CmbMask, -1, "*.7z")
; AddGadgetItem(#CmbMask, -1, "*.mp?")
; AddGadgetItem(#CmbMask, -1, ".*?\.ini")
; AddGadgetItem(#CmbMask, -1, ".+\.(zip|7z|rar)\z")
; AddGadgetItem(#CmbMask, -1, "^.*?\.(png|jpg|gif)$")
; AddGadgetItem(#CmbMask, -1, ".+?/IMG_[0-9_]+\.jpg")
; AddGadgetItem(#CmbMask, -1, ".+/[а-яё_-]+\.\w+")
; AddGadgetItem(#CmbMask, -1, "^.+/[А-ЯЁа-яё_-]+\.\w+$")
; AddGadgetItem(#CmbMask, -1, ".+/[А-Яа-яЁё]+\.\w\w")
; AddGadgetItem(#CmbMask, -1, ".+/[А-Яа-яЁё]+\.\w+")
; AddGadgetItem(#CmbMask, -1, ".+/[А-Яа-яЁё]+\.\w{2}")
; SetGadgetState(#CmbMask, 10)

CheckBoxGadget(#ChNot, k\w * 65, k\h*7.5, 66, 20, Lng(6))
GadgetToolTip(#ChNot, Lng(7))
CheckBoxGadget(#ChNoCase, k\w * 65, k\h*11, 155, 20, Lng(8))

OptionGadget(#ChWiCa, 10, k\h*14, 90, 20, "Wildcard")
GadgetToolTip(#ChWiCa, Lng(9))
OptionGadget(#ChRex, 10, k\h*17.5, 210, 20, Lng(10))
TextGadget(#t7, k\w*44, k\h * 16.7, k\w*12.6, 20, Lng(11))
ComboBoxGadget(#CmbErgRE, k\w * 58, k\h*15.8, 170, 28)
AddGadgetItem(#CmbErgRE, -1, "findutils")
AddGadgetItem(#CmbErgRE, -1, "awk")
AddGadgetItem(#CmbErgRE, -1, "egrep")
AddGadgetItem(#CmbErgRE, -1, "ed")
AddGadgetItem(#CmbErgRE, -1, "emacs")
AddGadgetItem(#CmbErgRE, -1, "gnu-awk")
AddGadgetItem(#CmbErgRE, -1, "grep")
AddGadgetItem(#CmbErgRE, -1, "posix-awk")
AddGadgetItem(#CmbErgRE, -1, "posix-basic")
AddGadgetItem(#CmbErgRE, -1, "posix-egrep")
AddGadgetItem(#CmbErgRE, -1, "posix-extended")
AddGadgetItem(#CmbErgRE, -1, "posix-minimal-basic")
AddGadgetItem(#CmbErgRE, -1, "sed")

; вертикальная
CanvasGadget(#Cnv1, k\w * 51, k\h*22.6, 2, k\h*54.5)

; горизонтальная
CanvasGadget(#Cnv2, 0, k\h*22.3, k\w*100, 2)
TextGadget(#t6, 5, k\h*23.6, 40, 20, Lng(12))
OptionGadget(#OptType1, 10, k\h*27.5, 60, 20, Lng(13))
OptionGadget(#OptType2, 10, k\h*30.8, 65, 20, Lng(3))
; SetGadgetState(#OptType2, 1)
OptionGadget(#OptType3, 10, k\h*34.2, 65, 20, Lng(14))
OptionGadget(#OptType4, 10, k\h*37.5, 70, 20, Lng(15))

ComboBoxGadget(#CmbType, k\w*14, k\h*37.5, 235, 28)
AddGadgetItem(#CmbType, -1, Lng(16))
AddGadgetItem(#CmbType, -1, "c character")
AddGadgetItem(#CmbType, -1, Lng(17))
AddGadgetItem(#CmbType, -1, Lng(18))
AddGadgetItem(#CmbType, -1, Lng(19))
AddGadgetItem(#CmbType, -1, "p pipe (FIFO)")
AddGadgetItem(#CmbType, -1, "s socket")
AddGadgetItem(#CmbType, -1, "D door (Solaris)")


TextGadget(#t8, k\w * 53, k\h*23.6, 310, 28, Lng(20))
SpinGadget(#CntSz, k\w * 53, k\h*27.5, 100, 28, -1, 10000000, #PB_Spin_Numeric)
ComboBoxGadget(#CmbSize, k\w * 69, k\h*27.5, 145, 28)
AddGadgetItem(#CmbSize, -1, Lng(21))
AddGadgetItem(#CmbSize, -1, Lng(22))
AddGadgetItem(#CmbSize, -1, Lng(23))
AddGadgetItem(#CmbSize, -1, Lng(24))
AddGadgetItem(#CmbSize, -1, Lng(25))
AddGadgetItem(#CmbSize, -1, Lng(26))

OptionGadget(#OptSize1, k\w * 53, k\h*32.5, 180, 20, Lng(27))
OptionGadget(#OptSize2, k\w * 53, k\h*35.8, 180, 20, Lng(28))
OptionGadget(#OptSize3, k\w * 53, k\h*39.2, 180, 20, Lng(29))


; горизонтальная 2
CanvasGadget(#Cnv3, 0, k\h*44.6, k\w*100, 2)
TextGadget(#t11, k\w * 53, k\h*45.5, 310, 28, Lng(30))
OptionGadget(#OptDate1, k\w * 53, k\h*49.1, 180, 20, Lng(31))
OptionGadget(#OptDate2, k\w * 53, k\h*52.5, 180, 20, Lng(32))
SetGadgetState(#OptDate2, 1)
OptionGadget(#OptDate3, k\w * 53, k\h*55.8, 180, 20, Lng(33))
SpinGadget(#CntDate, k\w * 53, k\h*60, 100, 28, -1, 26280000, #PB_Spin_Numeric)

ComboBoxGadget(#CmbTime, k\w * 69, k\h*62.2, 95, 28)
AddGadgetItem(#CmbTime, -1, day$)
AddGadgetItem(#CmbTime, -1, min$)
SetGadgetState(#CmbTime , 0)
TextGadget(#t10, k\w * 84, k\h*63, 100, 20, Lng(34))


ButtonGadget(#btnSetDate, k\w * 84, k\h*66.3, 80, 28, Lng(35))

; OptionGadget(#OptExact, 365, 385, 180, 20, Lng(36))
; OptionGadget(#OptOld, 365, 405, 180, 20, Lng(37))
; OptionGadget(#OptUnd, 365, 425, 180, 20, Lng(38))
; OptionGadget(#OptPeriod, 365, 445, 180, 20, Lng(39))
; OptionGadget(#OptUnd, 455, 385, 180, 20, Lng(38))
; OptionGadget(#OptPeriod, 455, 405, 180, 20, Lng(39))

OptionGadget(#OptExact, k\w * 83, k\h*47.5, 100, 20, Lng(36))
OptionGadget(#OptOld, k\w * 83, k\h*50.8, 100, 20, Lng(37))
OptionGadget(#OptUnd, k\w * 83, k\h*54.1, 100, 20, Lng(38))
OptionGadget(#OptPeriod, k\w * 83, k\h*57.5, 100, 20, Lng(39))

SpinGadget(#CntDate2, k\w * 53, k\h*65.8, 100, 28, -1, 26280000, #PB_Spin_Numeric)
DisableGadget(#CntDate2 , 1)
; CheckBoxGadget(#ChDayStart, 10, 30, 390, 20, Lng(40))
CheckBoxGadget(#ChDayStart, k\w * 53, k\h*71.7, 250, 20, Lng(40))
; GadgetToolTip(#ChDayStart, "Используется совместно с датами, делает период не 24-часа")



TextGadget(#t12, 5, k\h*45.5, 340, 28, Lng(41))
OptionGadget(#ChAtrAny, 10, k\h*49.2, 85, 20, Lng(42))
OptionGadget(#ChAtrR, 10, k\h*52.5, 180, 20, Lng(43))
OptionGadget(#ChAtrX, 10, k\h*55.8, 180, 20, Lng(44))

ComboBoxGadget(#CmbAtr, k\w*14, k\h*48, 235, 28)
; AddGadgetItem(#CmbAtr, -1, "u=rwx,g=rwxs,o=rwxt")
; AddGadgetItem(#CmbAtr, -1, "-u=rwx,g=rwxs,o=rwxt")
; AddGadgetItem(#CmbAtr, -1, "/u=rwx,g=rwxs,o=rwxt")


TextGadget(#t3, 5, k\h*63.3, 150, 20, Lng(45))
SpinGadget(#inpMaxDepth, k\w * 23, k\h*62.5, 80, 28, 0, 260, #PB_Spin_Numeric)
GadgetToolTip(#inpMaxDepth, Lng(46))

TextGadget(#t9, 5, k\h*69, 150, 20, Lng(47))
StringGadget(#InpMy, k\w * 23, k\h*68.3, k\w*27, 28, "")

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i


AddGadgetItem(#Panel, -1, Lng(48))
CheckBoxGadget(#ChXdev, 10, 10, 390, 20, Lng(49))
CheckBoxGadget(#ChNoUser, 10, k\h * 5, 510, 20, Lng(50))
GadgetToolTip(#ChNoUser, Lng(51))

CheckBoxGadget(#ChSimLinkReal, 5, k\h * 22.5, 390, 20, Lng(52))
GadgetToolTip(#ChSimLinkReal, Lng(53))
CheckBoxGadget(#ChSimLinkH, 5, k\h * 25.8, 390, 20, Lng(54))
GadgetToolTip(#ChSimLinkH, Lng(55))
CheckBoxGadget(#ChSimLinkNot, 5, k\h * 29.2, 390, 20, Lng(56))
GadgetToolTip(#ChSimLinkNot, Lng(57))

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

AddGadgetItem(#Panel, -1, Lng(58))
CheckBoxGadget(#ChPrintf, 10, 10, 260, 20, Lng(59))
GadgetToolTip(#ChPrintf, Lng(60))
ListIconGadget(#LFormarStr, 5, k\h * 5.8, k\w * 90, k\h * 25, Lng(61), k\w * 43)
GadgetToolTip(#LFormarStr, Lng(62))
AddGadgetColumn(#LFormarStr, 1, Lng(63), k\w * 43)
; AddGadgetItem(#LFormarStr, -1, "%TF\t%s\t%p\n" + #LF$ + "yyyy-mm-dd size /path")
; AddGadgetItem(#LFormarStr, -1, "%s\t%TF\t%p\n" + #LF$ + "size yyyy-mm-dd /path")
; AddGadgetItem(#LFormarStr, 1, "")

TextGadget(#t4, 5, k\h * 31.6, 240, 28, Lng(64))
CheckBoxGadget(#ChSort, 10, k\h * 35, 180, 20, Lng(65))
CheckBoxGadget(#ChSrtNum, 10, k\h * 38.3, 180, 20, Lng(66))
; GadgetToolTip(#ChSrtNum, "Левая часть текста определяется как число")
CheckBoxGadget(#ChSrtInvert, 10, k\h * 41.6, 180, 20, Lng(67))
; GadgetToolTip(#ChSrtInvert, "Полезно для дат и размеров")


CheckBoxGadget(#ChEsc, 10, k\h * 50, 280, 20, Lng(68))
GadgetToolTip(#ChEsc, Lng(69))
                      


TextGadget(#t5, 5, k\h * 58.3, 240, 28, Lng(70))
OptionGadget(#ChSaveF, 10, k\h * 61.6, 160, 20, Lng(71))
OptionGadget(#ChCB, 10, k\h * 65, 160, 20, Lng(72))
ButtonGadget(#btnSetFile, k\w * 24, k\h*60.6, 80, 28, Lng(35))

CheckBoxGadget(#ChInfo, 10, k\h * 68.3, 160, 20, Lng(73))
; GadgetToolTip(#ChInfo, "Выводит информацию о числе строк и времени выполнения")


HyperLinkGadget(#LinkHelp, k\w * 73, k\h * 60.3, 105, 28, Lng(74) + " (find)", RGB(0, 155,255), #PB_HyperLink_Underline)
GadgetToolTip(#LinkHelp, Lng(75))
HyperLinkGadget(#LinkHelp2, k\w * 73, k\h * 64.3, 105, 28, Lng(74) + " (Find_GUI)", RGB(0, 155,255))
TextGadget(#t17, k\w * 73, k\h * 69.3, 140, 28, "AZJIO 2021.05.07")


; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i


AddGadgetItem(#Panel, -1, Lng(76))

OptionGadget(#OptNotSR, 10, 5, 160, 20, Lng(77))
OptionGadget(#OptGrep, 10, k\h * 4.2, 160, 20, Lng(78))
OptionGadget(#OptSed, 10, k\h * 7.5, 160, 20, Lng(79))


TextGadget(#t13, 5, k\h * 11.6, 70, 20, Lng(80))
ComboBoxGadget(#CmbSea, k\w * 11, k\h * 11.6, w - k\w * 11-10, 28, #PB_ComboBox_Editable)

TextGadget(#t14, 5, k\h * 17.5, 70, 20, Lng(81))
ComboBoxGadget(#CmbRepl, k\w * 11, k\h * 17.5, w - k\w * 11-10, 28, #PB_ComboBox_Editable)


TextGadget(#t15, 5, k\h * 24.3, 340, 28, "grep")
CheckBoxGadget(#ChName, 10, k\h * 27.5, 190, 20, Lng(82))
CheckBoxGadget(#ChNstr, 10, k\h * 30.8, 190, 20, Lng(83))


TextGadget(#t16, k\w * 53, k\h * 24.3, 310, 28, "sed")
CheckBoxGadget(#ChGlob, k\w * 53, k\h * 27.5, 190, 20, Lng(84))

CheckBoxGadget(#ChERE, 5, k\h * 45, 190, 20, Lng(85))
GadgetToolTip(#ChERE, Lng(86))
CheckBoxGadget(#ChNoCase2, 5, k\h * 48.3, 190, 20, Lng(87))


; горизонтальная 3
CanvasGadget(#Cnv4, 0, k\h * 44.6, k\w*100, 2)
; вертикальная
CanvasGadget(#Cnv5, k\w * 51, k\h * 23.6, 2, k\h * 21)




; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i


For i=#Cnv1 To #Cnv1+4
	If StartDrawing(CanvasOutput(i))
		FillArea(0, 0, -1, $888888) 
		StopDrawing()
	EndIf
Next

CloseGadgetList() ; закрывает добавление вкладок

ButtonGadget(#btnComStr, 10, k\h*82.5, 230, 30, Lng(88))
GadgetToolTip(#btnComStr, Lng(89))
ButtonGadget(#btnCopyStr, 10, k\h*88.3, 230, 30, Lng(90))
GadgetToolTip(#btnCopyStr, Lng(91))

; CheckBoxGadget(#ChForm, k\w * 35.5, k\h*82.5, 90, 20, "из строки состояния")
; GadgetToolTip(#ChForm, "Позволяет внести правки команды перед выполнением")
ButtonGadget(#btnStart, k\w * 44, k\h*87.3, 110, 40, Lng(92))
GadgetToolTip(#btnStart, Lng(93))
ButtonGadget(#btnOpINI, k\w * 92, k\h*82.5, 40, 30, "ini")
GadgetToolTip(#btnOpINI, Lng(94))
ButtonGadget(#btnReset, k\w * 86, k\h*88.3, 90, 30, Lng(95))
ButtonGadget(#btnOpConf, k\w * 64, k\h*82.5, 145, 30, Lng(96))
ButtonGadget(#btnSvConf, k\w * 64, k\h*88.3, 145, 30, Lng(97))
; HyperLinkGadget(#StatusBar, 5, k\h - 22, k\w-10, 20, "", -1) ; ссылка не плохо но выравнивание по центру не айс
; StringGadget(#StatusBar, 5, k\h * 94.5, k\w * 99, 20, "")
ComboBoxGadget(#StatusBar, 5, k\h * 94.5, 560, 28, #PB_ComboBox_Editable)
ResizeGadget(#StatusBar, #PB_Ignore, #PB_Ignore, k\w * 91, #PB_Ignore)
ButtonGadget(#btnExe, k\w * 92.5, k\h * 94.3, 40, 30, ">")
; StringGadget(#StatusBar, 5, k\h - 22, k\w-10, 20, "", #PB_Text_Border) ; редактируемый вариант высота играет от размера шрифта
; i = GadgetHeight(#StatusBar, #PB_Gadget_ActualSize)
; Debug i
; ResizeGadget(#StatusBar, #PB_Ignore, #PB_Ignore, #PB_Ignore, k\h - i)
; SetGadgetColor(#StatusBar, #PB_Gadget_BackColor, $004444) ; подсветили чтобы понятно было где элемент
SetActiveGadget(#btnStart)

OpenSetINI(ini$)
If Param1$
	SetGadgetText(#CmbPath , Param1$)
EndIf




i = FindString(comstr$, " ")
If i
	shell$ = Mid(comstr$, 0, i-1)
	comstr$ = Mid(comstr$, i+1)
Else
	MessageRequester("", Lng(98))
	shell$ = "bash"
	comstr$ = ~"-c \"find %s 2>&1\""
EndIf
; Debug "|" + shell$ + "|"
; Debug "|" + comstr$ + "|"


Repeat
	Select WaitWindowEvent()
		Case #PB_Event_SizeWindow
			w = WindowWidth(#Window_Main)
			h = WindowHeight(#Window_Main)
			k\w = w/100
			k\h = h/100
			ResizeGadget(#Panel, #PB_Ignore, #PB_Ignore, k\w * 100 - 4, k\h*82)
			ResizeGadget(#CmbPath, k\w * 8, #PB_Ignore, k\w * 83, #PB_Ignore)
			ResizeGadget(#btnOpPa, k\w * 92, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#t2, #PB_Ignore, k\h*8, #PB_Ignore, #PB_Ignore)
			
			ResizeGadget(#StatusBar, #PB_Ignore, k\h * 94.5, k\w * 91, #PB_Ignore)
			ResizeGadget(#btnExe, k\w * 92.5, k\h * 94.3, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#ChForm, k\w * 35.5, k\h*82.5, #PB_Ignore, #PB_Ignore)
; 			кнопки
			ResizeGadget(#btnStart, k\w * 44, k\h*87.3, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#btnOpINI, k\w * 92, k\h*82.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#btnReset, k\w * 86, k\h*88.3, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#btnOpConf, k\w * 64, k\h*82.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#btnSvConf, k\w * 64, k\h*88.3, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#btnComStr, #PB_Ignore, k\h*82.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#btnCopyStr, #PB_Ignore, k\h*88.3, #PB_Ignore, #PB_Ignore)
			
; 			маска
			ResizeGadget(#t2, #PB_Ignore, k\h*8, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#CmbMask, k\w * 8, k\h*8, k\w*56, #PB_Ignore)
			
			ResizeGadget(#ChNot, k\w * 65, k\h*7.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChNoCase, k\w * 65, k\h*11, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChWiCa, #PB_Ignore, k\h*14, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChRex, #PB_Ignore, k\h*17.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#t7, k\w*44, k\h * 16.7, k\w*12.6, #PB_Ignore)
			ResizeGadget(#CmbErgRE, k\w * 58, k\h*15.8, #PB_Ignore, #PB_Ignore)

			
			
; 			размеры и дата
			ResizeGadget(#t8, k\w * 53, k\h*23.6, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#CntSz, k\w * 53, k\h*27.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#CmbSize, k\w * 69, k\h*27.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptSize1, k\w * 53, k\h*32.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptSize2, k\w * 53, k\h*35.8, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptSize3, k\w * 53, k\h*39.2, #PB_Ignore, #PB_Ignore)
			
			ResizeGadget(#Cnv3, 0, k\h*44.6, k\w*100, #PB_Ignore)
			
			ResizeGadget(#t11, k\w * 53, k\h*45.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptDate1, k\w * 53, k\h*49.1, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptDate2, k\w * 53, k\h*52.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptDate3, k\w * 53, k\h*55.8, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#CntDate, k\w * 53, k\h*60, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#CmbTime, k\w * 69, k\h*62.2, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#t10, k\w * 84, k\h*63, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#btnSetDate, k\w * 84, k\h*66.3, #PB_Ignore, #PB_Ignore)
			
			ResizeGadget(#OptExact, k\w * 83, k\h*47.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptOld, k\w * 83, k\h*50.8, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptUnd, k\w * 83, k\h*54.1, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptPeriod, k\w * 83, k\h*57.5, #PB_Ignore, #PB_Ignore)
			
			ResizeGadget(#CntDate2, k\w * 53, k\h*65.8, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChDayStart, k\w * 53, k\h*71.7, #PB_Ignore, #PB_Ignore)
			


; 			типы и атрибуты, только высота
			ResizeGadget(#Cnv1, k\w * 51, k\h*22.6, #PB_Ignore, k\h*54.5)
			ResizeGadget(#Cnv2, #PB_Ignore, k\h * 22.3, k\w*100, #PB_Ignore)
			ResizeGadget(#t6, #PB_Ignore, k\h * 23.6, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptType1, #PB_Ignore, k\h * 27.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptType2, #PB_Ignore, k\h * 30.8, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptType3, #PB_Ignore, k\h * 34.2, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptType4, #PB_Ignore, k\h * 37.5, #PB_Ignore, #PB_Ignore)
			
			ResizeGadget(#CmbType, k\w*14, k\h*37.5, #PB_Ignore, #PB_Ignore)
			
			ResizeGadget(#t12, #PB_Ignore, k\h * 45.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChAtrAny, #PB_Ignore, k\h * 49.2, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChAtrR, #PB_Ignore, k\h * 52., #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChAtrX, #PB_Ignore, k\h * 55.8, #PB_Ignore, #PB_Ignore)
			
			ResizeGadget(#CmbAtr, k\w*14, k\h*48, #PB_Ignore, #PB_Ignore)
			
			ResizeGadget(#t3, #PB_Ignore, k\h * 63.3, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#inpMaxDepth, k\w * 23, k\h*62.5, #PB_Ignore, #PB_Ignore)
			
			ResizeGadget(#t9, #PB_Ignore, k\h * 69, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#InpMy, k\w * 23, k\h*68.3, k\w*27, #PB_Ignore)
			
			
; 			340
; 			ResizeGadget(#Cnv2, #PB_Ignore, #PB_Ignore, k\w, #PB_Ignore)
; 			ResizeGadget(#Cnv3, #PB_Ignore, #PB_Ignore, k\w, #PB_Ignore)
; 			ResizeGadget(#Cnv1, k\w * 51, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			i = k\w * 53
; 			ResizeGadget(#t8, k\w * 53, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#CntSz, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#OptSize1, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#OptSize2, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#OptSize3, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#t11, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#OptDate1, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#OptDate2, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#OptDate3, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#CntDate, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#CntDate2, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; ; 			ResizeGadget(#ChDayStart, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			i = k\w * 69
; 			ResizeGadget(#CmbSize, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#CmbTime, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			i = k\w * 84
; 			ResizeGadget(#t10, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#btnSetDate, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			i = k\w * 83
; 			ResizeGadget(#OptExact, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#OptOld, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#OptUnd, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
; 			ResizeGadget(#OptPeriod, i, #PB_Ignore, #PB_Ignore, #PB_Ignore)
			
; 			Флаги
			ResizeGadget(#ChNoUser, #PB_Ignore, k\h * 5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChSimLinkReal, #PB_Ignore, k\h * 22.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChSimLinkH, #PB_Ignore, k\h * 25.8, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChSimLinkNot, #PB_Ignore, k\h * 29.2, #PB_Ignore, #PB_Ignore)
			
; 			вывод
			ResizeGadget(#LFormarStr, #PB_Ignore, k\h * 5.8, k\w * 90, k\h * 25)
			SetGadgetItemAttribute(#LFormarStr, 0, #PB_ListIcon_ColumnWidth, k\w * 43, 0)
			SetGadgetItemAttribute(#LFormarStr, 0, #PB_ListIcon_ColumnWidth, k\w * 43, 1)
			
			ResizeGadget(#t4, #PB_Ignore, k\h * 31.6, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChSort, #PB_Ignore, k\h * 35, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChSrtNum, #PB_Ignore, k\h * 38.3, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChSrtInvert, #PB_Ignore, k\h * 41.6, #PB_Ignore, #PB_Ignore)
			
			ResizeGadget(#ChEsc, #PB_Ignore, k\h * 50, #PB_Ignore, #PB_Ignore)
			
			ResizeGadget(#t5, #PB_Ignore, k\h * 58.3, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChSaveF, #PB_Ignore, k\h * 61.6, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChCB, #PB_Ignore, k\h * 65, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChInfo, #PB_Ignore, k\h * 68.3, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#btnSetFile, k\w * 24, k\h*60.6, #PB_Ignore, #PB_Ignore)
			
			ResizeGadget(#LinkHelp, k\w * 73, k\h * 60.3, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#LinkHelp2, k\w * 73, k\h * 64.3, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#t17, k\w * 73, k\h * 69.3, #PB_Ignore, #PB_Ignore)



			
; 			поиск / замена
; 			ResizeGadget(#OptNotSR, #PB_Ignore, #PB_Ignore, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptGrep, #PB_Ignore, k\h * 4.2, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#OptSed, #PB_Ignore, k\h * 7.5, #PB_Ignore, #PB_Ignore)
			
			ResizeGadget(#t13, #PB_Ignore, k\h * 11.6, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#CmbSea, k\w * 11, k\h * 11.6, w - k\w * 11-10, #PB_Ignore)
			
			ResizeGadget(#t14, #PB_Ignore, k\h * 17.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#CmbRepl, k\w * 11, k\h * 17.5, w - k\w * 11-10, #PB_Ignore)
			
			ResizeGadget(#t15, #PB_Ignore, k\h * 24.3, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChName, #PB_Ignore, k\h * 27.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChNstr, #PB_Ignore, k\h * 30.8, #PB_Ignore, #PB_Ignore)
			
			ResizeGadget(#t16, k\w * 53, k\h * 24.3, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChGlob, k\w * 53, k\h * 27.5, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChERE, #PB_Ignore, k\h * 45, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#ChNoCase2, #PB_Ignore, k\h * 48.3, #PB_Ignore, #PB_Ignore)
			ResizeGadget(#Cnv4, #PB_Ignore, k\h * 44.6, k\w*100, #PB_Ignore)
			ResizeGadget(#Cnv5, k\w * 51, k\h * 23.6, #PB_Ignore, k\h * 21)
			
; 			перерисовка закрашивания в линиях
			If StartDrawing(CanvasOutput(#Cnv2))
				Box(0, 0, k\w*100, 2, $888888)
				StopDrawing()
			EndIf
			If StartDrawing(CanvasOutput(#Cnv3))
				Box(0, 0, k\w*100, 2, $888888)
				StopDrawing()
			EndIf
			If StartDrawing(CanvasOutput(#Cnv4))
				Box(0, 0, k\w*100, 2, $888888)
				StopDrawing()
			EndIf
			If StartDrawing(CanvasOutput(#Cnv5))
				Box(0, 0, 2, k\h * 21, $888888)
				StopDrawing()
			EndIf
			If StartDrawing(CanvasOutput(#Cnv1))
				Box(0, 0, 2, k\h * 54.5, $888888)
				StopDrawing()
			EndIf
			

			
		Case #PB_Event_Gadget
			Select EventGadget()
; 				Case #Cnv2
; 					If EventType() = #PB_EventType_Resize
; 						If StartDrawing(CanvasOutput(#Cnv2))
; 							Box(0, 0, k\w*100, 2, $888888)
; 							StopDrawing()
; 						EndIf
; 					EndIf
				Case #CmbPath
					If CmbPathNotChange And EventType() = #PB_EventType_Change
						CmbPathNotChange = 0
					EndIf
				Case #CmbMask
					If CmbMaskNotChange And EventType() = #PB_EventType_Change
						CmbMaskNotChange = 0
					EndIf
				Case #CmbRepl
					If CmbReplNotChange And EventType() = #PB_EventType_Change
						CmbReplNotChange = 0
					EndIf
				Case #CmbSea
					If CmbSeaNotChange And EventType() = #PB_EventType_Change
						CmbSeaNotChange = 0
					EndIf
				Case #StatusBar
					If StatusBarNotChange And EventType() = #PB_EventType_Change
						StatusBarNotChange = 0
					EndIf
				Case #btnComStr
					SetGadgetText(#StatusBar, "find " + FormComStr())
					If NotHold
						ReCombo(#CmbPath, @CmbPathNotChange)
						ReCombo(#CmbMask, @CmbMaskNotChange)
						ReCombo(#CmbRepl, @CmbReplNotChange)
						ReCombo(#CmbSea, @CmbSeaNotChange)
					EndIf
				Case #btnCopyStr
					; 					Result\s = GetGadgetText(#StatusBar)
					SetClipboardText(GetGadgetText(#StatusBar))
					
					
					
					
; 				Старт
				Case #btnStart
					BtnStart()
				Case #btnExe
					BtnStart(1)
				Case #btnOpPa
					tmp$ = GetGadgetText(#CmbPath)
					If tmp$ = ""
						tmp$ + "/"
					EndIf
					tmp$ = PathRequester(Lng(99), tmp$)
					If tmp$
						SetGadgetText(#CmbPath, tmp$)
					EndIf
				Case #btnReset
					
					SetGadgetState(#ChWiCa, 1)
					SetGadgetState(#ChSort, 0)
					; 					SetGadgetState(#ChSrtNum, 1)
					; 					SetGadgetState(#ChSrtInvert, 1)
					SetGadgetState(#ChPrintf, 0)
					SetGadgetState(#ChSaveF, 1)
					SetGadgetState(#ChEsc, 0)
					SetGadgetState(#ChNot, 0)
					SetGadgetState(#ChNoCase, 0)
					SetGadgetState(#CntSz, -1)
					SetGadgetState(#CntDate, -1)
					SetGadgetState(#ChAtrAny, 1)
					SetGadgetState(#OptType2, 1)
					SetGadgetText(#StatusBar, "")
					SetGadgetText(#InpMy, "")
					SetGadgetText(#CmbTime, day$)
					SetGadgetText(#CmbErgRE, "")
					SetGadgetText(#CmbSize, "")
					SetGadgetText(#CmbType, "")
					SetGadgetText(#CmbMask, "")
					SetGadgetState(#OptExact, 1)
					SetGadgetState(#OptDate2, 1)
					SetGadgetState(#CntDate, -1)
					SetGadgetState(#CntDate2, -1)
					SetGadgetState(#OptSize1, 1)
					SetGadgetState(#CmbAtr, 0)

					SetGadgetState(#ChXdev, 0)
					SetGadgetState(#ChNoUser, 0)
					SetGadgetState(#ChSimLinkReal, 0)
					SetGadgetState(#ChSimLinkH, 0)
					SetGadgetState(#ChSimLinkNot, 0)
					
					SetGadgetState(#OptNotSR, 1)
					
; 					SetGadgetState(#ChForm, 0)
					
					
				Case #btnOpConf
					tmp$ = OpenFileRequester(Lng(99), ini$, "ini (*.ini)" , 0)
					If tmp$
						OpenSetINI(tmp$, 0)
					EndIf
					
				Case #btnSvConf
					tmp$ = SaveFileRequester(Lng(99) , ini$ , "ini (*.ini)" , 0)
					If tmp$
						If FileSize(tmp$) < 3 And CreateFile(0 , tmp$)
							WriteStringFormat(0, #PB_UTF8)
							CloseFile(0)
						EndIf
						; 						SaveFile_Buff(tmp$, ?ini, ?iniend - ?ini)
						SaveSetINI(tmp$)
					EndIf
				Case #ChNstr
					SetGadgetState(#ChName, 0)
				Case #ChName
					SetGadgetState(#ChNstr, 0)
				Case #btnOpINI
					RunProgram(editor$, ini$, "")
				Case #LinkHelp
					RunProgram(browser$, "https://man.archlinux.org/man/find.1", "")
				Case #LinkHelp2
					; 							Справка
					tmp$ = UserIntLang$
					PathHelp$ = "/usr/share/help/" + tmp$ + "/find_gui/index.html"
					If FileSize(PathHelp$) < 0
						tmp$ = "ru"
						PathHelp$ = "/usr/share/help/" + tmp$ + "/find_gui/index.html"
					EndIf
					If FileSize(PathHelp$) > 0
						RunProgram(browser$, PathHelp$, GetPathPart(PathHelp$))
						; RunProgram("firefox", PathHelp$, GetPathPart(PathHelp$)) ; что если firefox не браузер по умолчанию?
						; тут наверно преобразование HTML в формат man, чтобы использовать и без флага --html=firefox
						; RunProgram("man", "--html=firefox " + PathHelp$, GetPathPart(PathHelp$))
					
					EndIf
				Case #btnSetFile
					tmp$ = InputRequester(Lng(35), "%n = index", FormFileFind$)
					If tmp$ <> ""
						FormFileFind$ = tmp$
; 						создаём каталог если не существует
						If FindString(FormFileFind$, "/")
							tmp$ = GetPathPart(FormFileFind$)
							If FileSize(tmp$) = -1
								ForceDirectories(tmp$) 
							EndIf
						EndIf
					EndIf
				Case #btnSetDate
					date_interval()
				Case #CntDate2
					SwitchDate(#CntDate2)
				Case #CntDate
					SwitchDate(#CntDate)
					; 					tmp$ = GetGadgetText(#CntDate)
					; 					tmp_2$ = GetGadgetText(#CntDate2)
					; 					If GetGadgetText(#CmbTime) = day$
					; 						i=2
					; 					Else
					; 						i=1
					; 					EndIf
					; 					If (Val(tmp_2$) - Val(tmp$)) < i
					; 						SetGadgetText(#CntDate2, Str(Val(tmp_2$)+1))
					; 					EndIf
				Case #OptPeriod
					DisableGadget(#CntDate2 , 0)
				Case #OptExact, #OptOld, #OptUnd
					DisableGadget(#CntDate2 , 1)
			EndSelect
		Case #PB_Event_CloseWindow
			SaveSetINI(ini$)
			CloseWindow(#Window_Main)
			Break
	EndSelect
ForEver


End




; проверка версии и соответственно наличия проги
Procedure BtnStart(flag=0)
	Protected StartTime, info$, CountString, tmp$, Result.string

	; SetGadgetText(#StatusBar, "Выполняется поиск...") ; событие выполняется когда окно разморозилось, поэтому в нём нет смысла
	If flag
		Result\s = GetGadgetText(#StatusBar)
		If Result\s = ""
			MessageRequester(Lng(100), Lng(101))
			ProcedureReturn
		ElseIf Left(Result\s, 5) = "find "
			Result\s = Mid(Result\s, 6)
		EndIf
	Else
		Result\s = FormComStr()
		SetGadgetText(#StatusBar, "find " + Result\s)
	EndIf
	If NotHold
		ReCombo(#CmbPath, @CmbPathNotChange)
		ReCombo(#CmbMask, @CmbMaskNotChange)
		ReCombo(#CmbRepl, @CmbReplNotChange)
		ReCombo(#CmbSea, @CmbSeaNotChange)
		ReCombo(#StatusBar, @StatusBarNotChange)
	EndIf
; 					Debug "-" + Result\s + "-"
	; 					tmp$ = "find " + Result\s
	StartTime=ElapsedMilliseconds() ; метка времени, запоминаем
									; 					ExeComStr("find", Result\s)
	ExeComStr(@Result)
	StartTime=ElapsedMilliseconds()-StartTime ; сохраняем разницу
											  ; 					SetGadgetText(#StatusBar, tmp$)
	If Result\s = ""
		; 						SetClipboardText(Lng(102))
		MessageRequester(Lng(100), Lng(102))
		ProcedureReturn
	EndIf
	
	
	; 					Добавить информацию в вывод
	If GetGadgetState(#ChInfo) = #PB_Checkbox_Checked
		info$ = FormTime(StartTime)
		CountString = CountString(Result\s , #LF$)
		; 						info$ = "Время выполнения:" + Str(StartTime) + " мсек" + #LF$ + "Строк:" + Str(CountString) + #LF$ + "_______________________" + #LF$ + #LF$
		info$ = Lng(103) + info$ + #LF$ + Lng(104) + Str(CountString) + #LF$ + "_______________________" + #LF$ + #LF$
		Result\s = info$ + Result\s
	Else
		CountString = 0
		info$ = ""
	EndIf
	
	If GetGadgetState(#ChCB) = #PB_Checkbox_Checked
		SetClipboardText(Result\s)
		MessageRequester(Lng(100), info$ + Lng(105))
	ElseIf GetGadgetState(#ChSaveF) = #PB_Checkbox_Checked
; 		tmp$ = GetTemporaryDirectory() + "find_" + Str(Random(2147483647)) + ".txt"
		tmp$ = GetFileName()
		If OpenFile(0, tmp$, #PB_UTF8)
			WriteStringFormat(0, #PB_UTF8)
			WriteString(0, Result\s)
			CloseFile(0)
			RunProgram(editor$, tmp$, "")
			; 							MessageRequester(Lng(100), Lng(100))
		Else
			SetClipboardText(Result\s)
			MessageRequester(Lng(100), info$ + Lng(105))
		EndIf
	EndIf
; 	Result\s=""
; 	tmp$=""
	
	; 	ProcedureReturn res$
EndProcedure

Procedure.s GetFileName(modeF=0, modeN=0)
	Protected tmp$, path$ = "", SeaPos
	Static n=0 ; это позволяет не проверять предыдущие индексы файлов, а отталкиваться от последнего, но при запуске проверяет с 0

	If FindString(FormFileFind$, "/")
		SeaPos = Len(GetPathPart(FormFileFind$))+1
	Else
		Select modeF
			Case 2
				path$ = GetPathPart(ProgramFilename())
			Default
				path$ = GetTemporaryDirectory()
		EndSelect
		SeaPos = Len(path$)+1
	EndIf
	

	
	If FindString(FormFileFind$, "%n")
		Select modeN
			Case 1
				tmp$ = ReplaceString(path$ + FormFileFind$, "%n", Str(Random(2147483647)), #PB_String_CaseSensitive, SeaPos)
			Default
				Repeat
					n + 1
					tmp$ = ReplaceString(path$ + FormFileFind$, "%n", Str(n), #PB_String_CaseSensitive, SeaPos)
				Until FileSize(tmp$) = -1
		EndSelect
	Else
		tmp$ = path$ + FormFileFind$
	EndIf
	
	ProcedureReturn tmp$
EndProcedure

Procedure OpenSetINI(ini$, fo=1)
	Protected tmp$, i, co_mask=0
	
	If flINI
		If OpenPreferences(ini$)
; 			printf и attribute не являются активно обновляемыми, поэтому для них есть выбор по номеру пункта
			If fo And PreferenceGroup("printf")
				For i=1 To 30
					tmp$ = ReadPreferenceString(Str(i), "")
					If tmp$ <> ""
						AddGadgetItem(#LFormarStr, -1, ReplaceString(tmp$, "	|	", #LF$))
					Else
						Break ; если хоть одна пуста или не существует, то заканчиваем чтение
					EndIf
				Next
				; 			tmp$ = GetGadgetItemText(#CmbMask, 0)
				; 			If tmp$ <> ""
				; 			If CountGadgetItems(#LFormarStr)
				; 				SetGadgetState(#LFormarStr, 0)
				; 			EndIf
			EndIf
			If fo And PreferenceGroup("attribute")
				AddGadgetItem(#CmbAtr, -1, "") ; пустой чтобы выбрать отмену выбора, если кто стереть не догадается
				For i=1 To 30
					tmp$ = ReadPreferenceString(Str(i), "")
					If tmp$ <> ""
						AddGadgetItem(#CmbAtr, -1, tmp$)
					Else
						Break
					EndIf
				Next
			EndIf
			If PreferenceGroup("set")
				If ReadPreferenceInteger("RegExp", 0)
					SetGadgetState(#ChRex, 1)
				EndIf
				If ReadPreferenceInteger("Sort", 0)
					SetGadgetState(#ChSort, 1)
				EndIf
				If ReadPreferenceInteger("SortNum", 0)
					SetGadgetState(#ChSrtNum, 1)
				EndIf
				If ReadPreferenceInteger("SortOrder", 0)
					SetGadgetState(#ChSrtInvert, 1)
				EndIf
				If ReadPreferenceInteger("Printf", 0)
					SetGadgetState(#ChPrintf, 1)
					i = ReadPreferenceInteger("ItemPrintf", -1)
					If i > -1 And i < CountGadgetItems(#LFormarStr)
						SetGadgetState(#LFormarStr, i)
					EndIf
				EndIf
				i = ReadPreferenceInteger("AttrSel", 0)
				If i > -1 And i < CountGadgetItems(#CmbAtr)
					SetGadgetState(#CmbAtr, i)
				EndIf
				If Not ReadPreferenceInteger("Output", 0)
					SetGadgetState(#ChCB, 1)
				EndIf
				If ReadPreferenceInteger("Escape", 0)
					SetGadgetState(#ChEsc, 1)
				EndIf
				If ReadPreferenceInteger("Not", 0)
					SetGadgetState(#ChNot, 1)
				EndIf
				If ReadPreferenceInteger("NoCase", 0)
					SetGadgetState(#ChNoCase, 1)
				EndIf
				i = ReadPreferenceInteger("Type", 1)
				Select i
					Case 0
						SetGadgetState(#OptType1, 1)
					Case 1
						SetGadgetState(#OptType2, 1)
					Case 2
						SetGadgetState(#OptType3, 1)
					Case 3 To 11
						SetGadgetState(#OptType4, 1)
						SetGadgetState(#CmbType, i - 3)
				EndSelect
				
; 				размеры
				i = ReadPreferenceInteger("SizeFlag", 1)
				Select i
					Case 1
						SetGadgetState(#OptSize1, 1)
					Case 2
						SetGadgetState(#OptSize2, 1)
					Case 3
						SetGadgetState(#OptSize3, 1)
				EndSelect
				
				i = ReadPreferenceInteger("Size", -1)
				If i <> -1
					SetGadgetState(#CntSz, i)
					i = ReadPreferenceInteger("SizeDim", -1)
					If i > -1 And i < 6
						SetGadgetState(#CmbSize, i)
					EndIf
				EndIf
				
				
			
				; 	Даты файлов
				If ReadPreferenceInteger("daystart", 0)
					SetGadgetState(#ChDayStart, 1)
				EndIf
				
				i = ReadPreferenceInteger("DateCMA", 2)
				Select i
					Case 1
						SetGadgetState(#OptDate1, 1)
					Case 2
						SetGadgetState(#OptDate2, 1)
					Case 3
						SetGadgetState(#OptDate3, 1)
				EndSelect

				i = ReadPreferenceInteger("DateFlag", 1)
				Select i
					Case 1
						SetGadgetState(#OptExact, 1)
					Case 2
						SetGadgetState(#OptOld, 1)
					Case 3
						SetGadgetState(#OptUnd, 1)
					Case 4
						SetGadgetState(#OptPeriod, 1)
						DisableGadget(#CntDate2 , 0)
				EndSelect
			
				SetGadgetState(#CntDate, ReadPreferenceInteger("DateN1", -1))
				SetGadgetState(#CntDate2, ReadPreferenceInteger("DateN2", -1))
				
				i = ReadPreferenceInteger("DateDM", -1)
				If i > -1 And i < 2
					SetGadgetState(#CmbTime, i)
				EndIf
				
; 				флаги
				If ReadPreferenceInteger("xdev", 0)
					SetGadgetState(#ChXdev, 1)
				EndIf
				If ReadPreferenceInteger("nouser", 0)
					SetGadgetState(#ChNoUser, 1)
				EndIf
				If ReadPreferenceInteger("L", 0)
					SetGadgetState(#ChSimLinkReal, 1)
				EndIf
				If ReadPreferenceInteger("H", 0)
					SetGadgetState(#ChSimLinkH, 1)
				EndIf
				If ReadPreferenceInteger("P", 0)
					SetGadgetState(#ChSimLinkNot, 1)
				EndIf
				
				NotHold = ReadPreferenceInteger("NotHold", 1)
				FormFileFind$ = ReadPreferenceString("FileName", FormFileFind$)
				
				browser$ = ReadPreferenceString("browser", "/usr/bin/firefox")
				If FileSize(browser$) < 3
					browser$ = "xdg-open"
				EndIf
				
				If ReadPreferenceInteger("Info", 1)
					SetGadgetState(#ChInfo, 1)
				EndIf
				editor$ = ReadPreferenceString("editor", "/usr/bin/geany")
				If FileSize(editor$) < 3
					editor$ = "xdg-open"
				EndIf
				LastDate$ = ReadPreferenceString("LastDate", "2021.04.01-09:50...2021.04.01-11:50")
				If Len(LastDate$) <> 35
					LastDate$ = "2021.04.01-09:50...2021.04.01-11:50"
				EndIf
				; 			shell$ = ReadPreferenceString("shell", "/bin/bash")
				; 			If FileSize(shell$) < 3
				; 				shell$ = "bash"
				; 			EndIf
				comstr$ = ReadPreferenceString("comstr", ~"bash -c \"find %s 2>&1\"")
				; 			Debug comstr$
				
; 				SedGrep
				i = ReadPreferenceInteger("SedGrep", 1)
				Select i
					Case 1
						SetGadgetState(#OptNotSR, 1)
					Case 2
						SetGadgetState(#OptGrep, 1)
					Case 3
						SetGadgetState(#OptSed, 1)
				EndSelect
				
				If ReadPreferenceInteger("GrName", 0)
					SetGadgetState(#ChName, 1)
				EndIf
				If ReadPreferenceInteger("SGlob", 1)
					SetGadgetState(#ChGlob, 1)
				EndIf
				If ReadPreferenceInteger("NoCase2", 1)
					SetGadgetState(#ChNoCase2, 1)
				EndIf
				If ReadPreferenceInteger("Nstr", 1)
					SetGadgetState(#ChNstr, 1)
				EndIf
				If ReadPreferenceInteger("ERE", 1)
					SetGadgetState(#ChERE, 1)
				EndIf
				
; 				конец секции set
			EndIf
			
			
; 			path и mask являются активно обновляемыми, поэтому пункт добавляется всегда на верх списка,
; 			а при старте выбирается первый пункт как последний использованный
			If PreferenceGroup("path")
				ClearGadgetItems(#CmbPath)
; 				If Not fo
; 					ClearGadgetItems(#CmbPath)
; 				EndIf
				For i=1 To 30
					tmp$ = ReadPreferenceString(Str(i), "")
					If tmp$ <> ""
						AddGadgetItem(#CmbPath, -1, tmp$)
					Else
						Break ; если хоть одна пуста или не существует, то заканчиваем чтение
					EndIf
				Next
				; 			tmp$ = GetGadgetItemText(#CmbPath, 0)
				; 			If tmp$ <> ""
				If CountGadgetItems(#CmbPath)
					SetGadgetState(#CmbPath, 0)
				EndIf
			EndIf
			If PreferenceGroup("mask")
				ClearGadgetItems(#CmbMask)
; 				If Not fo
; 					ClearGadgetItems(#CmbMask)
; 				EndIf
				For i=1 To 30
					tmp$ = ReadPreferenceString(Str(i), "")
					If tmp$ = ""
						If co_mask
							Break ; если хоть одна пуста или не существует, то заканчиваем чтение
						Else
							AddGadgetItem(#CmbMask, -1, tmp$)
						EndIf
						co_mask + 1
					Else
						AddGadgetItem(#CmbMask, -1, tmp$)
					EndIf
				Next
				; 			tmp$ = GetGadgetItemText(#CmbMask, 0)
				; 			If tmp$ <> ""
				If CountGadgetItems(#CmbMask)
					SetGadgetState(#CmbMask, 0)
				EndIf
			EndIf
			
			
			
			If PreferenceGroup("comstr")
				ClearGadgetItems(#StatusBar)
; 				If Not fo
; 					ClearGadgetItems(#StatusBar)
; 				EndIf
				For i=1 To 30
					tmp$ = ReadPreferenceString(Str(i), "")
					If tmp$ <> ""
						AddGadgetItem(#StatusBar, -1, tmp$)
					Else
						Break ; если хоть одна пуста или не существует, то заканчиваем чтение
					EndIf
				Next
; 				If CountGadgetItems(#StatusBar)
; 					SetGadgetState(#StatusBar, 0)
; 				EndIf
			EndIf
			
			
			
			If PreferenceGroup("search")
				ClearGadgetItems(#CmbSea)
; 				If Not fo
; 					ClearGadgetItems(#CmbSea)
; 				EndIf
				For i=1 To 30
					tmp$ = ReadPreferenceString(Str(i), "")
					If tmp$ <> ""
						AddGadgetItem(#CmbSea, -1, tmp$)
					Else
						Break ; если хоть одна пуста или не существует, то заканчиваем чтение
					EndIf
				Next
				; 			tmp$ = GetGadgetItemText(#CmbSea, 0)
				; 			If tmp$ <> ""
				If CountGadgetItems(#CmbSea)
					SetGadgetState(#CmbSea, 0)
				EndIf
			EndIf
			If PreferenceGroup("replace")
				co_mask=0
				ClearGadgetItems(#CmbRepl)
; 				If Not fo
; 					ClearGadgetItems(#CmbRepl)
; 				EndIf
				For i=1 To 30
					tmp$ = ReadPreferenceString(Str(i), "")
					If tmp$ = ""
						If co_mask
							Break ; если хоть одна пуста или не существует, то заканчиваем чтение
						Else
							AddGadgetItem(#CmbRepl, -1, tmp$)
						EndIf
						co_mask + 1
					Else
						AddGadgetItem(#CmbRepl, -1, tmp$)
					EndIf
				Next
				; 			tmp$ = GetGadgetItemText(#CmbRepl, 0)
				; 			If tmp$ <> ""
				If CountGadgetItems(#CmbRepl)
					SetGadgetState(#CmbRepl, 0)
				EndIf
			EndIf
			ClosePreferences()
		EndIf
	EndIf
EndProcedure

Procedure date_interval()
	Protected tmp$, CurData, i1, i2, d1$, d2$
	; 	yyyy.mm.dd-hh:mm
	tmp$ = InputRequester(Lng(106), Lng(107) + #LF$ + Lng(108), LastDate$)
	If tmp$ = ""
		ProcedureReturn
	EndIf
	LastDate$ = tmp$
	CurData = Date()
	d1$ = StringField(tmp$, 1, "...")
	d2$ = StringField(tmp$, 2, "...")
	If d2$ = ""
		ProcedureReturn
	EndIf
	;		%ss: предполагает значение секунд (2 цифры).
	i1 = ParseDate("%yyyy.%mm.%dd-%hh:%ii", d1$) 
	i2 = ParseDate("%yyyy.%mm.%dd-%hh:%ii", d2$) 
	If i1 = -1 Or i2 = -1 Or i1 = i2
		ProcedureReturn
	EndIf
	SetGadgetState(#CmbTime, 1)
	SetGadgetState(#OptPeriod, 1)
	DisableGadget(#CntDate2 , 0)
	SetGadgetText(#CntDate2, Str((CurData-i1)/60))
	SetGadgetText(#CntDate, Str((CurData-i2)/60))
	; 	SetGadgetText(#CmbTime, min$)
EndProcedure

Procedure SwitchDate(e)
	Protected tmp$, tmp_2$, i
	tmp$ = GetGadgetText(#CntDate)
	tmp_2$ = GetGadgetText(#CntDate2)
	; 	Debug tmp$
	; 	Debug tmp_2$
	If GetGadgetText(#CmbTime) = day$
		i=2
	Else
		i=1
	EndIf
	; 	Debug (Val(tmp_2$) - Val(tmp$))
	If (Val(tmp_2$) - Val(tmp$)) < i
		If e = #CntDate
			SetGadgetText(#CntDate2, Str(Val(tmp$)+i))
		Else
			SetGadgetText(#CntDate, Str(Val(tmp_2$)-i))
		EndIf
	EndIf
EndProcedure

Procedure.s FormTime(time)
	Protected res$, h, m, s, ms
	If time >= 3600000
		h = time/3600000
		time % 3600000
		res$ + Str(h) + Lng(109)
	EndIf
	If time >= 60000
		m = time/60000
		time % 60000
		res$ + Str(m) + Lng(110)
	EndIf
	If time >= 1000
		s = time/1000
		time % 1000
		res$ + Str(s) + Lng(111)
	EndIf
	If time > 0
		res$ + Str(time) + Lng(112)
	EndIf
	ProcedureReturn res$
EndProcedure


Procedure ReCombo(ComboID, *NotChange)
	Protected tmp$, Count, i
	If PeekB(*NotChange) ; если не было изменений в этом комбобоксе, то выпрыгиваем из функции не производя вычислений
		ProcedureReturn
	EndIf
	PokeB(*NotChange, 1)
; 	Debug ComboID ; проверка что функция вызывается только наизменённые комбо
	Count = CountGadgetItems(ComboID)
	tmp$ = GetGadgetText(ComboID)
	For i=0 To Count-1
		If GetGadgetItemText(ComboID, i) = tmp$
			If i = 0 ; если путь в начале списка, то перемещение не требуется
				ProcedureReturn
			EndIf
			RemoveGadgetItem(ComboID, i)
			AddGadgetItem(ComboID, 0, tmp$)
			ProcedureReturn ; делаем выпрыг, считая что путь может быть только 1
		EndIf
	Next
	If Count >= Co_Items
		RemoveGadgetItem(ComboID, Count - 1) ; удалить последний
	EndIf
	AddGadgetItem(ComboID, 0, tmp$)
EndProcedure

Procedure SaveSetINI(ini$)
	Protected i, Count
	If NotHold
		ReCombo(#CmbPath, @CmbPathNotChange)
		ReCombo(#CmbMask, @CmbMaskNotChange)
		ReCombo(#CmbRepl, @CmbReplNotChange)
		ReCombo(#CmbSea, @CmbSeaNotChange)
		ReCombo(#StatusBar, @StatusBarNotChange)
	EndIf
	If flINI
		If OpenPreferences(ini$)
			PreferenceGroup("set")
			WritePreferenceInteger("WinWidth", w)
			WritePreferenceInteger("WinHeight", h)
			WritePreferenceInteger("RegExp", GetGadgetState(#ChRex))
			WritePreferenceInteger("Sort", GetGadgetState(#ChSort))
			WritePreferenceInteger("SortNum", GetGadgetState(#ChSrtNum))
			WritePreferenceInteger("SortOrder", GetGadgetState(#ChSrtInvert))
			WritePreferenceInteger("Printf", GetGadgetState(#ChPrintf))
			WritePreferenceInteger("ItemPrintf", GetGadgetState(#LFormarStr))
			WritePreferenceInteger("Output", GetGadgetState(#ChSaveF))
			WritePreferenceInteger("Escape", GetGadgetState(#ChSaveF))
			WritePreferenceInteger("Not", GetGadgetState(#ChNot))
			WritePreferenceInteger("NoCase", GetGadgetState(#ChNoCase))
			
; 			поиск замена
			WritePreferenceInteger("GrName", GetGadgetState(#ChName))
			WritePreferenceInteger("SGlob", GetGadgetState(#ChGlob))
			WritePreferenceInteger("NoCase2", GetGadgetState(#ChNoCase2))
			WritePreferenceInteger("Nstr", GetGadgetState(#ChNstr))
			WritePreferenceInteger("ERE", GetGadgetState(#ChERE))
				
; 				флаги
			WritePreferenceInteger("xdev", GetGadgetState(#ChXdev))
			WritePreferenceInteger("nouser", GetGadgetState(#ChNoUser))
			WritePreferenceInteger("L", GetGadgetState(#ChSimLinkReal))
			WritePreferenceInteger("H", GetGadgetState(#ChSimLinkH))
			WritePreferenceInteger("P", GetGadgetState(#ChSimLinkNot))
			
			If GetGadgetState(#OptType1) = #PB_Checkbox_Checked
				WritePreferenceInteger("Type", 0)
			ElseIf GetGadgetState(#OptType2) = #PB_Checkbox_Checked
				WritePreferenceInteger("Type", 1)
			ElseIf GetGadgetState(#OptType3) = #PB_Checkbox_Checked
				WritePreferenceInteger("Type", 2)
			ElseIf GetGadgetState(#OptType4) = #PB_Checkbox_Checked
				i = GetGadgetState(#CmbType)
				WritePreferenceInteger("Type", 3 + i)
			EndIf
			; 				Select #PB_Checkbox_Checked
			; 					Case GetGadgetState(#OptType1)
			; 						WritePreferenceInteger("Type", 0)
			; 					Case GetGadgetState(#OptType2)
			; 						SetGadgetState(#OptType2, 1)
			; 					Case GetGadgetState(#OptType3)
			; 						SetGadgetState(#OptType3, 2)
			; 					Case GetGadgetState(#OptType4)
			; 						i = GetGadgetState(#CmbType)
			; 						WritePreferenceInteger("Type", 3 + i)
			; 				EndSelect
			
			; размер
			If GetGadgetState(#OptSize1) = #PB_Checkbox_Checked
				WritePreferenceInteger("SizeFlag", 1)
			ElseIf GetGadgetState(#OptSize2) = #PB_Checkbox_Checked
				WritePreferenceInteger("SizeFlag", 2)
			ElseIf GetGadgetState(#OptSize3) = #PB_Checkbox_Checked
				WritePreferenceInteger("SizeFlag", 3)
			EndIf
			WritePreferenceInteger("Size", GetGadgetState(#CntSz))
			WritePreferenceInteger("SizeDim", GetGadgetState(#CmbSize))
			
			WritePreferenceInteger("AttrSel", GetGadgetState(#CmbAtr))
			
			
			
			; Даты файлов
			WritePreferenceString("LastDate", LastDate$)
			WritePreferenceInteger("daystart", GetGadgetState(#ChDayStart))
			If GetGadgetState(#OptDate1) = #PB_Checkbox_Checked
				WritePreferenceInteger("DateCMA", 1)
			ElseIf GetGadgetState(#OptDate2) = #PB_Checkbox_Checked
				WritePreferenceInteger("DateCMA", 2)
			ElseIf GetGadgetState(#OptDate3) = #PB_Checkbox_Checked
				WritePreferenceInteger("DateCMA", 3)
			EndIf
			If GetGadgetState(#OptExact) = #PB_Checkbox_Checked
				WritePreferenceInteger("DateFlag", 1)
			ElseIf GetGadgetState(#OptOld) = #PB_Checkbox_Checked
				WritePreferenceInteger("DateFlag", 2)
			ElseIf GetGadgetState(#OptUnd) = #PB_Checkbox_Checked
				WritePreferenceInteger("DateFlag", 3)
			ElseIf GetGadgetState(#OptPeriod) = #PB_Checkbox_Checked
				WritePreferenceInteger("DateFlag", 4)
			EndIf
			WritePreferenceInteger("DateN1", GetGadgetState(#CntDate))
			WritePreferenceInteger("DateN2", GetGadgetState(#CntDate2))
			WritePreferenceInteger("DateDM", GetGadgetState(#CmbTime))
			
; 			sed grep
			If GetGadgetState(#OptNotSR) = #PB_Checkbox_Checked
				WritePreferenceInteger("SedGrep", 1)
			ElseIf GetGadgetState(#OptGrep) = #PB_Checkbox_Checked
				WritePreferenceInteger("SedGrep", 2)
			ElseIf GetGadgetState(#OptSed) = #PB_Checkbox_Checked
				WritePreferenceInteger("SedGrep", 3)
			EndIf

			
	
			
			
			If NotHold
				PreferenceGroup("mask")
				Count = CountGadgetItems(#CmbMask)
				For i=0 To Count-1
					WritePreferenceString(Str(i+1), GetGadgetItemText(#CmbMask, i))
				Next
				
				PreferenceGroup("path")
				Count = CountGadgetItems(#CmbPath)
				For i=0 To Count-1
					WritePreferenceString(Str(i+1), GetGadgetItemText(#CmbPath, i))
				Next
				
				PreferenceGroup("comstr")
				Count = CountGadgetItems(#StatusBar)
				For i=0 To Count-1
					WritePreferenceString(Str(i+1), GetGadgetItemText(#StatusBar, i))
				Next
				
				
				PreferenceGroup("replace")
				Count = CountGadgetItems(#CmbRepl)
				For i=0 To Count-1
					WritePreferenceString(Str(i+1), GetGadgetItemText(#CmbRepl, i))
				Next
				
				PreferenceGroup("search")
				Count = CountGadgetItems(#CmbSea)
				For i=0 To Count-1
					WritePreferenceString(Str(i+1), GetGadgetItemText(#CmbSea, i))
				Next
			EndIf
			
			ClosePreferences()
		EndIf
	EndIf
EndProcedure




; проверка версии и соответственно наличия проги
Procedure ExeComStr(*Result.string)
	Protected NewList Files.s(), Len=0, tmp, *Point;, Count
; 	Debug *Result\s
; 	Debug shell$
; 	tmp = RunProgram(shell$, "-c " + Chr(34) + "find " + *Result\s + " 2>&1" + Chr(34), "", #PB_Program_Open | #PB_Program_Read)
	tmp = RunProgram(shell$, ReplaceString(comstr$ , "%s" , *Result\s), "", #PB_Program_Open | #PB_Program_Read)
	If tmp
		While ProgramRunning(tmp)
			If AvailableProgramOutput(tmp)
				; 				res$ + ReadProgramString(tmp) + Chr(10)
				; 				StrFastAdd(FS, ReadProgramString(tmp) + Chr(10))
				If AddElement(Files())
					Files() = ReadProgramString(tmp); + Chr(10)
				EndIf
			EndIf
		Wend
		
		; 		подсчитываем длину данных
		; 	   Count = ListSize(Files())
		ForEach Files()
			Len + Len(Files())
		Next
		Len+ListSize(Files()) ; добавляем число переносов строк #LF$ по количеству данных
		
		*Result\s = Space(Len)
		*Point = @*Result\s
		ForEach Files()
			CopyMemoryString(Files()+#LF$, @*Point)
		Next
		ClearList(Files())
		CloseProgram(tmp)
	EndIf
	
	; 	ProcedureReturn res$
EndProcedure

Procedure.s Escape(tmp$)
	Protected ind
	ind = FindString(tmp$, "{")
	If ind
		tmp$ = ReplaceString(tmp$, "{", "\{", #PB_String_CaseSensitive, ind)
	EndIf
	ind = FindString(tmp$, "}")
	If ind
		tmp$ = ReplaceString(tmp$, "}", "\}", #PB_String_CaseSensitive, ind)
	EndIf
	ind = FindString(tmp$, "(")
	If ind
		tmp$ = ReplaceString(tmp$, "(", "\(", #PB_String_CaseSensitive, ind)
	EndIf
	ind = FindString(tmp$, ")")
	If ind
		tmp$ = ReplaceString(tmp$, ")", "\)", #PB_String_CaseSensitive, ind)
	EndIf
	ind = FindString(tmp$, "|")
	If ind
		tmp$ = ReplaceString(tmp$, "|", "\|", #PB_String_CaseSensitive, ind)
	EndIf
	
	ProcedureReturn tmp$
EndProcedure

Procedure.s FormComStr()
	Protected ComStr$ = "", tmp$, err$ = "", ind, tmp_2$, d1$, d2$
	
	If GetGadgetState(#ChSimLinkReal) = #PB_Checkbox_Checked
		ComStr$ + "-L "
	EndIf
	If GetGadgetState(#ChSimLinkNot) = #PB_Checkbox_Checked
		ComStr$ + "-P "
	EndIf
	If GetGadgetState(#ChSimLinkH) = #PB_Checkbox_Checked
		ComStr$ + "-H "
	EndIf
	
	; 	путь
	tmp$ = GetGadgetText(#CmbPath)
	If tmp$ = ""
		err$ + Lng(113) + #LF$
	Else
		ComStr$ + Chr(39) + tmp$ + Chr(39) + " "
	EndIf
	; 	ComStr$ + "-nowarn "
	
	; 	Маска, Кроме, регвыр, движок
	tmp$ = GetGadgetText(#CmbMask)
	If tmp$ <> ""
		tmp_2$ = GetGadgetText(#CmbErgRE)
		If tmp_2$ <> "" And GetGadgetState(#ChRex) = #PB_Checkbox_Checked
			ComStr$ + "-regextype " + tmp_2$ + " "
			tmp_2$ = ""
		EndIf
		If GetGadgetState(#ChNot) = #PB_Checkbox_Checked
			ComStr$ + "-not "
		EndIf
		ComStr$ + "-"
		If GetGadgetState(#ChNoCase) = #PB_Checkbox_Checked
			ComStr$ + "i"
		EndIf
		If GetGadgetState(#ChRex) = #PB_Checkbox_Checked
			; 			tmp_2$ = GetGadgetText(#CmbErgRE)
			; 			If tmp_2$ <> ""
			; 				ComStr$ + "regextype " + tmp_2$ + " -"
			; 			EndIf
			; 	Экранирование переместил вверх, чтобы исправлять только маски рег.выр.
			; 	Экранирование в регулярных выражениях или именах файлов или в строках форматирования
			If GetGadgetState(#ChEsc) = #PB_Checkbox_Checked
				tmp$ = Escape(tmp$)
			EndIf
			ComStr$ + "regex " + Chr(39) + tmp$ + Chr(39) + " "
			; 			tmp$ = GetGadgetText(#CmbErgRE)
			; 			If tmp$ <> ""
			; 				ComStr$ + "-regextype " + tmp$ + " "
			; 				; 				ComStr$ + "-regextype " + Chr(39) + tmp$ + Chr(39) + " "
			; 			EndIf
		Else
			ComStr$ + "name " + Chr(39) + tmp$ + Chr(39) + " "
		EndIf
		
		
		
		; 		If GetGadgetState(#ChRex) = #PB_Checkbox_Checked
		; 			If GetGadgetState(#ChNoCase) = #PB_Checkbox_Checked
		; 				ComStr$ + "-iregex " + Chr(39) + tmp$ + Chr(39)
		; 			Else
		; 				ComStr$ + "-regex " + Chr(39) + tmp$ + Chr(39)
		; 			EndIf
		; 		Else
		; 			If GetGadgetState(#ChNoCase) = #PB_Checkbox_Checked
		; 				ComStr$ + "-iname " + Chr(39) + tmp$ + Chr(39)
		; 			Else
		; 				ComStr$ + "-name " + Chr(39) + tmp$ + Chr(39)
		; 			EndIf
		; 		EndIf
	EndIf
	
	If GetGadgetState(#ChXdev) = #PB_Checkbox_Checked
		ComStr$ + "-xdev "
	EndIf
	
	; 	тип, папка, файл или другое
	If GetGadgetState(#OptType2) = #PB_Checkbox_Checked
		ComStr$ + "-type f "
	ElseIf GetGadgetState(#OptType3) = #PB_Checkbox_Checked
		ComStr$ + "-type d "
	ElseIf GetGadgetState(#OptType4) = #PB_Checkbox_Checked
		tmp$ = GetGadgetText(#CmbType)
		If tmp$ <> ""
			ComStr$ + "-type " + Left(tmp$, 2)
		EndIf
	EndIf
	
	; 	размер
	If GetGadgetState(#CntSz) <> -1
		ComStr$ + "-size "
		If GetGadgetState(#OptSize2) = #PB_Checkbox_Checked
			ComStr$ + "-"
		ElseIf GetGadgetState(#OptSize3) = #PB_Checkbox_Checked
			ComStr$ + "+"
		EndIf
		ComStr$ + GetGadgetText(#CntSz)
		tmp$ = GetGadgetText(#CmbSize)
		If tmp$ <> ""
			ComStr$ + Left(tmp$, 2)
		EndIf
	EndIf
	
	If GetGadgetState(#ChDayStart) = #PB_Checkbox_Checked
		ComStr$ + "-daystart "
	EndIf
	
	; 	Даты файлов
	If GetGadgetState(#CntDate) <> -1
		d1$ = GetGadgetText(#CntDate)
		tmp$ = ""
		If GetGadgetState(#OptDate1) = #PB_Checkbox_Checked
			tmp$ + "-c"
		ElseIf GetGadgetState(#OptDate2) = #PB_Checkbox_Checked
			tmp$ + "-m" ; modified
		ElseIf GetGadgetState(#OptDate3) = #PB_Checkbox_Checked
			tmp$ + "-a" ; accessed
		EndIf
		tmp_2$ = GetGadgetText(#CmbTime)
		If tmp_2$ = day$
			tmp$ + "time "
		Else
			tmp$ + "min "
		EndIf
		
		If GetGadgetState(#OptExact) = #PB_Checkbox_Checked
			tmp$ + d1$ ; Точно
		ElseIf GetGadgetState(#OptOld) = #PB_Checkbox_Checked
			tmp$ + "+" + d1$ ; Старше
		ElseIf GetGadgetState(#OptUnd) = #PB_Checkbox_Checked
			tmp$ + "-" + d1$ ; Младше
		ElseIf GetGadgetState(#OptPeriod) = #PB_Checkbox_Checked
			d2$ = GetGadgetText(#CntDate2)
			; 			If (Val(d1$) - Val(d2$)) > -2
			; 				за этот период никогда ничего не найдётся
			; 			EndIf
			tmp$ + "+" + d1$ + " " + tmp$ + "-" + d2$ ; Период
		EndIf
		ComStr$ + tmp$ + " "
	EndIf
	
	; 	-amin, -atime, -cmin, -ctime, -mmin и -mtime
	; 
	; FrameGadget(#t11, 356, 273, 300, 122, Lng(30))
	; OptionGadget(#OptDate1, 365, 295, 60, 20, Lng(31))
	; OptionGadget(#OptDate2, 365, 315, 60, 20, Lng(32))
	; OptionGadget(#OptDate3, 365, 335, 60, 20, Lng(33))
	; SpinGadget(#CntDate, 365, 360, 100, 23, -1, 20000, #PB_Spin_Numeric)
	
	; 	поиск с указанной глубиной подпапок 1=текущая
	If GetGadgetState(#inpMaxDepth) > 0
		ComStr$ + "-maxdepth " + GetGadgetText(#inpMaxDepth) + " "
	EndIf
	
; 	Атрибуты
	If GetGadgetState(#ChAtrAny) = #PB_Checkbox_Checked
		tmp$ = GetGadgetText(#CmbAtr)
		If tmp$ <> ""
			ComStr$ + "-perm " + tmp$ + " "	
		EndIf
	ElseIf GetGadgetState(#ChAtrR) = #PB_Checkbox_Checked
		ComStr$ + "-perm /u=r " ; 	только чтение
	ElseIf GetGadgetState(#ChAtrX) = #PB_Checkbox_Checked
		ComStr$ + "-perm /a=x " ; 	только исполняемые
	EndIf
	
	; 	форматированный вывод
	If GetGadgetState(#ChPrintf) = #PB_Checkbox_Checked
		ind = GetGadgetState(#LFormarStr)
		; 		Debug ind
		If ind <> -1
			tmp$ = GetGadgetItemText(#LFormarStr, ind)
			If tmp$ <> ""
				; 				Debug tmp$
				; 	Экранирование переместил вверх, чтобы исправлять только маски рег.выр.
				; 	Экранирование в регулярных выражениях или именах файлов или в строках форматирования
				If GetGadgetState(#ChEsc) = #PB_Checkbox_Checked
					tmp$ = Escape(tmp$)
				EndIf
				ComStr$ + "-printf " + Chr(39) + tmp$ + Chr(39) + " "
			EndIf
		EndIf
	EndIf
	
	; 	Сортировка
	If GetGadgetState(#ChSort) = #PB_Checkbox_Checked
		ComStr$ = RTrim(ComStr$)
		ComStr$ + "|sort "
		If GetGadgetState(#ChSrtInvert) = #PB_Checkbox_Checked
			ComStr$ + "-r "
		EndIf
		If GetGadgetState(#ChSrtNum) = #PB_Checkbox_Checked
			ComStr$ + "-n "
		EndIf
	EndIf
	
	; 	Поиск/замена
	If GetGadgetState(#OptNotSR) = #PB_Checkbox_Unchecked
; 		tmp_2$, d1$, d2$
; 		ComStr$ = RTrim(ComStr$) + " -print0|xargs -0 -n 1 "
		ComStr$ = RTrim(ComStr$) + " -print0|xargs -0 "
; 		ComStr$ = RTrim(ComStr$) + " -print0|xargs -0  -I FILE "
		d1$ = GetGadgetText(#CmbSea)
; 		d1$ = Win1251(d1$)
		If d1$ = ""
			err$ + Lng(114) + #LF$
		EndIf
		If GetGadgetState(#ChSort) = #PB_Checkbox_Checked
			err$ + Lng(115) + #LF$
		EndIf
		If GetGadgetState(#ChPrintf) = #PB_Checkbox_Checked
			err$ + Lng(116) + #LF$
		EndIf
		If GetGadgetState(#OptGrep) = #PB_Checkbox_Checked
			If GetGadgetState(#ChERE) = #PB_Checkbox_Checked
				ComStr$ + "e"
			EndIf
			ComStr$ + "grep "
			If GetGadgetState(#ChName) = #PB_Checkbox_Checked
				ComStr$ + "-l "
			EndIf
			If GetGadgetState(#ChNoCase2) = #PB_Checkbox_Checked
				ComStr$ + "-i "
			EndIf
			If GetGadgetState(#ChNstr) = #PB_Checkbox_Checked
				ComStr$ + "-n "
			EndIf
			If d1$ <> ""
				ComStr$ + "'" + d1$ + "' "
			EndIf
		ElseIf GetGadgetState(#OptSed) = #PB_Checkbox_Checked
			ComStr$ + "sed -i " ; -i означает замену в том же файле
			If GetGadgetState(#ChERE) = #PB_Checkbox_Checked
				ComStr$ + "-r "
			EndIf
			d2$ = GetGadgetText(#CmbRepl)
; 			d2$ = Win1251(d2$)
			If d1$ <> ""
				ComStr$ + "'s/" + d1$ + "/" + d2$ + "/"
				If GetGadgetState(#ChGlob) = #PB_Checkbox_Checked
					ComStr$ + "g"
				EndIf
				If GetGadgetState(#ChNoCase2) = #PB_Checkbox_Checked
					ComStr$ + "i"
				EndIf
				ComStr$ + "'"
			EndIf
		EndIf
		ComStr$ + " "
	EndIf
	
	
	
	; 	Собственные ключи
	tmp$ = GetGadgetText(#InpMy)
	If tmp$ <> ""
		ComStr$ + tmp$
	EndIf
	
	
	If err$ <> ""
		MessageRequester("", err$)
	EndIf
	
	ProcedureReturn RTrim(ComStr$)
	
EndProcedure

; проверка версии и соответственно наличия проги
Procedure.s Ver()
	Protected Pos=0, tmp, res$
	tmp = RunProgram("find", "--version", "", #PB_Program_Open | #PB_Program_Read)
	res$ = ""
	If tmp
		While ProgramRunning(tmp)
			If AvailableProgramOutput(tmp)
				res$ + ReadProgramString(tmp)
				Break ; выпрыгиваем получив одну строку
			EndIf
		Wend
		CloseProgram(tmp)
	EndIf
	
	; 	Ищем последнюю позицию пробела
	tmp = 0
	res$ = RTrim(res$)
	Repeat
		Pos = FindString(res$, " ", Pos+1)
		If Pos
			tmp = Pos
		EndIf
	Until Not Pos
	If tmp
		ProcedureReturn " (find " + Mid(res$, tmp+1) + ")"
	Else
		ProcedureReturn ""
	EndIf
EndProcedure

Procedure SaveFile_Buff(File.s, *Buff, Size)
	Protected Result = #False
	Protected ID = CreateFile(#PB_Any, File)
	If ID
		If WriteData(ID, *Buff, Size) = Size
			Result = #True
		EndIf
		CloseFile(ID)
	EndIf
	ProcedureReturn Result
EndProcedure

;==================================================================
;
; Author:    ts-soft     
; Date:       March 5th, 2010
; Explain:
;     modified version from IBSoftware (CodeArchiv)
;     on vista and above check the Request for "User mode" or "Administrator mode" in compileroptions
;    (no virtualisation!)
;==================================================================
Procedure ForceDirectories(Dir.s)
	Static tmpDir.s, Init, delim$
	Protected result
	CompilerSelect #PB_Compiler_OS
		CompilerCase #PB_OS_Windows
			delim$ = "\"
		CompilerCase #PB_OS_Linux
			delim$ = "/"
	CompilerEndSelect
	
	If Len(Dir) = 0
		ProcedureReturn #False
	Else
		If Not Init
			tmpDir = Dir
			Init   = #True
		EndIf
		If (Right(Dir, 1) = delim$)
			Dir = Left(Dir, Len(Dir) - 1)
		EndIf
		If (Len(Dir) < 3) Or FileSize(Dir) = -2 Or GetPathPart(Dir) = Dir
			If FileSize(tmpDir) = -2
				result = #True
			EndIf
			tmpDir = ""
			Init = #False
			ProcedureReturn result
		EndIf
		ForceDirectories(GetPathPart(Dir))
		ProcedureReturn CreateDirectory(Dir)
	EndIf
EndProcedure
