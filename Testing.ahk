#SingleInstance

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
HelpGui.Add("Text", "w300","This is the help window. You can see all available commands that you can use for automation")
HelpGui.Add("Text", "w300",)
HelpGui.Add("Text", "w300","EMAIL TEMPLATES")
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

::!cc::
{
    Send "All Task has been completed.{Enter Enter}Marking Ticket as Complete"
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
    Send "Hi " CustName.Value ",{Enter Enter}This has been Completed{Enter}User Account has been Disabled and all Access has been removed.{Enter Enter}Regards,{Enter}" YourName.Value
}

::!vm::
{
    CustPhone := InputBox("Enter Number Called","Phone Number")
    Send "Tried to Call the Client on Phone" CustPhone.Value "{Enter}There was no Answer `- Left Voicemail"
}

return