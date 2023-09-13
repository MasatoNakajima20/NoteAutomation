#SingleInstance
SendMode "Event"
SetKeyDelay 30,10

;Declare Global Variables
Global PageNumber := 1
Global Message1 := ""
Global Message2 := ""

YourName := InputBox("Enter your name","Operator Name Input")

;Create the Main GUI
MainGui := Gui(,"Evo Automation v0.3.1 BETA",)
MainGui.Add("Text", "w200", "Current Operator:")
MainGui.Add("Text", "w200", YourName.Value)
MainGuiCloseBtn := MainGui.Add("Button", "Default w100 ym", "Close")
MainGuiCloseBtn.OnEvent("Click", function_close)
MainGuiHelpBtn := MainGui.Add("Button","Default w100","Help")
MainGuiHelpBtn.OnEvent("Click", function_help)
MainGui.Show()

;Create the Help GUI
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

;Create the Additional Information GUI Form
InfoGui := Gui(,"Information",)
InfoGui.Add("Text","w300","Enter Additional Information Below")
InfoGui.Add("Text","w300","This will timeout in 15 Seconds. After you click Submit, please wait for the text to process.")
AddInfo := InfoGui.Add("Edit","w300 h50","")
InfoGuiSubmitBtn := InfoGui.Add("Button", "Default w100", "Submit")
InfoGuiSubmitBtn.OnEvent("Click", function_infosubmit)
InfoGui.OnEvent("Close", function_infosubmit)

;Function
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
            "!admin - Send Admin Request Security Email"
            "!ar    - Send Approval Required Email`r"
            "!calg  - Calendar Access Granted`r"
            "!calr  - Calendar Access Revoked`r"
            "!cc    - Marked As completed`r"
            "!cb    - Missed Callback`r"
            "!fg    - File Share Access Granted`r"
            "!fr    - File Share Access Revoked`r"
            "!mg    - Mailbox Permission Granted`r"
            "!mr    - Mailbox Permission Removed`r"
            "!pr    - Password Reset`r"
            "!rep   - Report Email`r"
            "!spam  - Send Spam Acknowledgement EMail`r"
            "!spam+ - Send Spam Positive Email`r"
            "!spam- - Send Spam Negative Email`r"
            "!spg   - SharePoint Permission Granted`r"
            "!spr   - SharePoint Permission Removed`r"
            "!uc    - User Created`r"
            "!udeac - User Deactivated`r"
            "!udel  - User Deleted`r"
        )
    } else if(PageNumber == 2) {
        HelpMessage := (
            "HELP PAGE 2`r"
            "INTERNAL NOTES`r"
            "`r"
            "!te - Add Ticket Template"
            "!testdr   - Adds Template for Test Disaster Recovery`r"
            "!vm       - Left Voicemail`r"
        )
    } else if(PageNumber == 3) {
        HelpMessage := (
            "HELP PAGE 3`r"
            "CUSTOM TEXT`r"
            "You can create 5 custom text by adding in your own text file and naming it c1.txt up to c5.txt and placing it under a folder named Custom`r"
            "The file Structure should look like as follows`r"
            "`r"
            "AutoScript.exe`r"
            "Custom`r"
            "Custom\c1.txt`r"
            "`r"
            "Custom Text can be ran by typing !c1 to !c5 then pressing space or enter. Your custom text will then be filled in. Please note that this will not autofill any names if you're making a custom email template.`r"
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

;HotStrings Declaration
::!admin::
{
    CustName := InputBox("Enter Client Name","Client Name")

    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "We generally advise against users having direct admin rights on their devices as it goes against security best practices and increases the risk and scope of potential incidents - particularly when it comes to malware & ransomware that may find its way onto the device.`r"
        "`r"
        "Granting admin rights to install software and make changes unrestricted also allows malicious software or scripts that find their way onto the device to run unchecked, as they'll also be running with admin rights by default on account of the user account being an administrator.`r"
        "`r"
        "If you have software that would like installed, please send through what you require and we'll schedule a time to run through the installation with you.`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
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

::!fg::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Access to the Shared Network Drive / Shared Network Folder has been granted. Please allow 30 minutes of replication time. Logging Out and Logging Back in is required for access to take effect.`r"
        "If there are any issues, please let us know`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
}

::!fr::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Access to the Shared Folder in the network drive has been revoked. Please allow 30 minutes of replication time. Logging Out and Logging Back in is required for the revokation of access to take effect due to access tokens stored on the machine during login.`r"
        "If there are any issues, please let us know`r"
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
        "Mailbox Access has been granted.`r"
        "Please allow 30 minutes of replication time. Mailbox Should automatically show up on Outlook, if not, closing/re-opening of outlook might be required`r"
        "If using Outlook Web Application (OWA) in the browser, please be advised that shared mailboxes will not show automatically. There are 2 ways to access a shared mailbox in OWA. Please follow the steps below only if using OWA`r"
        "`r"
        "OPENING AS ANOTHER MAILBOX`r"
        "1. Click on the Profile Circle on the top right corner of OWA`r"
        "2. Select Open another Mailbox`r"
        "3. Search for your mailbox and Open`r"
        "`r"
        "ADDING AS SHARED FOLDER`r"
        "1. On the left Pane, Right Click 'Folders'`r"
        "2. Click on 'Add Shared Folder or Mailbox'`r"
        "3. Search for your Mailbox and Add`r"
        "`r"
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
        "Mailbox Access has been Removed.`r"
        "Please allow 30 minutes of replication time. Mailbox Should automatically disappear from Outlook, if not, closing/re-opening of outlook might be required`r"
        "If using Outlook Web Application (OWA) in the browser, the mailbox should be removed manually if added manually before`r"
        "`r"
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

::!rep::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Thank you for waiting. Please see attached report/s as requested`r"
        "If there are any issues, please let us know`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
}

::!spam::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Thank you for bringing this to our attention. Please do not open any links or attachments while we investigate the matter. If you have already clicked on any links, please give us a call immediately and we will deal with the matter with outmost urgency to make sure there are no compromise in the your account`r"
        "I will get back to you as soon as possible`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
}

::!spam+::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "I have identified the email to be a Phishing/Spam e-mail. We have blocked the original source. Please Delete all copies of the email and delete it as well from the recycle bin.`r"
        "`r"
        "Regards,`r"
        YourName.Value
    )
}

::!spam-::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "I have identified the email to be a legitimate e-mail. This is safe to open.`r"
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
        "Access to SharePoint / Sharepoint Library has been granted. This should take from 5 minutes up to 30 minutes to reflect`r"
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
        "Access to SharePoint / Sharepoint Library has been revoked. This should take from 5 minutes up to 30 minutes to reflect`r"
        "If you're using One Drive, the sync should stop automatically. However, the folder still needs to be removed manually from the machine. Please make sure that the Sync symbol on the folder has already disappeared before deleting the folder`r"
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

::!udeac::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`n"
        "`n"
        "This has been Completed`n"
        "User Account has been Disabled, Marked as archive and removed from the Address Lists. All Access has been removed.`n"
        "Please wait for around 30 minutes for the Global Address Book to Update and up to 72 hours for the Offline Address List to follow``n"
        "`n"
        "Regards,`n"
        YourName.Value
    )
}

::!udel::
{
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`n"
        "`n"
        "This has been Completed`n"
        "User Account has been Deleted as Requested. Backups have been removed. Please be advised that all data under retention will be purged after 30 days and after that, there will be no more chance of recovery`n"
        "Please wait for around 30 minutes for the Global Address Book to Update and up to 72 hours for the Offline Address List to follow`n"
        "`n"
        "Regards,`n"
        YourName.Value
    )
}

;INTERNAL NOTES;
::!te::
{
    SendText
    (
        "CLIENT INFORMATION`r"
        "Name: `r"
        "Organization: `r"
        "Machine: `r"
        "Number: `r"
        "Location (Office / Remote): `r"
        "`r"
        "ISSUE`r"
        "Repoted Issue: `r"
        "Users Affected: `r"
        "`r"
        "TROUBLESHOOTING`r"
        "->`r"
        "`r"
        "RESOLUTION`r"
        "->`r"
    )
}

::!testdr::
{
    SendText
    (
        "Starting Virtualization`r"
        "VIRTUALIZATION DETAILS`r"
        "`r"
        "`r"
        "Testing VM`r"
        "Boot: `r"
        "Login: `r"
        "Active Directory: `r"
        "File Shares: `r"
        "Printers: `r"
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

;CUSTOM SCRIPTS;
::!c1::
{
    CustomText := FileRead(".\Custom\c1.txt",)
    SendText
    (
        CustomText
    )
    CustomText := ""
}

::!c2::
{
    CustomText := FileRead(".\Custom\c2.txt",)
    SendText
    (
        CustomText
    )
    CustomText := ""
}

::!c3::
{
    CustomText := FileRead(".\Custom\c3.txt",)
    SendText
    (
        CustomText
    )
    CustomText := ""
}

::!c4::
{
    CustomText := FileRead(".\Custom\c4.txt",)
    SendText
    (
        CustomText
    )
    CustomText := ""
}

::!c5::
{
    CustomText := FileRead(".\Custom\c5.txt",)
    SendText
    (
        CustomText
    )
    CustomText := ""
}

;Test Area
::!test::
{

}

return