#================================================================================
Class Construct {
}
#================================================================================
Class PathDefiner : Construct {
    #ディレクトリ
    Static [String]$BaseDirectoryPath
    Static [String]$SourcesDirectoryPath
    Static [String]$LogsDirectoryPath
    Static [String]$AppLogsDirectoryPath
    Static [String]$TranscriptLogsDirectoryPath
    Static [String]$TransactionsDirectoryPath
    Static [String]$ExportDirectoryPath
    Static [String]$DriversDirectoryPath
    #モジュールファイルのパス
    Static [String]$AppLogModulePath
    Static [String]$FormModulePath
    Static [String]$GeneralConversionModulePath
    Static [String]$HistoryModulePath
    Static [String]$HttpModulePath
    Static [String]$UpdateModulePath
    Static [String]$VisualizeModulePath
    #実行単位の識別子
    Static [String]$ExecutionIdentifier
    #ログ
    Static [String]$AppLogPath
    Static [String]$TranscriptLogPath
    #------------------------------------------------------------------------------------------
    #デフォルトコンストラクタ
    PathDefiner() {
        #実行単位の識別子を設定する
        $Now = Get-Date
        [PathDefiner]::ExecutionIdentifier = $Now.ToString("yyyyMMddHHmmssfff")
        Write-Verbose -Message ([String][PathDefiner]::ExecutionIdentifier)
        #ディレクトリのフォルダ名を設定する
        $SourcesDirectoryFolderName = 'Sources'
        $LogsDirectoryFolderName = 'Logs'
        $AppLogsDirectoryFolderName = 'AppLogs'
        $TranscriptLogsDirectoryFolderName = 'TranscriptLogs'
        $TransactionsDirectoryFolderName = 'Transactions'
        $ExportDirectoryFolderName = 'Export'
        $DriversDirectoryFolderName = 'Drivers'
        #モジュールのファイル名を設定する
        $AppLogModuleFileName = 'AppLog.ps1'
        $FormModuleFileName = 'Form.ps1'
        $GeneralConversionModuleFileName = 'GeneralConversion.ps1'
        $HistoryModuleFileName = 'History.ps1'
        $HttpModuleFileName = 'Http.ps1'
        $UpdateModuleFileName = 'Update.ps1'
        $VisualizeModuleFileName = 'Visualize.ps1'
        #ディレクトリのパスを設定する
        [PathDefiner]::BaseDirectoryPath = Split-Path (Split-Path $Script:MyInvocation.MyCommand.Path -Parent) -Parent
        Write-Verbose -Message ([String][PathDefiner]::BaseDirectoryPath)
        [PathDefiner]::SourcesDirectoryPath = Join-Path ([PathDefiner]::BaseDirectoryPath) $SourcesDirectoryFolderName
        Write-Verbose -Message ([String][PathDefiner]::SourcesDirectoryPath)
        [PathDefiner]::LogsDirectoryPath = Join-Path ([PathDefiner]::BaseDirectoryPath) $LogsDirectoryFolderName
        Write-Verbose -Message ([String][PathDefiner]::LogsDirectoryPath)
        [PathDefiner]::AppLogsDirectoryPath = Join-Path ([PathDefiner]::LogsDirectoryPath) $AppLogsDirectoryFolderName
        Write-Verbose -Message ([String][PathDefiner]::AppLogsDirectoryPath)
        [PathDefiner]::TranscriptLogsDirectoryPath = Join-Path ([PathDefiner]::LogsDirectoryPath) $TranscriptLogsDirectoryFolderName
        Write-Verbose -Message ([String][PathDefiner]::TranscriptLogsDirectoryPath)
        [PathDefiner]::TransactionsDirectoryPath = Join-Path ([PathDefiner]::BaseDirectoryPath) $TransactionsDirectoryFolderName
        Write-Verbose -Message ([String][PathDefiner]::TransactionsDirectoryPath)
        [PathDefiner]::ExportDirectoryPath = Join-Path ([PathDefiner]::BaseDirectoryPath) $ExportDirectoryFolderName
        Write-Verbose -Message ([String][PathDefiner]::ExportDirectoryPath)
        [PathDefiner]::DriversDirectoryPath = Join-Path ([PathDefiner]::BaseDirectoryPath) $DriversDirectoryFolderName
        Write-Verbose -Message ([String][PathDefiner]::DriversDirectoryPath)
        #モジュールファイルのパスを設定する
        [PathDefiner]::AppLogModulePath = Join-Path ([PathDefiner]::SourcesDirectoryPath) $AppLogModuleFileName
        Write-Verbose -Message ([String][PathDefiner]::AppLogModulePath)
        [PathDefiner]::FormModulePath = Join-Path ([PathDefiner]::SourcesDirectoryPath) $FormModuleFileName
        Write-Verbose -Message ([String][PathDefiner]::FormModulePath)
        [PathDefiner]::GeneralConversionModulePath = Join-Path ([PathDefiner]::SourcesDirectoryPath) $GeneralConversionModuleFileName
        Write-Verbose -Message ([String][PathDefiner]::GeneralConversionModulePath)
        [PathDefiner]::HistoryModulePath = Join-Path ([PathDefiner]::SourcesDirectoryPath) $HistoryModuleFileName
        Write-Verbose -Message ([String][PathDefiner]::HistoryModulePath)
        [PathDefiner]::HttpModulePath = Join-Path ([PathDefiner]::SourcesDirectoryPath) $HttpModuleFileName
        Write-Verbose -Message ([String][PathDefiner]::HttpModulePath)
        [PathDefiner]::UpdateModulePath = Join-Path ([PathDefiner]::SourcesDirectoryPath) $UpdateModuleFileName
        Write-Verbose -Message ([String][PathDefiner]::UpdateModulePath)
        [PathDefiner]::VisualizeModulePath = Join-Path ([PathDefiner]::SourcesDirectoryPath) $VisualizeModuleFileName
        Write-Verbose -Message ([String][PathDefiner]::VisualizeModulePath)
        #ログファイルのパスを設定する
        $AppLogFileName = 'AppLog_' + [PathDefiner]::ExecutionIdentifier + '.log'
        Write-Verbose -Message ([String]$AppLogFileName)
        $TranscriptLogFileName = 'TranscriptLog_' + [PathDefiner]::ExecutionIdentifier + '.log'
        Write-Verbose -Message ([String]$TranscriptLogFileName)
        [PathDefiner]::AppLogPath = Join-Path ([PathDefiner]::AppLogsDirectoryPath) $AppLogFileName
        Write-Verbose -Message ([String][PathDefiner]::AppLogPath)
        [PathDefiner]::TranscriptLogPath = Join-Path ([PathDefiner]::TranscriptLogsDirectoryPath) $TranscriptLogFileName
        Write-Verbose -Message ([String][PathDefiner]::TranscriptLogPath)
    }
    #------------------------------------------------------------------------------------------
}
#==========================================================================================
Class Vendor : Construct {
    $Vendors = @{
        1 = 'Lenovo'
        2 = 'HP'
        3 = 'Panasonic'
    }
}
#================================================================================
Class Model : Vendor {
    $Models = @{
        1  = @{
            'ModelName'          = 'ThinkPad X260'
            'ModelAliasName'     = 'X260'
            'VendorCode'         = 1
            'HttpParametersCode' = 1
        }
        2  = @{
            'ModelName'          = 'ThinkPad X270'
            'ModelAliasName'     = 'X270'
            'VendorCode'         = 1
            'HttpParametersCode' = 2
        }
        3  = @{
            'ModelName'          = 'ThinkPad X280 20kf 20ke'
            'ModelAliasName'     = 'X280'
            'VendorCode'         = 1
            'HttpParametersCode' = 3
        }
        4  = @{
            'ModelName'          = 'ThinkPad L460'
            'ModelAliasName'     = 'L460'
            'VendorCode'         = 1
            'HttpParametersCode' = 4
        }
        5  = @{
            'ModelName'          = 'ThinkPad L470'
            'ModelAliasName'     = 'L470'
            'VendorCode'         = 1
            'HttpParametersCode' = 5
        }
        6  = @{
            'ModelName'          = 'ThinkPad L480'
            'ModelAliasName'     = 'L480'
            'VendorCode'         = 1
            'HttpParametersCode' = 6
        }
        7  = @{
            'ModelName'          = 'ThinkPad L490'
            'ModelAliasName'     = 'X280'
            'VendorCode'         = 1
            'HttpParametersCode' = 7
        }
        8  = @{
            'ModelName'          = ''
            'ModelAliasName'     = ''
            'VendorCode'         = ''
            'HttpParametersCode' = ''
        }
        9  = @{
            'ModelName'          = ''
            'ModelAliasName'     = ''
            'VendorCode'         = ''
            'HttpParametersCode' = ''
        }
        10 = @{
            'ModelName'          = ''
            'ModelAliasName'     = ''
            'VendorCode'         = ''
            'HttpParametersCode' = ''
        }
        11 = @{
            'ModelName'          = ''
            'ModelAliasName'     = ''
            'VendorCode'         = ''
            'HttpParametersCode' = ''
        }
        12 = @{
            'ModelName'          = ''
            'ModelAliasName'     = ''
            'VendorCode'         = ''
            'HttpParametersCode' = ''
        }
    }
    #------------------------------------------------------------------------------------------
    [String]GetModelNameByModelCode($ModelCode) {
        return ($This.Models[$ModelCode])['ModelName']
    }
    #------------------------------------------------------------------------------------------
    [String]GetModelAliasNameByModelCode($ModelCode) {
        return ($This.Models[$ModelCode])['ModelAliasName']
    }
    #------------------------------------------------------------------------------------------
    [String]GetVendorNameByModelCode($ModelCode) {
        $VendorCode = ($This.Models[$ModelCode])['VendorCode']
        return (([Vendor]$This).Vendors)[$VendorCode]
    }
    #------------------------------------------------------------------------------------------
    [Int]GetVendorCodeByModelCode($ModelCode) {
        return ($This.Models[$ModelCode])['VendorCode']
    }
    #------------------------------------------------------------------------------------------
}
#================================================================================
Class HttpParameters : Model {
    $HttpParameters = @{
        1  = @{
            'Method'  = 'GET'
            'Uri'     = "https://pcsupport.lenovo.com/us/ja/api/v4/downloads/drivers?productId=laptops-and-netbooks%2Fthinkpad-x-series-laptops%2Fthinkpad-x260"
            'Headers' = @{
                "method"           = "GET"
                "authority"        = "pcsupport.lenovo.com"
                "scheme"           = "https"
                "path"             = "/us/ja/api/v4/downloads/drivers?productId=laptops-and-netbooks%2Fthinkpad-x-series-laptops%2Fthinkpad-x260"
                "accept"           = "application/json, text/plain, */*"
                "x-requested-with" = "XMLHttpRequest"
                "sec-fetch-site"   = "same-origin"
                "sec-fetch-mode"   = "cors"
                "sec-fetch-dest"   = "empty"
                "referer"          = "https://pcsupport.lenovo.com/us/ja/products/laptops-and-netbooks/thinkpad-x-series-laptops/thinkpad-x260/downloads/driver-list/component?name=BIOS%2FUEFI"
                "accept-encoding"  = "gzip, deflate, br"
                "accept-language"  = "ja,en-US;q=0.9,en;q=0.8"
                "if-none-match"    = "W/`"31fdb-n+RkTU+kdz+s36KIPqMhkYrIrzg`""
            }
        }
        2  = @{
            'Method'  = 'GET'
            'Uri'     = "https://pcsupport.lenovo.com/ja/ja/api/v4/downloads/drivers?productId=laptops-and-netbooks%2Fthinkpad-x-series-laptops%2Fthinkpad-x270"
            'Headers' = @{
                "method"           = "GET"
                "authority"        = "pcsupport.lenovo.com"
                "scheme"           = "https"
                "path"             = "/ja/ja/api/v4/downloads/drivers?productId=laptops-and-netbooks%2Fthinkpad-x-series-laptops%2Fthinkpad-x270"
                "accept"           = "application/json, text/plain, */*"
                "x-requested-with" = "XMLHttpRequest"
                "sec-fetch-site"   = "same-origin"
                "sec-fetch-mode"   = "cors"
                "sec-fetch-dest"   = "empty"
                "referer"          = "https://pcsupport.lenovo.com/ja/ja/products/laptops-and-netbooks/thinkpad-x-series-laptops/thinkpad-x270/downloads/driver-list/"
                "accept-encoding"  = "gzip, deflate, br"
                "accept-language"  = "ja,en-US;q=0.9,en;q=0.8"
                "if-none-match"    = "W/`"21c52-SMfL0BbPw4METytj56R3xWT/fm4`""
            }
        }
        3  = @{
            'Method'  = 'GET'
            'Uri'     = 'https://pcsupport.lenovo.com/jp/ja/api/v4/downloads/drivers?productId=laptops-and-netbooks%2Fthinkpad-x-series-laptops%2Fthinkpad-x280-type-20kf-20ke'
            'Headers' = @{
                "method"           = "GET"
                "authority"        = "pcsupport.lenovo.com"
                "scheme"           = "https"
                "path"             = "/jp/ja/api/v4/downloads/drivers?productId=laptops-and-netbooks%2Fthinkpad-x-series-laptops%2Fthinkpad-x280-type-20kf-20ke"
                "accept"           = "application/json, text/plain, */*"
                "x-requested-with" = "XMLHttpRequest"
                "sec-fetch-site"   = "same-origin"
                "sec-fetch-mode"   = "cors"
                "sec-fetch-dest"   = "empty"
                "referer"          = "https://pcsupport.lenovo.com/jp/ja/products/laptops-and-netbooks/thinkpad-x-series-laptops/thinkpad-x280-type-20kf-20ke/downloads/automatic-driver-update"
                "accept-encoding"  = "gzip, deflate, br"
                "accept-language"  = "ja,en-US;q=0.9,en;q=0.8"
                "if-none-match"    = "W/`"24b66-Xf4ew0u3ialclaQFce/KVqlJp+c`""
            }
        }
        4  = @{
            'Method'  = 'GET'
            'Uri'     = "https://pcsupport.lenovo.com/bo/ja/api/v4/downloads/drivers?productId=laptops-and-netbooks%2Fthinkpad-l-series-laptops%2Fthinkpad-l460"
            'Headers' = @{
                "method"           = "GET"
                "authority"        = "pcsupport.lenovo.com"
                "scheme"           = "https"
                "path"             = "/bo/ja/api/v4/downloads/drivers?productId=laptops-and-netbooks%2Fthinkpad-l-series-laptops%2Fthinkpad-l460"
                "accept"           = "application/json, text/plain, */*"
                "x-requested-with" = "XMLHttpRequest"
                "sec-fetch-site"   = "same-origin"
                "sec-fetch-mode"   = "cors"
                "sec-fetch-dest"   = "empty"
                "referer"          = "https://pcsupport.lenovo.com/bo/ja/products/laptops-and-netbooks/thinkpad-l-series-laptops/thinkpad-l460/downloads/driver-list"
                "accept-encoding"  = "gzip, deflate, br"
                "accept-language"  = "ja,en-US;q=0.9,en;q=0.8"
                "if-none-match"    = "W/`"2ca03-+xayMD2hADwu+V4hxjIyvJi6/8k`""
            }
        }
        5  = @{
            'Method'  = 'GET'
            'Uri'     = "https://pcsupport.lenovo.com/us/ja/api/v4/downloads/drivers?productId=laptops-and-netbooks%2Fthinkpad-l-series-laptops%2Fthinkpad-l470"
            'Headers' = @{
                "method"           = "GET"
                "authority"        = "pcsupport.lenovo.com"
                "scheme"           = "https"
                "path"             = "/us/ja/api/v4/downloads/drivers?productId=laptops-and-netbooks%2Fthinkpad-l-series-laptops%2Fthinkpad-l470"
                "accept"           = "application/json, text/plain, */*"
                "x-requested-with" = "XMLHttpRequest"
                "sec-fetch-site"   = "same-origin"
                "sec-fetch-mode"   = "cors"
                "sec-fetch-dest"   = "empty"
                "referer"          = "https://pcsupport.lenovo.com/us/ja/products/laptops-and-netbooks/thinkpad-l-series-laptops/thinkpad-l470/downloads/driver-list/"
                "accept-encoding"  = "gzip, deflate, br"
                "accept-language"  = "ja,en-US;q=0.9,en;q=0.8"
                "if-none-match"    = "W/`"1cb1e-J7ywRXegKjrx/flR2sZ2aGpmCmE`""
            }
        }
        6  = @{
            'Method'  = 'GET'
            'Uri'     = "https://pcsupport.lenovo.com/jp/ja/api/v4/downloads/drivers?productId=laptops-and-netbooks%2Fthinkpad-l-series-laptops%2Fthinkpad-l480-type-20ls-20lt"
            'Headers' = @{
                "method"           = "GET"
                "authority"        = "pcsupport.lenovo.com"
                "scheme"           = "https"
                "path"             = "/jp/ja/api/v4/downloads/drivers?productId=laptops-and-netbooks%2Fthinkpad-l-series-laptops%2Fthinkpad-l480-type-20ls-20lt"
                "accept"           = "application/json, text/plain, */*"
                "x-requested-with" = "XMLHttpRequest"
                "sec-fetch-site"   = "same-origin"
                "sec-fetch-mode"   = "cors"
                "sec-fetch-dest"   = "empty"
                "referer"          = "https://pcsupport.lenovo.com/jp/ja/products/laptops-and-netbooks/thinkpad-l-series-laptops/thinkpad-l480-type-20ls-20lt/downloads/driver-list"
                "accept-encoding"  = "gzip, deflate, br"
                "accept-language"  = "ja,en-US;q=0.9,en;q=0.8"
                "if-none-match"    = "W/`"1fc8e-0XANczIEPM53Mqx7UwSQLQU6m6Q`""
            }
        }
        7  = @{
            'Method'  = 'GET'
            'Uri'     = "https://pcsupport.lenovo.com/jp/ja/api/v4/downloads/drivers?productId=laptops-and-netbooks%2Fthinkpad-l-series-laptops%2Fthinkpad-l490-type-20q5-20q6"
            'Headers' = @{
                "method"           = "GET"
                "authority"        = "pcsupport.lenovo.com"
                "scheme"           = "https"
                "path"             = "/jp/ja/api/v4/downloads/drivers?productId=laptops-and-netbooks%2Fthinkpad-l-series-laptops%2Fthinkpad-l490-type-20q5-20q6"
                "accept"           = "application/json, text/plain, */*"
                "x-requested-with" = "XMLHttpRequest"
                "sec-fetch-site"   = "same-origin"
                "sec-fetch-mode"   = "cors"
                "sec-fetch-dest"   = "empty"
                "referer"          = "https://pcsupport.lenovo.com/jp/ja/products/laptops-and-netbooks/thinkpad-l-series-laptops/thinkpad-l490-type-20q5-20q6/downloads/driver-list"
                "accept-encoding"  = "gzip, deflate, br"
                "accept-language"  = "ja,en-US;q=0.9,en;q=0.8"
                "if-none-match"    = "W/`"1bda5-OGTHo96cRqAPwGKWEgStP9nWm2E`""
            }
        }
        8  = @{
            'Uri'     = ''
            'Headers' = ''
        }
        9  = @{
            'Uri'     = ''
            'Headers' = ''
        }
        10 = @{
            'Uri'     = ''
            'Headers' = ''
        }
        11 = @{
            'Uri'     = ''
            'Headers' = ''
        }
        12 = @{
            'Uri'     = ''
            'Headers' = ''
        }
    }
    #------------------------------------------------------------------------------------------
    [HashTable]GetHttpParametersByModelCode($ModelCode) {
        $HttpParametersCode = ((([Model]$This).Models)[$ModelCode])['HttpParametersCode']
        $HttpParametersHashTable = ($This.HttpParameters)[$HttpParametersCode]
        return $HttpParametersHashTable
    }
    #------------------------------------------------------------------------------------------
}
#================================================================================
Class HttpResponseAttributes : Model {
    Static [HashTable]$LenovoFilesHashTableKeys = @{
        1  = 'URL'
        2  = 'Priority'
        3  = 'Name'
        4  = 'Version'
        5  = 'HasReadme'
        6  = 'Released'
        7  = 'TypeEnString'
        8  = 'Size'
        9  = 'ReadmeUrl'
        10 = 'OperatingSystemKeys'
        11 = 'SHA1'
        12 = 'PriorityWeight'
        13 = 'Date'
        14 = 'TypeString'
        15 = 'SHA256'
        16 = 'FileName'
        17 = 'MD5'
    }
    Static [HashTable]$LenovoDownloadItemsHashTableKeys = @{
        1  = 'RedirectTo'
        2  = 'Hit'
        3  = 'ID'
        4  = 'AlertDataLoss'
        5  = 'Updated'
        6  = 'InWarranty'
        7  = 'DocId'
        8  = 'RebootRequired'
        9  = 'OEMOnly'
        10 = 'RedirectCode'
        11 = 'Summary'
        12 = 'Title'
        13 = 'Category'
        14 = 'Countries'
        15 = 'OperatingSystemKeys'
        16 = 'SummaryInfo'
        17 = 'LanguageCode'
        18 = 'PNCheck'
        19 = 'Brocade'
        20 = 'RequireLogin'
        21 = 'Audiences'
        22 = 'Date'
        23 = 'Eods'
        24 = 'FixID'
        25 = 'Files'
    }
    Static [HashTable]$LenovoCategoryHashTableKeys = @{
        1 = 'Classify'
        2 = 'Name'
    }
    Static [HashTable]$LenovoDateHashTableKeys = @{
        1 = 'Unix'
    }
}
#================================================================================