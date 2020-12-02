#================================================================================
Function Get-FileHashValue_SHA1 {
    [OutputType([String])]
    [CmdletBinding()] 
    Param (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $FilePath
    )
    Begin {}
    Process {
        $Parent.Controls.AddRange($ChildControls)
    } 
    End {
        return $Parent
    }
}
#================================================================================
Function Get-FileHashValue_SHA1 {
}
#================================================================================
Function FileValidation($ComparisonSourcePath, $ComparisonDestinationPath) {
    $Algorithm = 'SHA1'

    $ComparisonSourceFileHash = Get-FileHash `
        -Path $ComparisonSourcePath `
        -Algorithm $Algorithm

    $ComparisonDestinationFileHash = Get-FileHash `
        -Path $ComparisonDesitinationPath `
        -Algorithm $Algorithm

}
#================================================================================