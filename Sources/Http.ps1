#================================================================================
Class Http {
    #------------------------------------------------------------------------------------------
    Static [PSCustomObject]SendHttpRequest([HashTable]$HttpParameters) {
        [PSCustomObject]$ret = @{}
        $HttpMethodTypeName = $HttpParameters.Method
        Switch ($HttpMethodTypeName) {
            'GET' {
                $url = $HttpParameters.Uri
                $proxyUri = [Uri]$Null
                $proxy = [system.net.webrequest]::GetSystemWebProxy()
                if ($proxy) {
                    $proxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials
                    $proxyUri = $proxy.GetProxy("$url")
                }
                Write-Verbose -Message ("$proxyUri")
                try {
                    if ("$proxyUri" -eq "$url") {
                        #そもそもクエリ文はいったURLをConstructにおいてるし、そこBodyにもっていってより汎用的なクラスにしたい
                        #これが本物if ("$proxyUri" -ne "$url") {
                        $HttpResponse = Invoke-WebRequest -Uri $HttpParameters.Uri `
                            -Method 'GET' `
                            -Headers $HttpParameters.Headers `
                            -UseDefaultCredentials `
                            -Proxy "$proxyUri" `
                            -ProxyUseDefaultCredentials `
                            -UseBasicParsing
                    }
                    else {
                        $HttpResponse = Invoke-WebRequest -Uri $HttpParameters.Uri `
                            -Method 'GET' `
                            -Headers $HttpParameters.Headers `
                            -UseBasicParsing
                    }
                    $StatusCode = $HttpResponse.StatusCode
                }
                catch [System.Net.WebException] {
            
                    $HttpResponse = $Null
                    $StatusCode = $_.Exception.Response.StatusCode.value__
                }
                if ($StatusCode -eq 200) {
                    $ret = [pscustomobject]$HttpResponse
                }
                else {
                    $ret = $ret
                }
            }
            'POST' {
                $ret = $ret
            }
        }#switchend
        return $ret
    }
    #------------------------------------------------------------------------------------------
    
}
#================================================================================
Class HttpResponseParser : Http {
    #------------------------------------------------------------------------------------------
    Static [Array]ParseHttpResponseToArray($HttpRawResponse, $ModelCode) {
        $ParsedHttpResponseArray = @()
        $ModelInstance = [Model]::New()
        $VendorCode = $ModelInstance.GetVendorCodeByModelCode($ModelCode)
        Switch ($VendorCode) {
            1 {
                $HttpResponseHashTable = $HttpRawResponse.Content | ConvertFrom-Json | ConvertTo-HashTable
                $HttpResponseHashTable_Body = $HttpResponseHashTable['Body']
                $HttpResponseHashTable_Body_DownloadItems = $HttpResponseHashTable_Body['DownloadItems']
                $HttpResponseHashTable_Body_DownloadItems | % {
                    $Files = $_['Files']
                    ForEach ($File in $Files) {
                        $BufferArray = @()
                        $BufferArray = @(
                            $_['Title']#0
                            $_['Summary']#1
                            $_['RebootRequired']#2
                            ($_['Category'])['Name']#3
                            $File['URL']#4
                            $File['Priority']#5
                            $File['PriorityWeight']#6
                            $File['Name']#7
                            $File['Version']#8
                            $File['TypeString']#9
                            $File['SHA1']#10
                            $File['Size']#11
                            ($File['Date'])['Unix']#12
                            (Convert-UnixTimeToDateTime(  ( ($File['Date'])['Unix'] -replace ".{3}$")))
                        )
                        $ParsedHttpResponseArray += , $BufferArray
                    }
                }
            }
            2 {}
        }
        return $ParsedHttpResponseArray
    }
    #------------------------------------------------------------------------------------------
}
#================================================================================