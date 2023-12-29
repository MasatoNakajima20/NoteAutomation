#Requires AutoHotkey v2.0
#SingleInstance
SendMode "Event"
SetKeyDelay 30,10

;Declare Global Variables
Global PageNumber := 1
Global OperatorName := ""
Global Signature := ""

Loop Read ".\config.ini"
    if (A_Index = 2) {
        OperatorName := A_LoopReadLine
    } else if (A_Index >= 4 && A_Index <= 8) {
        Signature := Signature A_LoopReadLine "`r"
    }

;Create the Main GUI
MainGui := Gui(,"Evo Automation v2023.1229 Pre-Release",)
MainGui.Add("Text", "w200", "Current Operator:")
MainGui.Add("Text", "w200", OperatorName)
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
            "SETTING UP YOUR PROFILE`r"
            "`r"
            "Look for the config.ini file with this exe. You may Open it in Notepad and Edit the information`r"
            "Do not move any of the CAPS sections as it will break the settings, it relies on the line position`r"
            "`r"
            "Keywords Will be shown on the Next Page`r"
        )
    } else if(PageNumber == 2) {
        HelpMessage := (
            "HELP PAGE 2`r"
            "EMAIL TEMPLATES`r"
            "`r"
            "!admin - Send Admin Request Security Email`r"
            "!adming - Send Admin Approved Security Email`r"
            "!ae    - Send Escalation Accpetance`r"
            "!ar    - Send Approval Required Email`r"
            "!calg  - Calendar Access Granted`r"
            "!calr  - Calendar Access Revoked`r"
            "!cc    - Marked As completed`r"
            "!cb    - Missed Callback`r"
            "!escal - Escalation`r"
            "!fg    - File Share Access Granted`r"
            "!fr    - File Share Access Revoked`r"
            "!mg    - Mailbox Permission Granted`r"
            "!mr    - Mailbox Permission Removed`r"
            "!pr    - Password Reset`r"
            "!rep   - Report Email`r"
            "!sig   - Adds in the Signature Only`r"
            "!smbxc - Shared Mailbox Created`r"
        )           
    } else if(PageNumber == 3) {
        HelpMessage := (
            "HELP PAGE 3`r"
            "EMAIL TEMPLATES`r"
            "`r"
            "!spam  - Send Spam Acknowledgement EMail`r"
            "!spampos - Send Spam Positive Email`r"
            "!spamneg - Send Spam Negative Email`r"
            "!spg   - SharePoint Permission Granted`r"
            "!spr   - SharePoint Permission Removed`r"
            "!uc    - User Created`r"
            "!udeac - User Deactivated`r"
            "!udel  - User Deleted`r"
        )
    } else if(PageNumber == 4) {
        HelpMessage := (
            "HELP PAGE 4`r"
            "INTERNAL NOTES`r"
            "`r"
            "!te       - Add Ticket Template`r"
            "!testdr   - Adds Template for Test Disaster Recovery`r"
            "!callna   - Client not Available`r"
            "!callnovm - Client did not answer - No VM Available`r"
            "!callvm   - Client did not answer - Left VM`r"
            "!proac    - Proactive Checks Template`r"
            "!spamcheck - Spam Checks Template`r"
        )
    } else if(PageNumber == 5) {
        HelpMessage := (
            "HELP PAGE 5`r"
            "CUSTOM TEXT`r"
            "You can create 5 custom text by adding in your own text file and naming it c1.txt up to c5.txt and placing it under a folder named Custom, There should already be files Provided in this package`r"
            "The file Structure should look like as follows`r"
            "`r"
            "AutoScript.exe`r"
            "Custom`r"
            "Custom\c1.txt`r"
            "`r"
            "Custom Text can be ran by typing !c1 to !c5 then pressing space or enter. Your custom text will then be filled in. Please note that this will not autofill any names if you're making a custom email template.`r"
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
    if(PageNumber == 5) {

    } else {
        PageNumber := PageNumber + 1
        function_changehelp()
    }
}

;HotStrings Declaration
::!admin::
{
    Global Signature
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
        Signature
    )
}

::!adming::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    CompanyName := InputBox("Enter Company Name","Company Name")
    MachineName := InputBox("Enter Machine Name","Machine Name")
    UserName := InputBox("Enter User Name","User Name")

    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "We generally advise against users having direct admin rights on their devices as it goes against security best practices and increases the risk and scope of potential incidents - particularly when it comes to malware & ransomware that may find its way onto the device.`r"
        "`r"
        "Granting admin rights to install software and make changes unrestricted also allows malicious software or scripts that find their way onto the device to run unchecked, as they'll also be running with admin rights by default on account of the user account being an administrator.`r"
        "`r"
        "As this has been approved, Admin access to device " MachineName.Value " for user " UserName.Value " has been added. Please Logout/Login for this to take effect"
        "`r"
        CompanyName.Value " accepts the risks involved in granting Administrator access on the device and releases Evologic from any liabilities incurred from any unwanted software running on the machine or security breaches that would deemed sourced from this device moving forward. Any work done by Evologic upon the said security breach would become Chargeable`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!ae::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")

    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "This ticket has been escalated and I'll be working with you on this. I'll be sending you a scheduling link so we can book in a time for me to have a look at this concern.`r"
        "If the matter is becoming urgent, please call us back and we'll have a look if an escalation engineer is free.`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!ar::
{
    Global Signature
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
        Signature
    )
    AddInfo.Value := ""
}

::!calg::
{
    Global Signature
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
        Signature
    )
}

::!calr::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Calendar Access has been revoked. Calendar will need to be removed Manually`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!cc::
{
    SendText
    (
        "All Task on the ticket has been completed`r"
        "Client Acknowledged completion of job`r"
        "Marking Ticket as Complete"
    )
}

::!cb::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Just tired to contact you but you seem to be caught up at the moment`r"
        "`r"
        "This is in regards to the request`r"
        "<INSERT REASON FOR THE CALL>`r"
        "`r"
        "Can you please ring me back whenever you're free on 03 5222 6677 or reply to this email if you want to schedule in a time for the call.`r"
        "`r"
        "Hope to hear from you soon.`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!escal::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    EscalPoint := InputBox("Enter Escalation Point (L2/SA/ITM)","Escalation Point")

    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "I had a look into the matter and this seems to be more complext than anticipated. I'm unable to resolve the issue and unable to move further.`r"
        "`r"
        "I will now be needing to escalating this ticket to our " EscalPoint.Value " to further look into this concern. Please expect a call or a scheduling link for them to book in a time with you.`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!fg::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Access to the Shared Network Drive / Shared Network Folder has been granted. Please allow 30 minutes of replication time. Logging Out and Logging Back in is required for access to take effect.`r"
        "If there are any issues, please let us know`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!fr::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Access to the Shared Folder in the network drive has been revoked. Please allow 30 minutes of replication time. Logging Out and Logging Back in is required for the revokation of access to take effect due to access tokens stored on the machine during login.`r"
        "If there are any issues, please let us know`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!mg::
{
    Global Signature
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
        Signature
    )
}

::!mr::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Mailbox Access has been Removed.`r"
        "`r"
        "Please allow 30 minutes of replication time. Mailbox Should automatically disappear from Outlook, if not, closing/re-opening of outlook might be required`r"
        "If using Outlook Web Application (OWA) in the browser, the mailbox should be removed manually if added manually before`r"
        "`r"
        "If there are any issues, please let us know`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!pr::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    UserName := InputBox("Enter User Name","User Name")
    Password := InputBox("Enter Password","Password")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Password for " UserName.Value " Has been reset to - " Password.Value " - Please have this tested.`r"
        "`r"
        "If there are any issues, please let us know`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!rep::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Thank you for waiting. Please see attached report/s as requested`r"
        "`r"
        "If there are any issues, please let us know`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!sig::
{
    Global Signature
    SendText
    (
        "Regards,`r"
        Signature
    )
}

::!smbxc::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "The Shared Mailbox/es has been created as requested. Please see the details below`r"
        "`r"
        "Mailbox Name  : `r"
        "Mailbox Email : `r"
        "Type:         : Shared`r"
        "Licensed      : No`r"
        "Login Enabled : No`r"
        "`r"
        "Please be advised that these are the defaults for Shared Mailboxes. If you need to have these mailboxes authenticate / interact with a system, please be advised that mailboxes will need to be licensed for it to have the capability`r"
        "Additional users can be added to access the mailbox via outlook by request.`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!spam::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Thank you for bringing this to our attention.`r"
        "Please do not open any links or attachments while we investigate the matter. If you have already clicked on any links, please give us a call immediately and we will deal with the matter with outmost urgency to make sure there are no compromise in the your account`r"
        "`r"
        "I will get back to you as soon as possible`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!spampos::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "I have identified the email to be a Phishing/Spam e-mail.`r"
        "We have blocked the original source. Please Delete all copies of the email and delete it as well from the Deleted Items folder in Outlook.`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!spamneg::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "I have identified the email to be a legitimate e-mail.`r"
        "Based on the trace, the sender email is matching the source and the domain is valid. Links on the email has been scanned and turned out negative of any malicious threats.`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!spg::
{
    Global Signature
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
        Signature
    )
}

::!spr::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "Access to SharePoint / Sharepoint Library has been revoked. This should take from 5 minutes up to 30 minutes to reflect`r"
        "`r"
        "If you're using One Drive, the sync should stop automatically. However, the folder still needs to be removed manually from the machine. Please make sure that the Sync symbol on the folder has already disappeared before deleting the folder`r"
        "`r"
        "If there are any issues, please let us know`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!uc::
{
    Global Signature
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
        Signature
    )
    AddInfo.Value := ""
}

::!udeac::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "This request has been completed`r"
        "User Account has been disabled, Marked as archive and removed from the Address Lists. All Access has been removed.`r"
        "Please wait for around 30 minutes for the Global Address Book to Update and up to 72 hours for the Offline Address List to follow`r"
        "`r"
        "Regards,`r"
        Signature
    )
}

::!udel::
{
    Global Signature
    CustName := InputBox("Enter Client Name","Client Name")
    SendText 
    (
        "Hi " CustName.Value ",`r"
        "`r"
        "This request has been completed`r"
        "User Account has been deleted as requested. Backups have been removed. Please be advised that all data under retention will be purged after 30 days and after that, there will be no more chance of recovery`r"
        "Please wait for around 30 minutes for the Global Address Book to Update and up to 72 hours for the Offline Address List to follow`r"
        "`r"
        "Regards,`r"
        Signature
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
        "Reported Issue: `r"
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
        "<ADD VIRTUALIZATION DETAILS HERE>`r"
        "`r"
        "Testing VM`r"
        "Boot: `r"
        "Login: `r"
        "Active Directory: `r"
        "File Shares: `r"
        "Printers: `r"
    )
}


::!callna::
{
    CustPhone := InputBox("Enter Number Called","Phone Number")
    SendText
    (
        "Tried to Call the Client on Phone " CustPhone.Value "`r"
        "Client is not available at the moment"
    )
}

::!callnovm::
{
    CustPhone := InputBox("Enter Number Called","Phone Number")
    SendText
    (
        "Tried to Call the Client on Phone " CustPhone.Value "`r"
        "There was no Answer.`r"
        "No VM available / VM too short - Unable leave voice message for the user"
    )
}

::!callvm::
{
    CustPhone := InputBox("Enter Number Called","Phone Number")
    SendText
    (
        "Tried to Call the Client on Phone " CustPhone.Value "`r"
        "There was no Answer - Left Voicemail"
    )
}

::!proac::
{
    SendText
    (
        "Starting Proactive Checks`r"
        "`r"
        "Remote Admin Checks - Run RMM Script EVO - Monthly Proactive Checks Report, review and Send to Client. If there are issues with the report, note it here. eg. (Licensing issues, Lots of Stale Accounts, etc.), Forward to SA first for review before sending to client`r"
        "->`r"
        "`r"
        "Sophos Central - Check all Firewalls in https://central.sophos.com/, note the serial number and check if all appliance are being backed up in the backup tab.`r"
        "->`r"
        "`r"
        "365 - Check GA Account if Working. Make Sure KB Doc is titled EVO_GA Office 365 / Azure Global Administrator`r"
        "->`r"
        "`r"
        "Backups - Check Backups for client make sure all are working. Datto / SaaS`r"
        "->`r"
        "`r"
        "Firmware Updates - Check if there are Firmware Updates for Sophos Firewall`r"
        "->`r"
        "`r"
        "UPS - Check IT glue UPS Tab and perform UPS Checks depending on the brand`r"
        "EATON - https://evologic.itglue.com/4100/docs/42088`r"
        "CYBER - https://evologic.itglue.com/4100/docs/42089`r"
        "->`r"
        "`r"
        "Documentation - Confirm and make sure Client Documents are Updated and Correct (This will base on whatever you have done above). Eg. All Sophos Applicance Serials Should be in the Configuratons and The UPS Checks should be updated.`r"
        "->`r"
    )
}

::!spamcheck::
{
    SendText
    (
        "(Exchange Admin) Perform Message Trace: `r"
        "(Security Center) Check Email Headers and Confirm Return Path: `r"
        "(Security Center) Check Attachments: `r"
        "(Security Center) Check Links: `r"
        "(Azure Admin) Check user signin logs for compromise: `r"
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




