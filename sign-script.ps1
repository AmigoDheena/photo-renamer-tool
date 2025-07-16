# Sign-Script.ps1
# This script creates a self-signed certificate and uses it to sign the batch file
# Must be run with administrator privileges

# Create a self-signed certificate if one doesn't exist
$certName = "PhotoRenamerToolCert"
$cert = Get-ChildItem -Path Cert:\CurrentUser\My | Where-Object { $_.Subject -match $certName }

if (-not $cert) {
    Write-Host "Creating new self-signed certificate..."
    $cert = New-SelfSignedCertificate -Subject "CN=$certName" -Type CodeSigningCert -CertStoreLocation Cert:\CurrentUser\My
    Write-Host "Certificate created with thumbprint: $($cert.Thumbprint)"
}
else {
    Write-Host "Using existing certificate with thumbprint: $($cert.Thumbprint)"
}

# Sign the batch file
$filePath = Join-Path -Path $PSScriptRoot -ChildPath "photo-renamer-tool.bat"
Write-Host "Signing file: $filePath"

try {
    Set-AuthenticodeSignature -FilePath $filePath -Certificate $cert
    Write-Host "Successfully signed the batch file!"
    Write-Host "Note: You may still see a security warning, but it should now show the certificate name."
}
catch {
    Write-Host "Error signing the file: $_"
}

Write-Host "`nPress any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")