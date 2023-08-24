﻿#SingleInstance
SendMode "Event"
SetKeyDelay 30,10

YourName := InputBox("Enter your name","Operator Name Input")

MainGui := Gui(,"Evo Automation v0.2.1 BETA",)

MainGui.Add("Text", "w200", "Current Operator:")
MainGui.Add("Text", "w200", YourName.Value)
MainGuiCloseBtn := MainGui.Add("Button", "Default w100 ym", "Close")
MainGuiCloseBtn.OnEvent("Click", function_close)
MainGuiHelpBtn := MainGui.Add("Button","Default w100","Help")
MainGuiHelpBtn.OnEvent("Click", function_help)
MainGui.Show()

Global PageNumber := 1

HelpGui := Gui(,"Help",)
HelpGui.Add("Text", "w300","This is the help window. You can see all available commands that you can use for automation.")
HelpGui.Add("Text", "w300","To use this, simply type in the code eg. !cc then press enter or space. It should be translated to the full entry. Some might ask you to put in some inputs when required.")
HelpGui.Add("Text", "w300",)
HelpGuiMessage := HelpGui.Add("Text","w300 h300","")
function_changehelp()
HelpGuiBackBtn := HelpGui.Add("Button", "Default w100 ym", "Back")
HelpGuiBackBtn.OnEvent("Click", function_backhelp)
HelpGuiNextBtn := HelpGui.Add("Button", "Default w100", "Next")
HelpGuiNextBtn.OnEvent("Click", function_nexthelp)
HelpGui.Add("Text", "",)
HelpGuiCloseBtn := HelpGui.Add("Button", "Default w100", "Close")
HelpGuiCloseBtn.OnEvent("Click", function_closehelp)

InfoGui := Gui(,"Information",)
InfoGui.Add("Text","w300","Enter Additional Information Below")
InfoGui.Add("Text","w300","This will timeout in 15 Seconds. After you click Submit, please wait for the text to process.")
AddInfo := InfoGui.Add("Edit","w300 h50","")
InfoGuiSubmitBtn := InfoGui.Add("Button", "Default w100", "Submit")
InfoGuiSubmitBtn.OnEvent("Click", function_infosubmit)
InfoGui.OnEvent("Close", function_infosubmit)

Message1 := ""
Message2 := ""

function_close(*)
{
    ExitApp
}

function_help(*)
{
    MainGui.Hide()
    HelpGui.Show()
}

function_closehelp(*)
{
    HelpGui.Hide()
    MainGui.Show()
}

function_infosubmit(*)
{
    InfoGui.Hide()
    Return
}

function_changehelp(*)
{
    Global PageNumber
    if(PageNumber == 1) {
        HelpMessage := (
            "HELP PAGE 1`r"
            "EMAIL TEMPLATES`r"
            "`r"
            "!ar - Send Approval Required Email`r"
            "!calg - Calendar Access Granted`r"
            "!calr - Calendar Access Revoked`r"
            "!cc - Marked As completed`r"
            "!cb - Missed Callback`r"
            "!mg - Mailbox Permission Granted`r"
            "!mr - Mailbox Permission Removed`r"
            "!pr - Password Reset`r"
            "!spg - SharePoint Permission Granted`r"
            "!spr - SharePoint Permission Removed`r"
            "!uc - User Created`r"
            "!ud - User Deactivated`r"
        )
    } else if(PageNumber == 2) {
        HelpMessage := (
            "HELP PAGE 2`r"
            "INTERNAL NOTES`r"
            "`r"
            "!vm - Left Voicemail`r"
        )
    } else if(PageNumber == 3) {
        HelpMessage := (
            "HELP PAGE 3`r"
            "Nothing in Here Yet"
            "`r"
        )
    } else if(PageNumber == 4) {
        HelpMessage := (
            "HELP PAGE 4`r"
            "Nothing in Here Yet"
            "`r"
        )
    }

    HelpGuiMessage.Value := HelpMessage

}

function_backhelp(*)
{
    Global PageNumber
    if(PageNumber == 1) {

    } else {
        PageNumber := PageNumber - 1
        function_changehelp()
    }
}

function_nexthelp(*)
{
    Global PageNumber
    if(PageNumber == 4) {

    } else {
        PageNumber := PageNumber + 1
        function_changehelp()
    }
}

::!ar::
{
    ApproverName := InputBox("Enter Approvers Name","Approvers Name")
    RequestorName := InputBox("Enter Requestors Name","Requestors Name")
    InfoGui.Show()
    sleep 15000
    SendText 
    (
        "Hi " ApproverName.Value ",`r"
        "`r"
        "We have received this request from " RequestorName.Value " today.`r"
        "`r"
        AddInfo.Value "`r"
        "`r"
        "Can you please reply and confirm your approval? Once we have this I will schedule it to an engineer to action.`r"
        "If you have any queries, please do not hesitate to contact the Helpdesk.`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
    AddInfo.Value := ""
}

::!calg::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Calendar Access has been granted. Please wait for about 30 minutes for access to take effect`r"
        "Please be advised that Calendars will need to be added manually in outlook by following the steps below`r"
        "`r"
        "1. Go to the Calendars `r"
        "2. At the Top, Look for OPEN CALENDAR then select OPEN SHARED CALENDAR`r"
        "3. Look for your calendar`r"
        "`r"
        "If there are any issues, please let us know`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
}

::!calr::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Calendar Access has been revoked. Calendar will need to be removed Manually`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
}

::!cc::
{
    SendText
    (
        "All Task has been completed.`r"
        "Marking Ticket as Complete"
    )
}

::!cb::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Tried to call but there was no answer. Can you please ring me back whenever you're free on 03 5222 6677 or reply to this email if you want to schedule in a time for the call.`r"
        "`r"
        "Hope to hear from you soon.`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
}

::!mg::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Mailbox Access has been granted. Please allow 30 minutes of replication time. Mailbox Should automatically show up on Outlook, if not, closing/re-opening of outlook might be required`r"
        "If there are any issues, please let us know`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
}

::!mr::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Mailbox Access has been Removed. Please allow 30 minutes of replication time. Mailbox Should automatically disappear from Outlook, if not, closing/re-opening of outlook might be required`r"
        "If there are any issues, please let us know`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
}

::!pr::
{
    CustName := InputBox("Enter Client Name","Client Name")
    UserName := InputBox("Enter User Name","User Name")
    Password := InputBox("Enter Password","Password")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Password for " UserName.Value " Has been reset to - " Password.Value " - Please have this tested.`r"
        "If there are any issues, please let us know`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
}

::!spg::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Access to SharePoint has been granted. This should take from 5 minutes up to 30 minutes to reflect`r"
        "If you're using One Drive, please be advised that this will not show up automatically in File Explorer and needs to be synced Manually`r"
        "`r"
        "If there are any issues, please let us know`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
}

::!spr::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Access to SharePoint has been revoked. This should take from 5 minutes up to 30 minutes to reflect`r"
        "If you're using One Drive, the sync should stop automatically. However, the folder still needs to be removed manually from the machine`r"
        "`r"
        "If there are any issues, please let us know`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
}

::!uc::
{
    CustName := InputBox("Enter Client Name","Client Name")
    InfoGui.Show()
    sleep 15000
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "User account has been created with the following details as below`r"
        "`r"
        AddInfo.Value "`r"
        "`r"
        "Please have the login tested and all access.`r"
        "Please get back to us if there are any issues.`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
    AddInfo.Value := ""
}

::!ud::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`n"
        "`n"
        "This has been Completed`n"
        "User Account has been Disabled, Marked as archive and removed from the Address Lists. All Access has been removed.`n"
        "Please wait for around 30 minutes for the Global Address Book to Update and up to 72 hours for the Offline Address List`n"
        "`n"
        "Regards,`n"
        YourName.Value
    )
}

::!vm::
{
    CustPhone := InputBox("Enter Number Called","Phone Number")
    SendText
    (
        "Tried to Call the Client on Phone " CustPhone.Value "`r"
        "There was no Answer `- Left Voicemail"
    )
}

::!test::
{
    ChangingGui := Gui(,"Changing",)
    CurrentPage := 1
    Page := ChangingGui.Add("Text","w300","Page: " CurrentPage)
    Text := ChangingGui.Add("Text","w300 h300","You are on Page 1")
    BackButton := ChangingGui.Add("Button","Default w100","Back")
    NextButton := ChangingGui.Add("Button","Default w100","Next")
    BackButton.OnEvent("Click", back_function)
    NextButton.Onevent("Click", next_function)
    ChangingGui.Show

    back_function(*) {
        CurrentPage := CurrentPage - 1
        Page.Value := "Page: " CurrentPage
        display_function()
    }

    next_function(*) {
        CurrentPage := CurrentPage + 1
        Page.Value := "Page: " CurrentPage
        display_function()
    }

    display_function(*)
    {
        if(CurrentPage == 1){
            ThisText := (
                "This is line 1`r"
                "This is line 2`r"
            )
            Text.Value := ThisText
        }else if(CurrentPage == 2){
            ThisText := "You are on Page 2"
            Text.Value := ThisText
        }
    }
}

return