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
HelpGui.Add("Text", "w300","This is the help window. You can see all available commands that you can use for automation.")
HelpGui.Add("Text", "w300","To use this, simply type in the code eg. !cc the press enter. It should be translated to the full entry. Some might ask you to put in some inputs when required.")
HelpGui.Add("Text", "w300",)
HelpGui.Add("Text", "w300","EMAIL TEMPLATES")
HelpGui.Add("Text", "w300","!ar - Send Approval Required Email")
HelpGui.Add("Text", "w300","!cc - Marked As completed")
HelpGui.Add("Text", "w300","!cb - Missed Callback")
HelpGui.Add("Text", "w300","!mg - Mailbox Permission Granted")
HelpGui.Add("Text", "w300","!mr - Mailbox Permission Removed")
HelpGui.Add("Text", "w300","!pr - Password Reset")
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
InfoGui.Add("Text","w300","This will timeout in 15 Seconds. After you click Submit, please wait for the text to process.")
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
    Send 
    (
        "Hello " ApproverName.Value ",{Enter}"
        "{Enter}"
        "We have received this request from " RequestorName.Value " today.{Enter}"
        "{Enter}"
        AddInfo.Value "{Enter}"
        "{Enter}"
        "Can you please reply and confirm your approval? Once we have this I will schedule it to an engineer to action.{Enter}"
        "If you have any queries, please do not hesitate to contact the Helpdesk.{Enter}"
        "{Enter}"
        "Regards,{Enter}"
        YourName.Value
    )
    AddInfo.Value := ""
}

::!cc::
{
    Send "All Task has been completed.{Enter}Marking Ticket as Complete"
}

::!cb::
{
    CustName := InputBox("Enter Client Name","Client Name")
    Send 
    (
        "Hello " CustName.Value ",{Enter}"
        "{Enter}"
        "Tried to call but there was no answer. Can you please ring me back whenever you're free on 03 5222 6677 or reply to this email if you want to schedule in a time for the call.{Enter}"
        "Hope to hear from you soon.{Enter}"
        "{Enter}"
        "Regards,{Enter}"
        YourName.Value
    )
}

::!mg::
{
    CustName := InputBox("Enter Client Name","Client Name")
    Send 
    (
        "Hello " CustName.Value ",{Enter}"
        "{Enter}"
        "Mailbox Access has been granted. Please allow 30 minutes of replication time. Mailbox Should automatically show up on Outlook, if not, closing/re-opening of outlook might be required{Enter}"
        "If there are any issues, please let us know{Enter}"
        "{Enter}"
        "Regards,{Enter}"
        YourName.Value
    )
}

::!mr::
{
    CustName := InputBox("Enter Client Name","Client Name")
    Send 
    (
        "Hello " CustName.Value ",{Enter}"
        "{Enter}"
        "Mailbox Access has been Removed. Please allow 30 minutes of replication time. Mailbox Should automatically disappear from Outlook, if not, closing/re-opening of outlook might be required{Enter}"
        "If there are any issues, please let us know{Enter}"
        "{Enter}"
        "Regards,{Enter}"
        YourName.Value
    )
}

::!pr::
{
    CustName := InputBox("Enter Client Name","Client Name")
    UserName := InputBox("Enter User Name","User Name")
    Password := InputBox("Enter Password","Password")
    Send 
    (
        "Hello " CustName.Value ",{Enter}"
        "{Enter}"
        "Password for " UserName.Value " Has been reset to - " Password.Value " - Please have this tested.{Enter}"
        "If there are any issues, please let us know{Enter}"
        "{Enter}"
        "Regards,{Enter}"
        YourName.Value
    )
}

::!uc::
{
    CustName := InputBox("Enter Client Name","Client Name")
    InfoGui.Show()
    sleep 15000
    Send 
    (
        "Hello " CustName.Value ",{Enter}"
        "{Enter}"
        "User account has been created with the following details as below{Enter}"
        "{Enter}"
        AddInfo.Value "{Enter}"
        "{Enter}"
        "Please have the login tested and all access.{Enter}"
        "Please get back to us if there are any issues.{Enter}"
        "{Enter}"
        "Regards,{Enter}"
        YourName.Value
    )
    AddInfo.Value := ""
}

::!ud::
{
    CustName := InputBox("Enter Client Name","Client Name")
    Send 
    (
        "Hello " CustName.Value ",{Enter}"
        "{Enter}"
        "This has been Completed{Enter}"
        "User Account has been Disabled, Marked as archive and removed from the Address Lists. All Access has been removed.{Enter}"
        "Please wait for around 30 minutes for the Global Address Book to Update and up to 72 hours for the Offline Address List{Enter}"
        "{Enter}"
        "Regards,{Enter}"
        YourName.Value
    )
}

::!vm::
{
    CustPhone := InputBox("Enter Number Called","Phone Number")
    Send
    (
        "Tried to Call the Client on Phone " CustPhone.Value "{Enter}"
        "There was no Answer `- Left Voicemail"
    )
}

::!test::
{
    
}

return