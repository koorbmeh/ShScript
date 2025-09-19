#Requires AutoHotkey v2.0
; Download here: https://www.autohotkey.com/download/ahk-v2.exe

; ========================================
; ShScript.ahk - Stormhalter Script
; ========================================
; A clean, modular AutoHotkey v2 script for the game, Stormhalter
; All user-configurable settings are in ShScript_Config.ini
; The ShScript_Config.ini is created after running the script the first time.
; ========================================

; ========================================
; GLOBAL VARIABLES - DO NOT EDIT
; ========================================
; These variables are managed by the script and should not be edited manually

; Script state variables
ConfigFile := "ShScript_Config.ini"
LogFile := "ShScript_Debug.log"
BackupFolder := "ShScript_Backups"

; Game state variables
GameWindowTitle := "ahk_exe Kesmai.Client.exe"
GameRunning := false
CurrentProfile := 1

; Configuration variables (initialized with defaults)
EnableDebugLogging := false
EnableBackups := false
LogLevel := "INFO"
TooltipDisplayTime := 2048
ShortDelay := 32
MediumDelay := 64
LongDelay := 128
AutoLoopInterval := 100

; Game settings
GamePath := "C:\Program Files\Kesmai\"
GameExecutable := "Kesmai.Client.exe"
AutoClickLogin := true
LoginButtonX := 950
LoginButtonY := 700
AutoCloseOnClientExit := true
UseSecondaryMonitor := true
SecondaryMonitorNumber := 3
AutoMaximizeWindow := true

; Character profiles
MaxProfiles := 9
CurrentProfile := 1
Profile1Name := "Profile 1"
Profile2Name := "Profile 2"
Profile3Name := "Profile 3"
Profile4Name := "Profile 4"
Profile5Name := "Profile 5"
Profile6Name := "Profile 6"
Profile7Name := "Profile 7"
Profile8Name := "Profile 8"
Profile9Name := "Profile 9"

; Auto settings
EnableAuto := false
EnableHealthMonitoring := true
EnableManaMonitoring := true
AttackKey1 := "f"
AttackKey2 := "e"
EnableAttackKey2 := true
AttackSpamReduction := true
DrinkKey := "s"
HealthAreaX := 780
HealthAreaY := 685
ManaAreaX := 960
ManaAreaY := 640
CreatureAreaX := 1045
CreatureAreaY := 100

; MASkill settings
EnableMASkill := true
MAFistsKey := "r"
MARestockKey := "h"
CurrentMASkill := "restock"

; Coin pickup settings
EnableCoinPickup := false
MoneyRingKey := "t"
CoinAreaTopLeftX := 20
CoinAreaTopLeftY := 60
CoinAreaBottomRightX := 660
CoinAreaBottomRightY := 700
CoinDetectionThreshold := 1
CoinColorRedMin := 159
CoinColorRedMax := 251
CoinColorGreenMin := 123
CoinColorGreenMax := 234
CoinColorBlueMin := 30
CoinColorBlueMax := 123

; ========================================
; CONFIGURATION LOADING FUNCTIONS
; ========================================

; Function to load configuration from file
LoadConfig() {
    global ConfigFile
    global GamePath, GameExecutable, AutoClickLogin, LoginButtonX, LoginButtonY, AutoCloseOnClientExit, UseSecondaryMonitor, SecondaryMonitorNumber, AutoMaximizeWindow
    global ShortDelay, MediumDelay, LongDelay, TooltipDisplayTime, AutoLoopInterval, EnableDebugLogging, EnableBackups, LogLevel
    global MaxProfiles, CurrentProfile, Profile1Name, Profile2Name, Profile3Name, Profile4Name, Profile5Name, Profile6Name, Profile7Name, Profile8Name, Profile9Name
    global EnableAuto, EnableHealthMonitoring, EnableManaMonitoring, AttackKey1, AttackKey2, EnableAttackKey2, AttackSpamReduction, DrinkKey, HealthAreaX, HealthAreaY, ManaAreaX, ManaAreaY, CreatureAreaX, CreatureAreaY, EnableMASkill, MAFistsKey, MARestockKey, CurrentMASkill

    ; Create default config if it doesn't exist
    if (!FileExist(ConfigFile)) {
        CreateDefaultConfig()
        LogMessage("Created default configuration file: " . ConfigFile)
        return
    }

    try {
        ; Load settings from config file using IniRead
        GamePath := IniRead(ConfigFile, "GAME SETTINGS", "GamePath", GamePath)
        GameExecutable := IniRead(ConfigFile, "GAME SETTINGS", "GameExecutable", GameExecutable)
        AutoClickLogin := (IniRead(ConfigFile, "GAME SETTINGS", "AutoClickLogin", AutoClickLogin ? "true" : "false") = "true")
        LoginButtonX := IniRead(ConfigFile, "GAME SETTINGS", "LoginButtonX", LoginButtonX)
        LoginButtonY := IniRead(ConfigFile, "GAME SETTINGS", "LoginButtonY", LoginButtonY)
        AutoCloseOnClientExit := (IniRead(ConfigFile, "GAME SETTINGS", "AutoCloseOnClientExit", AutoCloseOnClientExit ? "true" : "false") = "true")
        UseSecondaryMonitor := (IniRead(ConfigFile, "GAME SETTINGS", "UseSecondaryMonitor", UseSecondaryMonitor ? "true" : "false") = "true")
        SecondaryMonitorNumber := IniRead(ConfigFile, "GAME SETTINGS", "SecondaryMonitorNumber", SecondaryMonitorNumber)
        AutoMaximizeWindow := (IniRead(ConfigFile, "GAME SETTINGS", "AutoMaximizeWindow", AutoMaximizeWindow ? "true" : "false") = "true")

        ShortDelay := IniRead(ConfigFile, "TIMING SETTINGS", "ShortDelay", ShortDelay)
        MediumDelay := IniRead(ConfigFile, "TIMING SETTINGS", "MediumDelay", MediumDelay)
        LongDelay := IniRead(ConfigFile, "TIMING SETTINGS", "LongDelay", LongDelay)
        TooltipDisplayTime := IniRead(ConfigFile, "TIMING SETTINGS", "TooltipDisplayTime", TooltipDisplayTime)
        AutoLoopInterval := IniRead(ConfigFile, "TIMING SETTINGS", "AutoLoopInterval", AutoLoopInterval)

        EnableDebugLogging := (IniRead(ConfigFile, "LOGGING SETTINGS", "EnableDebugLogging", EnableDebugLogging ? "true" : "false") = "true")
        EnableBackups := (IniRead(ConfigFile, "LOGGING SETTINGS", "EnableBackups", EnableBackups ? "true" : "false") = "true")
        LogLevel := IniRead(ConfigFile, "LOGGING SETTINGS", "LogLevel", LogLevel)

        ; Load character profile settings
        MaxProfiles := IniRead(ConfigFile, "CHARACTER PROFILES", "MaxProfiles", MaxProfiles)
        CurrentProfile := IniRead(ConfigFile, "CHARACTER PROFILES", "CurrentProfile", CurrentProfile)
        Profile1Name := IniRead(ConfigFile, "CHARACTER PROFILES", "Profile1Name", Profile1Name)
        Profile2Name := IniRead(ConfigFile, "CHARACTER PROFILES", "Profile2Name", Profile2Name)
        Profile3Name := IniRead(ConfigFile, "CHARACTER PROFILES", "Profile3Name", Profile3Name)
        Profile4Name := IniRead(ConfigFile, "CHARACTER PROFILES", "Profile4Name", Profile4Name)
        Profile5Name := IniRead(ConfigFile, "CHARACTER PROFILES", "Profile5Name", Profile5Name)
        Profile6Name := IniRead(ConfigFile, "CHARACTER PROFILES", "Profile6Name", Profile6Name)
        Profile7Name := IniRead(ConfigFile, "CHARACTER PROFILES", "Profile7Name", Profile7Name)
        Profile8Name := IniRead(ConfigFile, "CHARACTER PROFILES", "Profile8Name", Profile8Name)
        Profile9Name := IniRead(ConfigFile, "CHARACTER PROFILES", "Profile9Name", Profile9Name)

        ; Load current profile's auto settings
        LoadProfileAutoSettings(CurrentProfile)

        LogMessage("Configuration loaded successfully")
        LogMessage("GamePath loaded as: " . GamePath)
        LogMessage("Current profile: " . CurrentProfile . " - " . GetProfileName(CurrentProfile))
        return true

    } catch Error as e {
        LogMessage("Error loading configuration: " . e.Message)
        return false
    }
}

; Function to create default configuration file
CreateDefaultConfig() {
    global ConfigFile
    
    defaultConfig := "; ShScript Configuration File`n"
    defaultConfig .= "; Edit these settings as needed - do not edit the main script`n"
    defaultConfig .= "; Press Ctrl+Shift+F1 while the script is running to see the Hotkey Legend`n`n"
    defaultConfig .= "; *** IMPORTANT SETUP INSTRUCTIONS ***`n"
    defaultConfig .= "; You MUST either:`n"
    defaultConfig .= "; 1) Update the GamePath below to point to your Stormhalter folder, OR`n"
    defaultConfig .= "; 2) Place this script in the same folder as Kesmai.Client.exe`n"
    defaultConfig .= "; The script will automatically check both locations`n`n"
    
    defaultConfig .= "[GAME SETTINGS]`n"
    defaultConfig .= "GamePath=C:\Program Files\Kesmai\`n"
    defaultConfig .= "GameExecutable=Kesmai.Client.exe`n"
    defaultConfig .= "AutoClickLogin=true`n"
    defaultConfig .= "; Set login button coordinates with Ctrl+Shift+L hotkey`n"
    defaultConfig .= "LoginButtonX=945`n"
    defaultConfig .= "LoginButtonY=715`n"
    defaultConfig .= "AutoCloseOnClientExit=true`n"
    defaultConfig .= "UseSecondaryMonitor=true`n"
    defaultConfig .= "SecondaryMonitorNumber=3`n"
    defaultConfig .= "AutoMaximizeWindow=true`n`n"
    
    defaultConfig .= "[TIMING SETTINGS]`n"
    defaultConfig .= "ShortDelay=32`n"
    defaultConfig .= "MediumDelay=64`n"
    defaultConfig .= "LongDelay=128`n"
    defaultConfig .= "TooltipDisplayTime=2048`n"
    defaultConfig .= "AutoLoopInterval=128`n`n"
    
    defaultConfig .= "[LOGGING SETTINGS]`n"
    defaultConfig .= "EnableDebugLogging=false`n"
    defaultConfig .= "EnableBackups=false`n"
    defaultConfig .= "LogLevel=INFO`n`n"
    
    defaultConfig .= "[CHARACTER PROFILES]`n"
    defaultConfig .= "MaxProfiles=9`n"
    defaultConfig .= "CurrentProfile=1`n"
    defaultConfig .= "; Rename profiles with Ctrl+Shift+N hotkey`n"
    defaultConfig .= "Profile1Name=Profile 1`n"
    defaultConfig .= "Profile2Name=Profile 2`n"
    defaultConfig .= "Profile3Name=Profile 3`n"
    defaultConfig .= "Profile4Name=Profile 4`n"
    defaultConfig .= "Profile5Name=Profile 5`n"
    defaultConfig .= "Profile6Name=Profile 6`n"
    defaultConfig .= "Profile7Name=Profile 7`n"
    defaultConfig .= "Profile8Name=Profile 8`n"
    defaultConfig .= "Profile9Name=Profile 9`n`n"
    
    ; Add profile-specific auto settings for all 9 profiles
    Loop 9 {
        profileNum := A_Index
        defaultConfig .= "[PROFILE " . profileNum . "]`n"
        defaultConfig .= "; Leave EnableAuto=false and toggle with Middle Mouse Button Click`n"
        defaultConfig .= "EnableAuto=false`n"
        defaultConfig .= "EnableHealthMonitoring=true`n"
        defaultConfig .= "EnableManaMonitoring=true`n"
        defaultConfig .= "; Typically the 'fight' command key. For crossbow profiles, might be 'Nock' key`n"
        defaultConfig .= "AttackKey1=f`n"
        defaultConfig .= "; Typically a secondary (often ranged) attack like 'throw hammer at @[distant:hostile]'`n"
        defaultConfig .= "AttackKey2=e`n"
        defaultConfig .= "; Toggle with Ctrl+Shift+S`n"
        defaultConfig .= "EnableAttackKey2=true`n"
        defaultConfig .= "AttackSpamReduction=true`n"
        defaultConfig .= "DrinkKey=s`n"
        defaultConfig .= "; Set coordinates with Ctrl+Shift+H hotkey`n"
        defaultConfig .= "; Set to the point where you would want to drink a balm (e.g. about the middle of the health bar)`n"
        defaultConfig .= "HealthAreaX=780`n"
        defaultConfig .= "HealthAreaY=685`n"
        defaultConfig .= "; Set coordinates with Ctrl+Shift+M hotkey`n"
        defaultConfig .= "; Set to the point where you would want to use an ability (e.g. the spot that turns blue when you have 10 Qi)`n"
        defaultConfig .= "ManaAreaX=960`n"
        defaultConfig .= "ManaAreaY=640`n"
        defaultConfig .= "; Set coordinates with Ctrl+Shift+C hotkey`n"
        defaultConfig .= "; Set to a spot that will not be the color Black if creatures are presesnt`n"
        defaultConfig .= "CreatureAreaX=1045`n"
        defaultConfig .= "CreatureAreaY=100`n"
        defaultConfig .= "; Toggle with Ctrl+Shift+A`n"
        defaultConfig .= "EnableMASkill=true`n"
        defaultConfig .= "MAFistsKey=r`n"
        defaultConfig .= "MARestockKey=h`n"
        defaultConfig .= "; Toggle between 'fists' and 'restock' with Ctrl+Shift+T`n"
        defaultConfig .= "CurrentMASkill=restock`n`n"
    }
    
    defaultConfig .= "[COIN PICKUP SETTINGS]`n"
    defaultConfig .= "EnableCoinPickup=false`n"
    defaultConfig .= "MoneyRingKey=t`n"
    defaultConfig .= "CoinAreaTopLeftX=20`n"
    defaultConfig .= "CoinAreaTopLeftY=60`n"
    defaultConfig .= "CoinAreaBottomRightX=660`n"
    defaultConfig .= "CoinAreaBottomRightY=700`n"
    defaultConfig .= "CoinDetectionThreshold=1`n"
    defaultConfig .= "CoinColorRedMin=159`n"
    defaultConfig .= "CoinColorRedMax=251`n"
    defaultConfig .= "CoinColorGreenMin=123`n"
    defaultConfig .= "CoinColorGreenMax=234`n"
    defaultConfig .= "CoinColorBlueMin=30`n"
    defaultConfig .= "CoinColorBlueMax=123`n`n"
    
    try {
        FileAppend(defaultConfig, ConfigFile)
        return true
    } catch Error as e {
        LogMessage("Error creating default config: " . e.Message)
        return false
    }
}

; ========================================
; LOGGING FUNCTIONS
; ========================================

; Function to log messages with timestamp
LogMessage(message, level := "INFO") {
    global LogFile, EnableDebugLogging, LogLevel
    
    if (!EnableDebugLogging) {
        return
    }
    
    ; Check log level
    if (level = "DEBUG" && LogLevel != "DEBUG") {
        return
    }
    
    ; Create timestamp with milliseconds
    timestamp := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss.") . A_MSec
    
    ; Format log entry
    logEntry := "[" . timestamp . "] [" . level . "] " . message . "`n"
    
    try {
        FileAppend(logEntry, LogFile)
    } catch Error as e {
        ; If logging fails, show in tooltip as fallback
        ToolTip("Log Error: " . e.Message, , , 9)
        SetTimer(() => ToolTip(, , , 9), -TooltipDisplayTime)
    }
}

; ========================================
; BACKUP FUNCTIONS
; ========================================

; Function to create backup of script and config
CreateBackup() {
    global BackupFolder, ConfigFile, EnableBackups
    
    if (!EnableBackups) {
        return true
    }
    
    try {
        ; Create backup folder if it doesn't exist
        if (!DirExist(BackupFolder)) {
            DirCreate(BackupFolder)
        }
        
        ; Generate timestamp
        timestamp := FormatTime(A_Now, "yyyyMMdd_HHmmss")
        
        ; Backup script file
        scriptBackup := BackupFolder . "\ShScript_Backup_" . timestamp . ".ahk"
        FileCopy(A_ScriptFullPath, scriptBackup)
        
        ; Backup config file if it exists
        if (FileExist(ConfigFile)) {
            configBackup := BackupFolder . "\ShScript_Config_Backup_" . timestamp . ".ini"
            FileCopy(ConfigFile, configBackup)
        }
        
        LogMessage("Backup created: " . scriptBackup)
        return true
        
    } catch Error as e {
        LogMessage("Error creating backup: " . e.Message)
        return false
    }
}

; ========================================
; GAME START/STOP FUNCTIONS
; ========================================

; Function to launch the game
LaunchGame() {
    global GamePath, GameExecutable, AutoClickLogin, AutoMaximizeWindow, UseSecondaryMonitor, SecondaryMonitorNumber
    
    LogMessage("Starting game launch sequence")
    
    ; Check if game is already running
    if (IsGameRunning()) {
        LogMessage("Game is already running")
        return true
    }
    
    try {
        ; First, try the configured path
        ; Ensure GamePath ends with backslash
        if (!InStr(GamePath, "\", , -1)) {
            GamePath := GamePath . "\"
        }
        
        fullPath := GamePath . GameExecutable
        LogMessage("Attempting to launch: " . fullPath)
        
        ; Check if the executable exists at the configured path
        if (!FileExist(fullPath)) {
            LogMessage("Game executable not found at configured path: " . fullPath)
            
            ; Check if the executable is in the same folder as the script
            scriptDir := A_ScriptDir . "\"
            scriptPath := scriptDir . GameExecutable
            LogMessage("Checking script directory: " . scriptPath)
            
            if (FileExist(scriptPath)) {
                LogMessage("Found game executable in script directory, using that instead")
                fullPath := scriptPath
                GamePath := scriptDir
            } else {
                LogMessage("Error: Game executable not found at either location")
                LogMessage("Checked paths: " . fullPath . " and " . scriptPath)
                return false
            }
        }
        
        ; Launch the game
        Run(fullPath, GamePath)
        LogMessage("Game executable launched from: " . GamePath)
        
        ; Wait for game window to appear
        if (WaitForGameWindow()) {
            LogMessage("Game window detected")
            
            ; Move to secondary monitor first if configured
            if (UseSecondaryMonitor) {
                MoveToSecondaryMonitor()
            }
            
            ; Then maximize window if configured
            if (AutoMaximizeWindow) {
                WinMaximize(GameWindowTitle)
                LogMessage("Game window maximized")
            }
            
            ; Auto-click login if configured
            if (AutoClickLogin) {
                Sleep(200)
                ClickLoginButton()
            }
            
            
            LogMessage("Game launch sequence completed successfully")
            return true
        } else {
            LogMessage("Error: Game window not detected within timeout")
            return false
        }
        
    } catch Error as e {
        LogMessage("Error launching game: " . e.Message)
        return false
    }
}

; Function to wait for game window to appear
WaitForGameWindow() {
    global GameWindowTitle
    
    ; Wait up to 15 seconds for game window
    startTime := A_TickCount
    timeout := 15000
    
    while ((A_TickCount - startTime) < timeout) {
        if (WinExist(GameWindowTitle)) {
            ; Check if window is actually visible and reasonably sized
            WinGetPos(&x, &y, &width, &height, GameWindowTitle)
            if (width > 200 && height > 200) {
                return true
            }
        }
        Sleep(LongDelay)  ; Check every LongDelay
    }
    
    return false
}

; Function to move game to secondary monitor
MoveToSecondaryMonitor() {
    global GameWindowTitle, SecondaryMonitorNumber
    
    try {
        ; Get secondary monitor info
        MonitorGet(SecondaryMonitorNumber, &Left, &Top, &Right, &Bottom)
        
        ; Get current window size to preserve it
        WinGetPos(&currentX, &currentY, &currentWidth, &currentHeight, GameWindowTitle)
        
        ; Move window to secondary monitor without changing size
        WinMove(Left, Top, currentWidth, currentHeight, GameWindowTitle)
        LogMessage("Game moved to secondary monitor " . SecondaryMonitorNumber . " at " . Left . "," . Top)
        
    } catch Error as e {
        LogMessage("Error moving to secondary monitor: " . e.Message)
    }
}

; Function to click login button
ClickLoginButton() {
    global LoginButtonX, LoginButtonY, GameWindowTitle
    
    if (LoginButtonX = 0 && LoginButtonY = 0) {
        LogMessage("Login button coordinates not set - use Ctrl+Shift+L to set them")
        return
    }
    
    ; Click relative to the game window using button down/up events
    if (WinExist(GameWindowTitle)) {
        LogMessage("Clicking login button at relative coordinates " . LoginButtonX . "," . LoginButtonY . " within game window")
        
        ; Move mouse to relative position within the game window
        MouseMove(LoginButtonX, LoginButtonY)
        SendClick("Left")
        LogMessage("Login button click sequence completed")
    } else {
        LogMessage("Game window not found - cannot click login button")
    }
}


; Function to monitor game window and exit script if game closes
MonitorGameWindow() {
    if (!IsGameRunning()) {
        LogMessage("Game window closed - exiting script")
        ExitApp()
    }
}

; ========================================
; CHARACTER PROFILE MANAGEMENT FUNCTIONS
; ========================================

; Function to get profile name by number
GetProfileName(profileNumber) {
    global Profile1Name, Profile2Name, Profile3Name, Profile4Name, Profile5Name, Profile6Name, Profile7Name, Profile8Name, Profile9Name
    
    switch profileNumber {
        case 1: return Profile1Name
        case 2: return Profile2Name
        case 3: return Profile3Name
        case 4: return Profile4Name
        case 5: return Profile5Name
        case 6: return Profile6Name
        case 7: return Profile7Name
        case 8: return Profile8Name
        case 9: return Profile9Name
        default: return "Unknown Profile"
    }
}

; Function to load auto settings for a specific profile
LoadProfileAutoSettings(profileNumber) {
    global ConfigFile
    global EnableAuto, EnableHealthMonitoring, EnableManaMonitoring, AttackKey1, AttackKey2, EnableAttackKey2, AttackSpamReduction, DrinkKey, HealthAreaX, HealthAreaY, ManaAreaX, ManaAreaY, CreatureAreaX, CreatureAreaY, EnableMASkill, MAFistsKey, MARestockKey, CurrentMASkill
    
    sectionName := "PROFILE " . profileNumber
    
    try {
        EnableAuto := (IniRead(ConfigFile, sectionName, "EnableAuto", EnableAuto ? "true" : "false") = "true")
        EnableHealthMonitoring := (IniRead(ConfigFile, sectionName, "EnableHealthMonitoring", EnableHealthMonitoring ? "true" : "false") = "true")
        EnableManaMonitoring := (IniRead(ConfigFile, sectionName, "EnableManaMonitoring", EnableManaMonitoring ? "true" : "false") = "true")
        AttackKey1 := IniRead(ConfigFile, sectionName, "AttackKey1", AttackKey1)
        AttackKey2 := IniRead(ConfigFile, sectionName, "AttackKey2", AttackKey2)
        EnableAttackKey2 := (IniRead(ConfigFile, sectionName, "EnableAttackKey2", EnableAttackKey2 ? "true" : "false") = "true")
        AttackSpamReduction := (IniRead(ConfigFile, sectionName, "AttackSpamReduction", AttackSpamReduction ? "true" : "false") = "true")
        DrinkKey := IniRead(ConfigFile, sectionName, "DrinkKey", DrinkKey)
        HealthAreaX := IniRead(ConfigFile, sectionName, "HealthAreaX", HealthAreaX)
        HealthAreaY := IniRead(ConfigFile, sectionName, "HealthAreaY", HealthAreaY)
        ManaAreaX := IniRead(ConfigFile, sectionName, "ManaAreaX", ManaAreaX)
        ManaAreaY := IniRead(ConfigFile, sectionName, "ManaAreaY", ManaAreaY)
        CreatureAreaX := IniRead(ConfigFile, sectionName, "CreatureAreaX", CreatureAreaX)
        CreatureAreaY := IniRead(ConfigFile, sectionName, "CreatureAreaY", CreatureAreaY)
        EnableMASkill := (IniRead(ConfigFile, sectionName, "EnableMASkill", EnableMASkill ? "true" : "false") = "true")
        MAFistsKey := IniRead(ConfigFile, sectionName, "MAFistsKey", MAFistsKey)
        MARestockKey := IniRead(ConfigFile, sectionName, "MARestockKey", MARestockKey)
        CurrentMASkill := IniRead(ConfigFile, sectionName, "CurrentMASkill", CurrentMASkill)
        
        LogMessage("Loaded auto settings for profile " . profileNumber . " - " . GetProfileName(profileNumber))
        return true
    } catch Error as e {
        LogMessage("Error loading auto settings for profile " . profileNumber . ": " . e.Message)
        return false
    }
}

; Function to save auto settings for a specific profile
SaveProfileAutoSettings(profileNumber) {
    global ConfigFile
    global EnableAuto, EnableHealthMonitoring, EnableManaMonitoring, AttackKey1, AttackKey2, EnableAttackKey2, AttackSpamReduction, DrinkKey, HealthAreaX, HealthAreaY, ManaAreaX, ManaAreaY, CreatureAreaX, CreatureAreaY, EnableMASkill, MAFistsKey, MARestockKey, CurrentMASkill
    
    sectionName := "PROFILE " . profileNumber
    
    try {
        IniWrite(EnableAuto ? "true" : "false", ConfigFile, sectionName, "EnableAuto")
        IniWrite(EnableHealthMonitoring ? "true" : "false", ConfigFile, sectionName, "EnableHealthMonitoring")
        IniWrite(EnableManaMonitoring ? "true" : "false", ConfigFile, sectionName, "EnableManaMonitoring")
        IniWrite(AttackKey1, ConfigFile, sectionName, "AttackKey1")
        IniWrite(AttackKey2, ConfigFile, sectionName, "AttackKey2")
        IniWrite(EnableAttackKey2 ? "true" : "false", ConfigFile, sectionName, "EnableAttackKey2")
        IniWrite(AttackSpamReduction ? "true" : "false", ConfigFile, sectionName, "AttackSpamReduction")
        IniWrite(DrinkKey, ConfigFile, sectionName, "DrinkKey")
        IniWrite(HealthAreaX, ConfigFile, sectionName, "HealthAreaX")
        IniWrite(HealthAreaY, ConfigFile, sectionName, "HealthAreaY")
        IniWrite(ManaAreaX, ConfigFile, sectionName, "ManaAreaX")
        IniWrite(ManaAreaY, ConfigFile, sectionName, "ManaAreaY")
        IniWrite(CreatureAreaX, ConfigFile, sectionName, "CreatureAreaX")
        IniWrite(CreatureAreaY, ConfigFile, sectionName, "CreatureAreaY")
        IniWrite(EnableMASkill ? "true" : "false", ConfigFile, sectionName, "EnableMASkill")
        IniWrite(MAFistsKey, ConfigFile, sectionName, "MAFistsKey")
        IniWrite(MARestockKey, ConfigFile, sectionName, "MARestockKey")
        IniWrite(CurrentMASkill, ConfigFile, sectionName, "CurrentMASkill")
        
        LogMessage("Saved auto settings for profile " . profileNumber . " - " . GetProfileName(profileNumber))
        return true
    } catch Error as e {
        LogMessage("Error saving auto settings for profile " . profileNumber . ": " . e.Message)
        return false
    }
}

; Function to switch to a different profile
SwitchProfile(newProfileNumber) {
    global CurrentProfile, MaxProfiles, ConfigFile
    
    if (newProfileNumber < 1 || newProfileNumber > MaxProfiles) {
        LogMessage("Invalid profile number: " . newProfileNumber . " (must be 1-" . MaxProfiles . ")")
        return false
    }
    
    ; Save current profile's settings before switching
    SaveProfileAutoSettings(CurrentProfile)
    
    ; Switch to new profile
    CurrentProfile := newProfileNumber
    
    ; Load new profile's settings
    LoadProfileAutoSettings(CurrentProfile)
    
    ; Save the current profile to config
    IniWrite(CurrentProfile, ConfigFile, "CHARACTER PROFILES", "CurrentProfile")
    
    LogMessage("Switched to profile " . CurrentProfile . " - " . GetProfileName(CurrentProfile))
    return true
}

; Function to rename a profile
RenameProfile(profileNumber, newName) {
    global ConfigFile, MaxProfiles
    global Profile1Name, Profile2Name, Profile3Name, Profile4Name, Profile5Name, Profile6Name, Profile7Name, Profile8Name, Profile9Name
    
    if (profileNumber < 1 || profileNumber > MaxProfiles) {
        LogMessage("Invalid profile number: " . profileNumber . " (must be 1-" . MaxProfiles . ")")
        return false
    }
    
    try {
        IniWrite(newName, ConfigFile, "CHARACTER PROFILES", "Profile" . profileNumber . "Name")
        
        ; Update the global variable
        switch profileNumber {
            case 1: Profile1Name := newName
            case 2: Profile2Name := newName
            case 3: Profile3Name := newName
            case 4: Profile4Name := newName
            case 5: Profile5Name := newName
            case 6: Profile6Name := newName
            case 7: Profile7Name := newName
            case 8: Profile8Name := newName
            case 9: Profile9Name := newName
        }
        
        LogMessage("Renamed profile " . profileNumber . " to: " . newName)
        return true
    } catch Error as e {
        LogMessage("Error renaming profile " . profileNumber . ": " . e.Message)
        return false
    }
}

; Function to switch to a profile (hotkey helper)
SwitchToProfile(profileNumber) {
    global CurrentProfile
    
    if (SwitchProfile(profileNumber)) {
        ToolTip("Switched to Profile " . profileNumber . " - " . GetProfileName(profileNumber), , , 11)
        SetTimer(() => ToolTip(, , , 11), -TooltipDisplayTime)
    } else {
        ToolTip("Failed to switch to Profile " . profileNumber, , , 11)
        SetTimer(() => ToolTip(, , , 11), -TooltipDisplayTime)
    }
}

; Function to show profile rename dialog (hotkey helper)
RenameProfileDialog(profileNumber) {
    global MaxProfiles
    
    if (profileNumber < 1 || profileNumber > MaxProfiles) {
        ToolTip("Invalid profile number: " . profileNumber, , , 12)
        SetTimer(() => ToolTip(, , , 12), -TooltipDisplayTime)
        return
    }
    
    currentName := GetProfileName(profileNumber)
    newName := InputBox("Rename Profile " . profileNumber, "Enter new name for profile " . profileNumber . ":", currentName)
    
    if (newName.Result = "OK" && newName.Value != "") {
        if (RenameProfile(profileNumber, newName.Value)) {
            ToolTip("Profile " . profileNumber . " renamed to: " . newName.Value, , , 12)
        } else {
            ToolTip("Failed to rename Profile " . profileNumber, , , 12)
        }
    } else {
        ToolTip("Profile rename cancelled", , , 12)
    }
    SetTimer(() => ToolTip(, , , 12), -TooltipDisplayTime)
}

; Function to show profile information (hotkey helper)
ShowProfileInfo(profileNumber) {
    global MaxProfiles, EnableAuto, EnableHealthMonitoring, EnableManaMonitoring, AttackKey1, AttackKey2
    
    if (profileNumber < 1 || profileNumber > MaxProfiles) {
        ToolTip("Invalid profile number: " . profileNumber, , , 13)
        SetTimer(() => ToolTip(, , , 13), -TooltipDisplayTime)
        return
    }
    
    profileName := GetProfileName(profileNumber)
    autoStatus := EnableAuto ? "Enabled" : "Disabled"
    healthStatus := EnableHealthMonitoring ? "Enabled" : "Disabled"
    manaStatus := EnableManaMonitoring ? "Enabled" : "Disabled"
    
    info := "Profile " . profileNumber . ": " . profileName . "`n"
    info .= "Auto: " . autoStatus . "`n"
    info .= "Health Monitor: " . healthStatus . "`n"
    info .= "Mana Monitor: " . manaStatus . "`n"
    info .= "Attack Keys: " . AttackKey1 . ", " . AttackKey2
    
    ToolTip(info, , , 13)
    SetTimer(() => ToolTip(, , , 13), -TooltipDisplayTime * 2)
}

; Function to get current profile name (helper for Ctrl+Shift+` hotkey)
GetCurrentProfileName() {
    global CurrentProfile
    return GetProfileName(CurrentProfile)
}

; Function to rename current profile (hotkey helper)
RenameCurrentProfileDialog() {
    global CurrentProfile
    
    currentName := GetProfileName(CurrentProfile)
    newName := InputBox("Rename Current Profile", "Enter new name for current profile (" . CurrentProfile . "):", , currentName)
    
    if (newName.Result = "OK" && newName.Value != "") {
        if (RenameProfile(CurrentProfile, newName.Value)) {
            ToolTip("Current profile renamed to: " . newName.Value, , , 12)
        } else {
            ToolTip("Failed to rename current profile", , , 12)
        }
    } else {
        ToolTip("Profile rename cancelled", , , 12)
    }
    SetTimer(() => ToolTip(, , , 12), -TooltipDisplayTime)
}

; Function to show current profile info (hotkey helper)
ShowCurrentProfileInfo() {
    global CurrentProfile, EnableAuto, EnableHealthMonitoring, EnableManaMonitoring, AttackKey1, AttackKey2
    
    profileName := GetProfileName(CurrentProfile)
    autoStatus := EnableAuto ? "Enabled" : "Disabled"
    healthStatus := EnableHealthMonitoring ? "Enabled" : "Disabled"
    manaStatus := EnableManaMonitoring ? "Enabled" : "Disabled"
    
    info := "Current Profile: " . CurrentProfile . " - " . profileName . "`n"
    info .= "Auto: " . autoStatus . "`n"
    info .= "Health Monitor: " . healthStatus . "`n"
    info .= "Mana Monitor: " . manaStatus . "`n"
    info .= "Attack Keys: " . AttackKey1 . ", " . AttackKey2
    
    ToolTip(info, , , 13)
    SetTimer(() => ToolTip(, , , 13), -TooltipDisplayTime * 2)
}

; ========================================
; AUTOMATION FUNCTIONS
; ========================================

; Main automation loop - runs continuously when Auto mode is enabled
AutoLoop() {
    global EnableAuto, GameWindowTitle
    
    ; Only run if Auto mode is enabled and game is running
    if (!EnableAuto || !IsGameRunning()) {
        return
    }
    
    ; Continuously determine the next action (regardless of ready state)
    static lastAction := ""
    currentAction := GetNextAction()
    
    ; If action changed, log it
    if (currentAction != lastAction) {
        if (currentAction != "") {
            LogMessage("Auto: Next action determined: " . currentAction)
        } else {
            LogMessage("Auto: No action needed")
        }
        lastAction := currentAction
    }
    
    ; Only execute if we have an action and player is ready
    if (currentAction != "" && CheckReady()) {
        ExecuteAction(currentAction)
    }
}

; Determine the next action based on priority
GetNextAction() {
    global EnableHealthMonitoring, EnableManaMonitoring, EnableMASkill, AttackKey1, AttackKey2, EnableAttackKey2, AttackSpamReduction
    
    ; Priority 1: Health is low - heal immediately
    if (EnableHealthMonitoring && !CheckHealth()) {
        return "HEAL"
    }
    
    ; Priority 2: MASkill - if enabled and has mana
    if (EnableMASkill && EnableManaMonitoring && CheckMana()) {
        return "MASKILL"
    }
    
    ; Priority 3: Attack - if we have attack keys configured
    if (AttackKey1 != "" || (EnableAttackKey2 && AttackKey2 != "")) {
        ; Check if AttackSpamReduction is enabled and creatures are present
        if (AttackSpamReduction && !CheckCreatures()) {
            LogMessage("Auto: No creatures detected - skipping attack")
            return ""  ; No action if no creatures
        }
        return "ATTACK"
    }
    
    ; No action needed
    return ""
}

; Execute the determined action
ExecuteAction(action) {
    global AttackKey1, AttackKey2, EnableAttackKey2, DrinkKey, MAFistsKey, MARestockKey, CurrentMASkill
    
    switch action {
        case "HEAL":
            if (DrinkKey != "") {
                SendKey(DrinkKey)
                LogMessage("Auto: Executed drink action")
            }
        case "MASKILL":
            if (CurrentMASkill = "fists") {
                ; Send MAFistsKey then AttackKey2 (if enabled)
                if (MAFistsKey != "") {
                    SendKey(MAFistsKey)
                }
                if (EnableAttackKey2 && AttackKey2 != "") {
                    Sleep(ShortDelay)  ; Delay between keys
                    SendKey(AttackKey2)
                }
                LogMessage("Auto: Executed MA Fists action")
            } else if (CurrentMASkill = "restock") {
                ; Send MARestockKey then AttackKey1 and AttackKey2 (if enabled)
                if (MARestockKey != "") {
                    SendKey(MARestockKey)
                }
                if (AttackKey1 != "") {
                    Sleep(ShortDelay)  ; Delay between keys
                    SendKey(AttackKey1)
                }
                if (EnableAttackKey2 && AttackKey2 != "") {
                    Sleep(ShortDelay)  ; Delay between keys
                    SendKey(AttackKey2)
                }
                LogMessage("Auto: Executed MA Restock action")
            }
        case "ATTACK":
            ; Send both attack keys in sequence (e.g. melee & ranged)
            if (AttackKey1 != "") {
                LogMessage("Auto: Sending AttackKey1: " . AttackKey1)
                SendKey(AttackKey1)
            }
            if (EnableAttackKey2 && AttackKey2 != "") {
                Sleep(ShortDelay)  ; Delay between keys
                LogMessage("Auto: Sending AttackKey2: " . AttackKey2)
                SendKey(AttackKey2)
            }
            LogMessage("Auto: Completed attack sequence")
    }
}


; ========================================
; UTILITY FUNCTIONS
; ========================================

; SendKey - Sends key down/up events with delay
SendKey(key, delay := 0) {
    global ShortDelay
    try {
        SendInput("{" . key . " down}")
        if (delay > 0) {
            Sleep(delay)
        } else {
            Sleep(ShortDelay)
        }
        SendInput("{" . key . " up}")
        LogMessage("SendKey: Sent key " . key . " with delay " . (delay > 0 ? delay : ShortDelay) . "ms")
        return true
    } catch Error as e {
        LogMessage("SendKey: Error sending key " . key . ": " . e.Message)
        return false
    }
}

; SendClick - Sends mouse button down/up events with delay
SendClick(button := "Left", delay := 0) {
    global ShortDelay
    try {
        Click(button . " Down")
        if (delay > 0) {
            Sleep(delay)
        } else {
            Sleep(ShortDelay)
        }
        Click(button . " Up")
        LogMessage("SendClick: Sent " . button . " click with delay " . (delay > 0 ? delay : ShortDelay) . "ms")
        return true
    } catch Error as e {
        LogMessage("SendClick: Error sending " . button . " click: " . e.Message)
        return false
    }
}

; Function to check if game is running
IsGameRunning() {
    global GameWindowTitle
    return WinExist(GameWindowTitle)
}

; Function to count pixels of a specific color at given coordinates
CountPixels(x, y, colorType) {
    pixelCount := 0
    for offset in [-1, 0, 1] {
        pixelX := x + offset
        pixelY := y
        color := PixelGetColor(pixelX, pixelY, "RGB")
        red := (color >> 16) & 0xFF
        green := (color >> 8) & 0xFF
        blue := color & 0xFF
        
        if (colorType = "red") {
            if (red > 100 && green < 50 && blue < 50) {
                pixelCount++
            }
        } else if (colorType = "blue") {
            if (blue > 100 && red < 50 && green < 50) {
                pixelCount++
            }
        }
    }
    return pixelCount
}

; Function to count red pixels at given coordinates (for health)
CountRedPixels(x, y) {
    return CountPixels(x, y, "red")
}

; Function to count blue pixels at given coordinates (for mana)
CountBluePixels(x, y) {
    return CountPixels(x, y, "blue")
}

; Function to check health status by examining red pixels
CheckHealth() {
    global HealthAreaX, HealthAreaY, GameWindowTitle
    
    if (!IsGameRunning()) {
        LogMessage("Cannot check health - game not running")
        return false
    }
    
    try {
        redPixelCount := CountRedPixels(HealthAreaX, HealthAreaY)
        
        ; Consider healthy if at least 2 out of 3 pixels are red
        isHealthy := redPixelCount >= 2
        
        LogMessage("Health check - Red pixels: " . redPixelCount . "/3, Healthy: " . (isHealthy ? "Yes" : "No"))
        
        return isHealthy
        
    } catch Error as e {
        LogMessage("Error checking health: " . e.Message)
        return false
    }
}

; Function to check mana status by examining blue pixels
CheckMana() {
    global ManaAreaX, ManaAreaY, GameWindowTitle
    
    if (!IsGameRunning()) {
        LogMessage("Cannot check mana - game not running")
        return false
    }
    
    try {
        bluePixelCount := CountBluePixels(ManaAreaX, ManaAreaY)
        
        ; Consider sufficient mana if at least 2 out of 3 pixels are blue
        hasMana := bluePixelCount >= 2
        
        LogMessage("Mana check - Blue pixels: " . bluePixelCount . "/3, Has Mana: " . (hasMana ? "Yes" : "No"))
        
        return hasMana
        
    } catch Error as e {
        LogMessage("Error checking mana: " . e.Message)
        return false
    }
}

; Check if creatures are present (black pixels = no creatures)
CheckCreatures() {
    global CreatureAreaX, CreatureAreaY
    
    if (CreatureAreaX = 0 && CreatureAreaY = 0) {
        LogMessage("CreatureCheck: Coordinates not set - assuming creatures present")
        return true  ; Default to true if coordinates not set
    }
    
    try {
        ; Get pixel color at creature area
        pixelColor := PixelGetColor(CreatureAreaX, CreatureAreaY)
        
        ; Extract RGB values
        red := (pixelColor >> 16) & 0xFF
        green := (pixelColor >> 8) & 0xFF
        blue := pixelColor & 0xFF
        
        ; Check if pixel is black (all RGB values close to 0)
        isBlack := (red < 50 && green < 50 && blue < 50)
        
        ; Black = no creatures, non-black = creatures present
        creaturesPresent := !isBlack
        
        LogMessage("CreatureCheck: Pixel at " . CreatureAreaX . "," . CreatureAreaY . " - RGB(" . red . "," . green . "," . blue . ") - Creatures: " . (creaturesPresent ? "YES" : "NO"))
        return creaturesPresent
        
    } catch Error as e {
        LogMessage("CreatureCheck: Error checking creatures: " . e.Message)
        return true  ; Default to true on error
    }
}

; Function to check if player is ready to act based on cursor state
CheckReady(reset := false) {
    static lastCursorHandle := 0
    static readyHandles := Map() ; Map of cursor handles that indicate READY state
    static busyHandles := Map() ; Map of cursor handles that indicate BUSY state
    
    ; Reset learned handles if requested
    if (reset) {
        readyHandles.Clear()
        busyHandles.Clear()
        lastCursorHandle := 0
        LogMessage("CheckReady: Resetting learned cursor handles")
    }
    
    ; Calculate CURSORINFO size (16 bytes for 32-bit, 24 bytes for 64-bit)
    cursorInfoSize := 4 + 4 + A_PtrSize * 2 ; cbSize (4) + flags (4) + hCursor (Ptr) + POINT (2*Ptr)
    cursorInfo := Buffer(cursorInfoSize, 0)
    NumPut("UInt", cursorInfoSize, cursorInfo, 0) ; Set cbSize
    
    ; Call GetCursorInfo
    if (!DllCall("user32\GetCursorInfo", "Ptr", cursorInfo.Ptr)) {
        LogMessage("CheckReady: GetCursorInfo failed, error code: " . A_LastError)
        return true ; Default to ready on error
    }
    
    ; Extract cursor handle (offset 8, after cbSize and flags)
    currentCursorHandle := NumGet(cursorInfo, 8, "Ptr")
    
    ; If cursor handle changed, we need to learn the new state
    if (lastCursorHandle != currentCursorHandle) {
        lastCursorHandle := currentCursorHandle
        
        ; If this is a new handle, assume it's READY initially
        if (!readyHandles.Has(currentCursorHandle) && !busyHandles.Has(currentCursorHandle)) {
            readyHandles[currentCursorHandle] := true
            LogMessage("CheckReady: New handle " . currentCursorHandle . " - assuming READY")
        }
    }
    
    ; Determine if ready based on learned handles
    isReady := readyHandles.Has(currentCursorHandle)
    
    ; Log only when state changes or periodically
    static lastLogTime := 0
    currentTime := A_TickCount
    if (isReady != readyHandles.Has(lastCursorHandle) || (currentTime - lastLogTime) > 5000) {
        LogMessage("CheckReady: Handle " . currentCursorHandle . " - " . (isReady ? "READY" : "BUSY"))
        lastLogTime := currentTime
    }
    
    return isReady
}

; ========================================
; HOTKEYS
; ========================================

; Ctrl+Shift+F1 - Show help
^+F1::{
    helpText := "ShScript`n`n"

    helpText .= "Middle Click : Toggle Auto mode`n`n"

    helpText .= "Ctrl+Shift+F1 : Show this help`n"
    helpText .= "Ctrl+Shift+1-9 : Switch to profile 1-9`n"
    helpText .= "Ctrl+Shift+` : Show current profile`n"
    helpText .= "Ctrl+Shift+L : Set login button coordinates`n"
    helpText .= "Ctrl+Shift+H : Set health area coordinates`n"
    helpText .= "Ctrl+Shift+M : Set mana area coordinates`n"
    helpText .= "Ctrl+Shift+C : Set creature detection coordinates`n"
    helpText .= "Ctrl+Shift+N : Rename current profile`n"
    helpText .= "Ctrl+Shift+S : Toggle second attack key`n"
    helpText .= "Ctrl+Shift+E : Swap attack keys`n"
    helpText .= "Ctrl+Shift+A : Toggle MA Skill on/off`n"
    helpText .= "Ctrl+Shift+T : Toggle MA Skill mode (fists/restock)`n"
    helpText .= "Ctrl+Shift+Q : Exit script`n`n"

    helpText .= "More features coming soon..."
    
    ToolTip(helpText, , , 2)
    SetTimer(() => ToolTip(, , , 2), -10000)
}

; Ctrl+Shift+` - Show current profile
^+`::ShowCurrentProfileInfo()

; Ctrl+Shift+L - Set login button coordinates
^+l::{
    
    MouseGetPos(&mouseX, &mouseY)
    LoginButtonX := mouseX
    LoginButtonY := mouseY
    
    ; Save to config file
    IniWrite(LoginButtonX, ConfigFile, "GAME SETTINGS", "LoginButtonX")
    IniWrite(LoginButtonY, ConfigFile, "GAME SETTINGS", "LoginButtonY")
    
    ToolTip("Login button coordinates set to " . LoginButtonX . "," . LoginButtonY, , , 10)
    SetTimer(() => ToolTip(, , , 10), -TooltipDisplayTime)
    LogMessage("Login button coordinates set to " . LoginButtonX . "," . LoginButtonY)
}

; Ctrl+Shift+H - Set health area coordinates for current profile
^+h::{
    global HealthAreaX, HealthAreaY, CurrentProfile
    
    MouseGetPos(&mouseX, &mouseY)
    HealthAreaX := mouseX
    HealthAreaY := mouseY
    
    ; Check how many pixels are red at this location
    redPixelCount := CountRedPixels(HealthAreaX, HealthAreaY)
    
    ; Save to current profile (after updating global variables)
    SaveProfileAutoSettings(CurrentProfile)
    
    ToolTip("Health area coordinates set to " . HealthAreaX . "," . HealthAreaY . " for " . GetProfileName(CurrentProfile) . "`nRed pixels detected: " . redPixelCount . "/3", , , 12)
    SetTimer(() => ToolTip(, , , 12), -TooltipDisplayTime)
    LogMessage("Health area coordinates set to " . HealthAreaX . "," . HealthAreaY . " for profile " . CurrentProfile . " - Red pixels: " . redPixelCount . "/3")
}

; Ctrl+Shift+M - Set mana area coordinates for current profile
^+m::{
    global ManaAreaX, ManaAreaY, CurrentProfile
    
    MouseGetPos(&mouseX, &mouseY)
    ManaAreaX := mouseX
    ManaAreaY := mouseY
    
    ; Save to current profile
    SaveProfileAutoSettings(CurrentProfile)
    
    ToolTip("Mana area coordinates set to " . ManaAreaX . "," . ManaAreaY . " for " . GetProfileName(CurrentProfile), , , 14)
    SetTimer(() => ToolTip(, , , 14), -TooltipDisplayTime)
    LogMessage("Mana area coordinates set to " . ManaAreaX . "," . ManaAreaY . " for profile " . CurrentProfile)
}

; Ctrl+Shift+C - Set creature area coordinates for current profile
^+c::{
    global CreatureAreaX, CreatureAreaY, CurrentProfile
    
    MouseGetPos(&mouseX, &mouseY)
    CreatureAreaX := mouseX
    CreatureAreaY := mouseY
    
    ; Save to current profile
    SaveProfileAutoSettings(CurrentProfile)
    
    ToolTip("Creature area coordinates set to " . CreatureAreaX . "," . CreatureAreaY . " for " . GetProfileName(CurrentProfile), , , 17)
    SetTimer(() => ToolTip(, , , 17), -TooltipDisplayTime)
    LogMessage("Creature area coordinates set to " . CreatureAreaX . "," . CreatureAreaY . " for profile " . CurrentProfile)
}

; Ctrl+Shift+Q - Exit script
^+q::{
    LogMessage("Script exiting by user request")
    ToolTip("Closing ShScript", , , 8)
    SetTimer(() => ToolTip(, , , 8), -TooltipDisplayTime)
    Sleep(TooltipDisplayTime)
    ExitApp()
}

; Ctrl+Shift+1-9 - Switch to profile 1-9
^+1::SwitchToProfile(1)
^+2::SwitchToProfile(2)
^+3::SwitchToProfile(3)
^+4::SwitchToProfile(4)
^+5::SwitchToProfile(5)
^+6::SwitchToProfile(6)
^+7::SwitchToProfile(7)
^+8::SwitchToProfile(8)
^+9::SwitchToProfile(9)

; Ctrl+Shift+N - Rename current profile
^+n::RenameCurrentProfileDialog()

; Middle Click - Toggle Auto mode
MButton::{
    global EnableAuto, AutoLoopInterval, AttackSpamReduction
    
    EnableAuto := !EnableAuto
    status := EnableAuto ? "ENABLED" : "DISABLED"
    
    if (EnableAuto) {
        ; Switch to creature list first if AttackSpamReduction is enabled
        if (AttackSpamReduction) {
            ; Send Alt+L to switch to creature list
            SendInput("{Alt down}")
            Sleep(ShortDelay)
            SendInput("{l down}")
            Sleep(ShortDelay)
            SendInput("{l up}")
            Sleep(ShortDelay)
            SendInput("{Alt up}")
            LogMessage("Auto mode: Switched to creature list for creature detection")
            Sleep(LongDelay)  ; Wait for creature list to load
        }
        
        ; Start the automation timer after creature list switch
        SetTimer(AutoLoop, AutoLoopInterval)
        LogMessage("Auto mode ENABLED - starting automation loop (interval: " . AutoLoopInterval . "ms)")
    } else {
        ; Stop the automation timer
        SetTimer(AutoLoop, 0)
        LogMessage("Auto mode DISABLED - stopping automation loop")
    }
    
    ToolTip("Auto mode " . status, , , 14)
    SetTimer(() => ToolTip(, , , 14), -TooltipDisplayTime)
}

; Ctrl+Shift+S - Toggle second attack key
^+s::{
    global EnableAttackKey2, CurrentProfile
    
    EnableAttackKey2 := !EnableAttackKey2
    status := EnableAttackKey2 ? "ENABLED" : "DISABLED"
    
    ; Save to current profile
    SaveProfileAutoSettings(CurrentProfile)
    
    ToolTip("Second attack " . status . " for " . GetProfileName(CurrentProfile), , , 15)
    SetTimer(() => ToolTip(, , , 15), -TooltipDisplayTime)
    
    LogMessage("Second attack " . status . " for profile " . CurrentProfile . " - " . GetProfileName(CurrentProfile))
}

; Ctrl+Shift+E - Swap attack keys
^+e::{
    global AttackKey1, AttackKey2, CurrentProfile
    
    ; Swap the keys
    tempKey := AttackKey1
    AttackKey1 := AttackKey2
    AttackKey2 := tempKey
    
    ; Save to current profile
    SaveProfileAutoSettings(CurrentProfile)
    
    ToolTip("Attack keys swapped for " . GetProfileName(CurrentProfile) . "`nPrimary: " . AttackKey1 . " | Secondary: " . AttackKey2, , , 16)
    SetTimer(() => ToolTip(, , , 16), -TooltipDisplayTime)
    
    LogMessage("Attack keys swapped for profile " . CurrentProfile . " - Primary: " . AttackKey1 . ", Secondary: " . AttackKey2)
}

; Ctrl+Shift+A - Toggle EnableMASkill
^+a::{
    global EnableMASkill, CurrentProfile
    
    EnableMASkill := !EnableMASkill
    status := EnableMASkill ? "ENABLED" : "DISABLED"
    
    ; Save to current profile
    SaveProfileAutoSettings(CurrentProfile)
    
    ToolTip("MA Skill " . status . " for " . GetProfileName(CurrentProfile), , , 18)
    SetTimer(() => ToolTip(, , , 18), -TooltipDisplayTime)
    
    LogMessage("MA Skill " . status . " for profile " . CurrentProfile . " - " . GetProfileName(CurrentProfile))
}

; Ctrl+Shift+T - Toggle CurrentMASkill between fists and restock
^+t::{
    global CurrentMASkill, CurrentProfile
    
    if (CurrentMASkill = "fists") {
        CurrentMASkill := "restock"
    } else {
        CurrentMASkill := "fists"
    }
    
    ; Save to current profile
    SaveProfileAutoSettings(CurrentProfile)
    
    ToolTip("MA Skill mode: " . CurrentMASkill . " for " . GetProfileName(CurrentProfile), , , 19)
    SetTimer(() => ToolTip(, , , 19), -TooltipDisplayTime)
    
    LogMessage("MA Skill mode changed to " . CurrentMASkill . " for profile " . CurrentProfile . " - " . GetProfileName(CurrentProfile))
}

; ========================================
; SCRIPT EXECUTION
; ========================================

; Load configuration first
if (!LoadConfig()) {
    LogMessage("No configuration file detected, using default configuration.")
    MsgBox("No configuration file found, using default configuration.`n`nThis is normal on first run - the config file will be created automatically.`n`nCheck the ShScript_Config.ini for additional instructions.", "Configuration Notice", "OK")
}

; Create backup after config is loaded (so debug logging setting is respected)
CreateBackup()

; Log script startup
LogMessage("ShScript started")

; Show startup tooltip
ToolTip("Starting ShScript", , , 9)
SetTimer(() => ToolTip(, , , 9), -TooltipDisplayTime)

; Check if game is already running
if (IsGameRunning()) {
    GameRunning := true
    LogMessage("Game already running - script ready")
} else {
    LogMessage("Game not running - attempting to launch")
    if (LaunchGame()) {
        GameRunning := true
        LogMessage("Game launched successfully")
    } else {
        LogMessage("Failed to launch game - script ready for manual launch")
    }
}

; Start monitoring game window (check every 2 seconds)
SetTimer(MonitorGameWindow, TooltipDisplayTime)

; End of script