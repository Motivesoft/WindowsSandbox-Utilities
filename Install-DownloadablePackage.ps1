param(
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]$Url
)

# Split Url to extract the filename portion of the string and print it
$Filename = $Url.Split("/")[-1]

$DownloadedFile = "$env:temp\$Filename"

Write-Host "Downloading: $Url"
Invoke-WebRequest -Uri $Url -OutFile $DownloadedFile

# If the previous command completed successfully, display a success message
if ($?) {
    Write-Host "Installing: $Filename"
    Add-AppxPackage -Path $DownloadedFile
    
    # Delete the downloaded file
    Write-Host "Deleting: $DownloadedFile"
    Remove-Item $DownloadedFile
} else {
    Write-Host "File downloaded failed. Aborting"
}

# Example usage:
#.\Install-DownloadablePackage.ps1 -Url "https://example.com/path/to/file.ext"

