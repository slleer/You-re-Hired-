Scriptname YoureHiredMCM extends SKI_ConfigBase

YoureHiredMerchantPropertiesScript property FixedProperties auto
Quest property YoureHired auto
; Merchant Manager properties
string property MM_NuberOfMerchantsText auto
string property MM_SelectedMerchantName auto
string property MM_SelectedJobType auto
string property MM_ClickHereText auto
string[] property MM_MerchantNames auto
string[] property MM_JobTypes auto
BusinessScript property MM_ThisMerchant auto
BusinessScript[] property MM_MerchantsList auto
bool property MM_OptionsEnabled auto
bool property MM_FenceFlag auto

; Merchant Manger ids
int property oid_MerchantManager_NumberOfMerchantsText auto
int property oid_MerchantManager_MerchantsList auto
int property oid_MerchantManager_JobTypesList auto
int property oid_MerchantManager_FenceToggle auto
int property oid_MerchantManager_ClearMerchant auto
int property oid_MerchantManager_ClearAllMerchants auto


; Settings properties
bool property S_AllowChildren auto
bool property S_AllowAnimals auto
bool property S_FenceEnabled auto
bool property S_RecruitmentEnabled auto
bool property S_RepeatEnabled auto
bool property S_ResetVanillaEnabled auto
bool property S_RequireTwoKeys auto
bool property S_EnableHotKeyUse auto
bool property S_ResetOnMenuClose auto
bool property S_LowCountReset auto
bool property S_ShowDropMessage auto
bool property S_DestroyOnRemoval auto
bool property S_OverStockedEnabled auto
; bool property S_VanillaHotkeyEnabled auto
float property S_NumDaysBetweenReset auto
float property S_MaxGoldInChest auto
int property S_ExtraStartingGold auto
int property S_Hotkey auto
int property S_SecondaryHotkey auto
int property S_MinGOldAmount auto



; Settings ids
int property oid_Settings_AllowChildren auto
int property oid_Settings_AllowAnimals auto
int property oid_Settings_FenceEnabled auto
int property oid_Settings_RecruitmentEnabled auto
int property oid_Settings_RepeatEnabled auto
int property oid_Settings_ResetVanillaEnabled auto
int property oid_Settings_DaysBetweenReset auto
int property oid_Settings_ResetOnMenuClose auto
int property oid_Settings_ShowDropMessage auto
; int property oid_Settings_VanillaHotkeyEnabled auto
int property oid_Settings_EnableHotKeyUse auto
int property oid_Settings_RequireTwoKeys auto
int property oid_Settings_ResetHotkey auto
int property oid_Settings_SecondaryResetHotkey auto
int property oid_Settings_LowCountReset auto
int property oid_Settings_DestroyOnRemoval auto 
int property oid_Settings_OverStockedMerchants auto
int property oid_Settings_ExtraStartingGold auto
int property oid_Settings_MaxGoldInChest auto

Event OnConfigInit()
    S_AllowAnimals = false
    S_AllowChildren = false
    S_FenceEnabled = false
    S_RecruitmentEnabled = false
    S_RepeatEnabled = false
    S_ResetVanillaEnabled = false
    S_ShowDropMessage = FixedProperties.GetShowDropMessage()
    S_EnableHotKeyUse = FixedProperties.EnableHotKeyUse
    S_RequireTwoKeys = FixedProperties.RequireTwoKeys
    S_MaxGoldInChest = 6800.0
    S_MinGOldAmount = 1800
    S_NumDaysBetweenReset = FixedProperties.DaysBeforeReset
    S_ResetOnMenuClose = FixedProperties.ResetOnMenuClose
    S_LowCountReset = FixedProperties.LowCountReset
    S_DestroyOnRemoval = FixedProperties.IsDestroyOnRemoval()
    S_ExtraStartingGold = FixedProperties.ExtraGoldAmount
    S_OverStockedEnabled = FixedProperties.OverStockedcMerchant
    If (Game.UsingGamepad())
        S_Hotkey = 281 ; R-Trigger
        S_SecondaryHotkey = 280 ; L-Trigger
    Else
        S_Hotkey = 38 ; L
        S_SecondaryHotkey = 157 ; R crtl
    EndIf
    FixedProperties.Hotkey = S_Hotkey
    FixedProperties.SecondaryHotkey = S_SecondaryHotkey
    MM_FenceFlag = false
    MM_OptionsEnabled = false
    MM_SelectedMerchantName = "Select A Merchant"
    MM_SelectedJobType = "Current Merchant Type"
    MM_ClickHereText = "Click Here"

    ModName = "You're Hired!"
    Pages = new string[3]
    Pages[0] = YoureHiredMCM_SettingsPage.GetPageName()
    Pages[1] = YoureHiredMCM_MerchantManagementPage.GetPageName()
    Pages[2] = YoureHiredMCM_StoreManagerPage.GetPageName()
EndEvent

string Function GetCustomControl(int keyCode)
    If (keyCode == S_Hotkey)
        Return "Reset merchant chest"
    ElseIf (keyCode == S_SecondaryHotkey)
        Return "Reset merchant chest"
    EndIf
EndFunction

Event OnPageReset(string page)
    if page == YoureHiredMCM_HomePage.GetPageName()
        YoureHiredMCM_HomePage.RenderPage(self, page)
    elseif page == YoureHiredMCM_SettingsPage.GetPageName()
        YoureHiredMCM_SettingsPage.RenderPage(self, page)
    elseif page == YoureHiredMCM_MerchantManagementPage.GetPageName()
        if !MM_MerchantsList
            MM_MerchantsList = FixedProperties.MerchantManager.GetMerchantAliasScripts()
        endIf
        If !MM_JobTypes
            MM_JobTypes = FixedProperties.GetChestTypeText()
        EndIf
        MM_MerchantNames = FixedProperties.MerchantManager.GetMerchantNames()
        YoureHiredMCM_MerchantManagementPage.RenderPage(self, page)
    elseif page == YoureHiredMCM_StoreManagerPage.GetPageName()
        YoureHiredMCM_StoreManagerPage.RenderPage(self, page)
    endIf
EndEvent


Event OnOptionHighlight(int optionId)
    if CurrentPage == YoureHiredMCM_SettingsPage.GetPageName()
        YoureHiredMCM_SettingsPage.OnHighlight(self, optionId)
    elseIf CurrentPage == YoureHiredMCM_MerchantManagementPage.GetPageName()        
        YoureHiredMCM_MerchantManagementPage.OnHighlight(self, optionId)
    endIf
EndEvent

Event OnOptionSelect(int optionId)
    if CurrentPage == YoureHiredMCM_SettingsPage.GetPageName()
        YoureHiredMCM_SettingsPage.OnSelect(self, optionId)
    elseIf CurrentPage == YoureHiredMCM_MerchantManagementPage.GetPageName()        
        YoureHiredMCM_MerchantManagementPage.OnSelect(self, optionId)
    endIf
EndEvent

Event OnOptionDefault(int optionId)
    if CurrentPage == YoureHiredMCM_SettingsPage.GetPageName()
        YoureHiredMCM_SettingsPage.OnDefault(self, optionId)
    elseIf CurrentPage == YoureHiredMCM_MerchantManagementPage.GetPageName()        
        YoureHiredMCM_MerchantManagementPage.OnDefault(self, optionId)
    endIf
EndEvent

Event OnOptionMenuOpen(int option)
    if CurrentPage == YoureHiredMCM_MerchantManagementPage.GetPageName()        
        YoureHiredMCM_MerchantManagementPage.OnMenuOpen(self, option)
    ; elseIf CurrentPage == YoureHiredMCM_SettingsPage.GetPageName()
    endIf
EndEvent

Event OnOptionMenuAccept(int option, int index)
    if CurrentPage == YoureHiredMCM_MerchantManagementPage.GetPageName()
        YoureHiredMCM_MerchantManagementPage.OnMenuAccept(self, option, index)
    ; elseIf CurrentPage == YoureHiredMCM_SettingsPage.GetPageName()
    endIf
EndEvent

Event OnOptionSliderOpen(int optionId)
    if CurrentPage == YoureHiredMCM_SettingsPage.GetPageName()
        YoureHiredMCM_SettingsPage.OnSliderOpen(self, optionId)
    elseIf CurrentPage == YoureHiredMCM_MerchantManagementPage.GetPageName()
        YoureHiredMCM_MerchantManagementPage.OnSliderOpen(self, optionId)
    endIf
EndEvent

Event OnOptionSliderAccept(int optionId, float value)
    if CurrentPage == YoureHiredMCM_SettingsPage.GetPageName()
        YoureHiredMCM_SettingsPage.OnSliderAccept(self, optionId, value)
    elseIf CurrentPage == YoureHiredMCM_MerchantManagementPage.GetPageName()
        YoureHiredMCM_MerchantManagementPage.OnSliderAccept(self, optionId, value)
    endIf
EndEvent

event OnOptionKeyMapChange(int optionId, int keyCode, string conflictControl, string conflictName)
    if CurrentPage == YoureHiredMCM_SettingsPage.GetPageName()
        YoureHiredMCM_SettingsPage.OnKeyMapChanged(self, optionId, keyCode, conflictControl, conflictName)
    endIf
EndEvent