function hashsum(){
    param(
        $alg,
        [Parameter(Mandatory=$False)][string]$path,
        [Parameter(Mandatory=$False,ValueFromPipeline=$True)][System.IO.FileSystemInfo]$file, 
        [Parameter(Mandatory=$False,ValueFromPipeline=$True)][string]$string
    )

    $crypto = [System.Security.Cryptography.HashAlgorithm]::Create($alg)

    if($path){
        $file = gi -l $path -ErrorAction Inquire
    }
    if($file){
        $stream = $file.OpenRead();
        $retVal = $crypto.ComputeHash($stream)
        $stream.Close();
    }else{
        $retVal = $crypto.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($string))
    }

    $crypto.Dispose();
    return [BitConverter]::ToString($retVal).Replace("-","");
}

function md5sum(){
    param(
        [Parameter(Mandatory=$False)][string]$path,
        [Parameter(Mandatory=$False,ValueFromPipeline=$True)][System.IO.FileSystemInfo]$file, 
        [Parameter(Mandatory=$False,ValueFromPipeline=$True)][string]$string
           
    )
    hashsum md5 -file $file -string $string -path $path
}


function sha1sum(){
    param(
        [Parameter(Mandatory=$False)][string]$path,
        [Parameter(Mandatory=$False,ValueFromPipeline=$True)][System.IO.FileSystemInfo]$file, 
        [Parameter(Mandatory=$False,ValueFromPipeline=$True)][string]$string
           
    )
    hashsum sha1 -file $file -string $string -path $path
}

# SIG # Begin signature block
# MIIF8AYJKoZIhvcNAQcCoIIF4TCCBd0CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU1qpvVXuwcNjF/sUWRjtrhl0H
# EMmgggNrMIIDZzCCAk+gAwIBAgIEA4Rv7DANBgkqhkiG9w0BAQUFADBkMRAwDgYD
# VQQGEwdVbmtub3duMRAwDgYDVQQIEwdVbmtub3duMRAwDgYDVQQHEwdVbmtub3du
# MQswCQYDVQQKEwJFUzEQMA4GA1UECxMHVW5rbm93bjENMAsGA1UEAxMEQ29kZTAe
# Fw0xMjExMTYwMDU3MjVaFw0xMzExMTEwMDU3MjVaMGQxEDAOBgNVBAYTB1Vua25v
# d24xEDAOBgNVBAgTB1Vua25vd24xEDAOBgNVBAcTB1Vua25vd24xCzAJBgNVBAoT
# AkVTMRAwDgYDVQQLEwdVbmtub3duMQ0wCwYDVQQDEwRDb2RlMIIBIjANBgkqhkiG
# 9w0BAQEFAAOCAQ8AMIIBCgKCAQEAhXI5twUgFHPgBTbfjOOmLbs7+Dq/vihMCb/y
# 1GgMaQm3CQ6b1mKQ7pmB4VthPo5hetX68sH0HBxDuo0A801cI0LwIoNE1sLIJqdG
# O4nhe6FPhIS8zuykunZwP3p+RM3H9GTHsBn35vKv1OoukIJZozCXQPdqtuf3FbGp
# e9R7EzUgHTR1FI82qPtEUp9RcnExYa78pMjhkVB3ZJxlCXH7ud7p9PBcUYhxGSGt
# sP/5T5yF7T8r9A9QXWCHnr/bXUHzTdPbNCWxg9jOMU/2bF+As5+8ihgDKy5k83nO
# MeeiMcNmjZFa/4XrYRJnXui6ZqZm935eRFxDyo9gUTlz6Ph3TwIDAQABoyEwHzAd
# BgNVHQ4EFgQUAEu9EOiG5LNpb87226QQ40dp+zswDQYJKoZIhvcNAQEFBQADggEB
# AITX9+l60GNE175Tj+zPoMKECeidXNBB72soVq631NjBcOt+XRWMV1HIQo5e+5HA
# D/Bgz6PVi2eQHSN8kLISKW83K1yyqfUAkBabq70k1zLzEapRnvc9OJRr28NcOZxx
# zOtEr6Oho4+IbKtZbCJzTiRo87ZtCnkV8BL2gG8emKMTo9Wocj2n8y+EsObCyQJi
# PoE1G0+YceXMuPx1y8ljDASTkymfRSQXdebt236YR9Dp4kICyYjx/U5GYTeZlycP
# sPmndkXl1todQ3JlS4ugfVkIEAMfTKL3CPr/mWgR+NyGz9qNyB5YkyJfDUgMB4/B
# kUfSyma30BQZNWXiUKVoCLQxggHvMIIB6wIBATBsMGQxEDAOBgNVBAYTB1Vua25v
# d24xEDAOBgNVBAgTB1Vua25vd24xEDAOBgNVBAcTB1Vua25vd24xCzAJBgNVBAoT
# AkVTMRAwDgYDVQQLEwdVbmtub3duMQ0wCwYDVQQDEwRDb2RlAgQDhG/sMAkGBSsO
# AwIaBQCgWjAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEM
# BgorBgEEAYI3AgEEMCMGCSqGSIb3DQEJBDEWBBQrojpN/uYvMKVS/wjLZG4F/QTQ
# HzANBgkqhkiG9w0BAQEFAASCAQBOpqAJTHT9i7FARo8aH4JFpJ24vK9ux/JEGP69
# y6d4kAsvPKPDOoWSrwmYoxHiG4QIhRIxjL2aYRA92wnbk458if2pjYMhKPiTJA30
# GY5dSrj51PKSfVvWiyPo4DKalub5dCcngCFKI2xI7Uc5jPCJ1u2hb5ivFVSlOR92
# bvbF7qBh0pLwifVxAOHU2rbKvKJnnFhR27qKUlBQ3MuvAhf7j3+OK8bM8Xen5URm
# M/NNtK68sDLlA6PoT0pNi0WyCw/jF9TJGRTEzc/xEPAE9ZRvEkV+zKnhQr6yOEpN
# yWhU5j9/JCdmm3b4SSt4DLbQfQ0ycscv/pOILDZG+pcF38+R
# SIG # End signature block
