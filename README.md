## Script to get Email Account User access from Exchange

### What does it do?
This script queries a Microsoft Exchange server for inboxes with Full user access and lists the users who do have access.
It outputs a CSV file called `sharedusers.csv` which can be found at `C:\Scripts\ScriptOutput\sharedusers.csv`


### Prerequisites
Before running the script make sure you are logged into the Exhange Management Shell
You may have to change the execution policy to `RemoteSigned` to get the script to run
You can check the current set policy using `Get-ExecutionPolicy -List | FL`
Look for the LocalMachine scope which should look like this
- `Scope:LocalMachine`
- `ExcutionPolicy:RemoteSigned`


Once thats confirmed you can move onto the next step

### Customizing the script before running
Before running the script you can edit the `Exclude` List which is used to filter out accounts such as `admin` or `SERVICE` 	
- Edit the `Where-Object {` List to include your own excludes by adding 
- `$userStr -notlike '*<EDIT>*' -and` below the second last entry

Edit the `<EDIT>` to the object you would like excluded.

By default this list includes these accounts:

 - `'badminuser'`
 -  `admin`
 -  `Servers` 
 -  `Management` 
  - `SELF` 
  - `Setup`
  - `SERVICE` 
  - `system`

### Running the script
Once you have customised the script to your liking in the Exchange Managment Console Run the script from the Directory its stored in
Example:` C:\Scripts\GetSharedUserListNew.ps1`

Once its complete you should find a file at `C:\Scripts\ScriptOutput\sharedusers.csv` with the list of accounts and users with `FULL ACCESS` permissions.

### What now?
Now you can take that file and import it into your favourite program Excel which will show a list of the associated accounts.


#### Did i make this script?
I used info found from these sources and used GPT for figuring out Errors:

[https://www.netwrix.com/get-shared-mailbox-permissions.html](https://www.netwrix.com/get-shared-mailbox-permissions.html "https://www.netwrix.com/get-shared-mailbox-permissions.html")

[https://learn.microsoft.com/en-us/powershell/exchange/exchange-management-shell?view=exchange-ps](https://learn.microsoft.com/en-us/powershell/exchange/exchange-management-shell?view=exchange-ps "https://learn.microsoft.com/en-us/powershell/exchange/exchange-management-shell?view=exchange-ps")

[https://learn.microsoft.com/en-us/powershell/module/exchange/get-mailbox?view=exchange-ps](https://learn.microsoft.com/en-us/powershell/module/exchange/get-mailbox?view=exchange-ps "https://learn.microsoft.com/en-us/powershell/module/exchange/get-mailbox?view=exchange-ps")

[https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/where-object?view=powershell-7.4](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/where-object?view=powershell-7.4 "https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/where-object?view=powershell-7.4")
