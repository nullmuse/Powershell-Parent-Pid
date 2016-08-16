function Get-ProcessParent {

begin {

Set-Variable ($$ = [Regex].Assembly.GetType(
      'Microsoft.Win32.NativeMethods'
    ).GetMethod('NtQuerySystemInformation')).Name $$
	
$ta = [PSObject].Assembly.GetType(
      'System.Management.Automation.TypeAccelerators'
    )
	
	
$ta::Add('Marshal', [Runtime.InteropServices.Marshal])

$ptr = [Marshal]::AllocHGlobal(2048)
$ret = 0
$par = [Object[]]@(5, $ptr, 2048, $ret)


$nts = -1
while (($nts -ne 0)){ 
$nts = $NtQuerySystemInformation.Invoke($null, ($par = [Object[]]@(5, $ptr, $par[3], 0)))
$ptr = [Marshal]::ReAllocHGlobal($ptr, [IntPtr]$par[3])
}
$tmp = $ptr 

$th = Get-Process
$it = 0
#$aa = [Marshal]::ReadInt32($tmp + 0x00)
#Write-Host $aa
#$tmp = [IntPtr]($tmp.ToInt32() + $aa.ToInt32())

$Processes = while (($aa = [Marshal]::ReadInt32($tmp))) {
        $it += 1
        #$aa = [Marshal]::ReadInt32($tmp)
        New-Object PSObject -Property @{
          ProcessName = [Diagnostics.Process]::GetProcessById((
            $id = [Marshal]::ReadInt32($tmp, 0x50)
          )).Name
          PID = $id
          PPID = [Marshal]::ReadInt32($tmp, 0x58)
        }
        $tmp = [IntPtr]($tmp.ToInt64() + $aa)
      
    
    }




$Processes | ForEach-Object {
      '{0}:{1} --> PPID:{2}' -f $_.PID,  $_.ProcessName, $_.PPID
	  }
 
#$Processes
 
    [void]$ta::Remove('Marshal')

}
}
 