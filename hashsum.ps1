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
