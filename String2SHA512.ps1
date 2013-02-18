$string=""

$crypto = [System.Security.Cryptography.SHA512]::Create()
[BitConverter]::ToString($crypto.ComputeHash([system.Text.Encoding]::ASCII.GetBytes($string))).Replace("-","").ToLower()
$crypto.Dispose()
