#================================================================================
Function ConvertTo-Hashtable {
    [CmdletBinding()]
    [OutputType('hashtable')]
    param (
        [Parameter(ValueFromPipeline)]
        $InputObject
    )
    process {
        if ($null -eq $InputObject) {
            return $null
        }
        if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string]) {
            $collection = @(
                foreach ($object in $InputObject) {
                    ConvertTo-Hashtable -InputObject $object
                }
            )
            Write-Output -NoEnumerate $collection
        }
        elseif ($InputObject -is [psobject]) {
            $hash = @{}
            foreach ($property in $InputObject.PSObject.Properties) {
                $hash[$property.Name] = ConvertTo-Hashtable -InputObject $property.Value
            }
            $hash
        }
        else {
            $InputObject
        }
    }
}
#================================================================================
Function Convert-UnixTimeToDateTime($unixTime) {
    $origin = New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0
    $origin.AddSeconds($unixTime)
}
#================================================================================
Function Convert-DateTimeToUnixTime($dateTime) {
    $origin = New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0
    [Int]($dateTime - $origin).TotalSeconds
}
#================================================================================
Class Parser {

    Static [HashTable]ConvertToHashTable($InputObject) {
        $ret = $InputObject | ConvertTo-Hashtable
        return [HashTable]$ret
    }

}
#================================================================================