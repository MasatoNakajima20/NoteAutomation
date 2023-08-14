﻿#SingleInstance

YourName := InputBox("Enter your name","Operatorn Name Input")

MainGui := Gui(,"Evo Automation v0.1 BETA",)

MainGui.Add("Text", "w300", "Current Operator:")
MainGui.Add("Text", "w300", YourName.Value)
MainGuiCloseBtn := MainGui.Add("Button", "Default w100 ym", "Close")
MainGuiCloseBtn.OnEvent("Click", function_close)
MainGuiHelpBtn := MainGui.Add("Button","Default w100","Help")
MainGuiHelpBtn.OnEvent("Click", function_help)
MainGui.Show()

HelpGui := Gui(,"Help",)
HelpGui.Add("Text", "w300","This is the help window. You can see all available commands that you can use for automation.{Enter}To use this, simply type in the code eg. !cc the press enter. It should be translated to the full note")
HelpGui.Add("Text", "w300",)
HelpGui.Add("Text", "w300","EMAIL TEMPLATES")
HelpGui.Add("Text", "w300","!ar - Marked As completed")
HelpGui.Add("Text", "w300","!cc - Marked As completed")
HelpGui.Add("Text", "w300","!cb - Missed Callback")
HelpGui.Add("Text", "w300","!mg - Mailbox Permission Granted")
HelpGui.Add("Text", "w300","!mr - Mailbox Permission Removed")
HelpGui.Add("Text", "w300","!uc - User Created")
HelpGui.Add("Text", "w300","!ud - User Deactivated")
HelpGui.Add("Text", "w300",)
HelpGui.Add("Text", "w300","INTERNAL NOTES")
HelpGui.Add("Text", "w300","!vm - Left Voicemail")
HelpGui.Add("Text", "w300",)
HelpGuiCloseBtn := HelpGui.Add("Button", "Default w100", "Close")
HelpGuiCloseBtn.OnEvent("Click", function_closehelp)

InfoGui := Gui(,"Information",)
InfoGui.Add("Text","w300","Enter Additional Information Below")
InfoGui.Add("Text","w300","This will timeout in 15 Seconds")
AddInfo := InfoGui.Add("Edit","w300 h50","")
InfoGuiSubmitBtn := InfoGui.Add("Button", "Default w100", "Submit")
InfoGuiSubmitBtn.OnEvent("Click", function_infosubmit)
InfoGui.OnEvent("Close", function_infosubmit)

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

::!ar::
{
    ApproverName := InputBox("Enter Approvers Name","Approvers Name")
    RequestorName := InputBox("Enter Requestors Name","Requestors Name")
    InfoGui.Show()
    sleep 15000
    Send "Hi " ApproverName.Value ",{Enter Enter}" RequestorName.Value " has requested the following{Enter Enter}" AddInfo.Value "{Enter Enter}. Please let us know if you approve this request.{Enter Enter}Regards,{Enter}" YourName.Value
    AddInfo.Value := ""
}

::!cc::
{
    Send "All Task has been completed.{Enter}Marking Ticket as Complete"
}

::!cb::
{
    CustName := InputBox("Enter Client Name","Client Name")
    Send "Hi " CustName.Value ",{Enter Enter}Tried to call but there was no answer. Can you please ring me back whenever you're free on 03 5222 6677 or reply to this email if you want to schedule in a time for the call. Hope to hear from you soon.{Enter Enter}Regards,{Enter}" YourName.Value
}

::!mg::
{
    CustName := InputBox("Enter Client Name","Client Name")
    Send "Hi " CustName.Value ",{Enter Enter}Mailbox Access has been granted. Please allow 30 minutes of replication time. Mailbox Should automatically show up on Outlook, if not, closing/re-opening of outlook might be required{Enter Enter}If there are any issues, please let us know{Enter Enter}Regards,{Enter}" YourName.Value
}

::!mr::
{
    CustName := InputBox("Enter Client Name","Client Name")
    Send "Hi " CustName.Value ",{Enter Enter}Mailbox Access has been Removed. Please allow 30 minutes of replication time. Mailbox Should automatically disappear from Outlook, if not, closing/re-opening of outlook might be required{Enter Enter}If there are any issues, please let us know{Enter Enter}Regards,{Enter}" YourName.Value
}

::!uc::
{
    CustName := InputBox("Enter Client Name","Client Name")
    Send "Hi" CustName.Value ",{Enter Enter}User account has been created with the following details as below{Enter Enter}<Add New User info Here>{Enter Enter}Please have the login tested and all access.{Enter}PLease get back to us if there are any issues{Enter Enter}Regards,{Enter}" YourName.Value
}

::!ud::
{
    CustName := InputBox("Enter Client Name","Client Name")
    Send "Hi " CustName.Value ",{Enter Enter}This has been Completed{Enter}User Account has been Disabled, Marked as archive and removed from the Address Lists. All Access has been removed.{Enter}Please wait for around 30 minutes for the Global Address Book to Update and up to 72 hours for the Offline Address List{Enter Enter}Regards,{Enter}" YourName.Value
}

::!vm::
{
    CustPhone := InputBox("Enter Number Called","Phone Number")
    Send "Tried to Call the Client on Phone" CustPhone.Value "{Enter}There was no Answer `- Left Voicemail"
}

::!test::
{
    CustName := InputBox("Enter Client Name","Client Name")
    InfoGui.Show()
    sleep 15000
    Send "Hello " CustName.Value "{Enter Enter}" AddInfo.Value "{Enter Enter}Regards,{Enter}" YourName.Value
}

return