# Get all user mailboxes
Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited | 
ForEach-Object {
    # Get the primary SMTP address of the mailbox as a string
    $mailboxIdentity = $_.PrimarySmtpAddress.ToString()

    # Get mailbox permissions for the mailbox
    $mailboxPermissions = Get-MailboxPermission -Identity $mailboxIdentity
    
    # Filter results to show only permissions where the User is not the mailbox owner
    $mailboxPermissions | 
    Where-Object { $_.User -like '*\*' -or $_.User -like '*@*' } | 

    # Exclude specific users like 'badminuser', ensuring both partial and exact matches are handled
    Where-Object { 
        $userStr = $_.User.ToString()
        $userStr -notlike '*badminuser*' -and 
        $userStr -notlike '*admin*' -and
        $userStr -notlike '*Servers*' -and 
        $userStr -notlike '*Management*' -and 
        $userStr -notlike '*SELF*' -and 
        $userStr -notlike '*Setup*' -and
        $userStr -notlike '*SERVICE*' -and 
        # ADD YOUR OWN EXCLUSIONS HERE with by replacing <Edit with the desired exclusion object
        # $userStr -notlike '*<EDIT>*' -and 
        $userStr -notlike '*system*'
    } | 
    Select-Object @{Name='Mailbox';Expression={$mailboxIdentity}}, User, AccessRights
} |
Export-Csv -Path C:\Scripts\ScriptOutput\sharedusers.csv -NoTypeInformation # Outputs a CSV file.
