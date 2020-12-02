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









#Z4g4 workstation
$ret = Invoke-WebRequest -Uri "https://support.hp.com/wps/portal/pps/Home/SWDSelfServiceStep/!ut/p/z1/jZBNC4JQEEV_jVtn8pt2ryjzq0iw7G1Cw56G-kRN_35iq6DM2c1wzoW5QCEEWkZdxqI242WUD_uFalcPLZRsEx3jZKtICNnLW8tfoIRwHoG1SXaK7iKaR2WFlu4dnI1vyGhpQOf4-GMIzvMnADodfwY6IlMf_MuwgbKcx--6SBnLBgNaJ_ekTmrxWQ_ntG2rZimggH3fi4xzlifijRcCflNS3rQQfpJQFUEQ4kPNO5e8AOA7OWw!/p0/IZ7_M0I02JG0KGVO00AUBO4GT60082=CZ6_M0I02JG0K8VJ50AAAN3FIR1020=NJgetSoftwareDriverDetails=/" `
    -Method "POST" `
    -Headers @{
    "method"           = "POST"
    "authority"        = "support.hp.com"
    "scheme"           = "https"
    "path"             = "/wps/portal/pps/Home/SWDSelfServiceStep/!ut/p/z1/jZBNC4JQEEV_jVtn8pt2ryjzq0iw7G1Cw56G-kRN_35iq6DM2c1wzoW5QCEEWkZdxqI242WUD_uFalcPLZRsEx3jZKtICNnLW8tfoIRwHoG1SXaK7iKaR2WFlu4dnI1vyGhpQOf4-GMIzvMnADodfwY6IlMf_MuwgbKcx--6SBnLBgNaJ_ekTmrxWQ_ntG2rZimggH3fi4xzlifijRcCflNS3rQQfpJQFUEQ4kPNO5e8AOA7OWw!/p0/IZ7_M0I02JG0KGVO00AUBO4GT60082=CZ6_M0I02JG0K8VJ50AAAN3FIR1020=NJgetSoftwareDriverDetails=/"
    "accept"           = "application/json, text/javascript, */*; q=0.01"
    "x-requested-with" = "XMLHttpRequest"
    "origin"           = "https://support.hp.com"
    "sec-fetch-site"   = "same-origin"
    "sec-fetch-mode"   = "cors"
    "sec-fetch-dest"   = "empty"
    "referer"          = "https://support.hp.com/jp-ja/drivers/selfservice/hp-z4-g4-workstation/16449890"
    "accept-encoding"  = "gzip, deflate, br"
    "accept-language"  = "ja,en-US;q=0.9,en;q=0.8"
} `
    -ContentType "application/x-www-form-urlencoded; charset=UTF-8" `
    -Body "requestJson=%7B%22productNameOid%22%3A%2216449890%22%2C%22urlLanguage%22%3A%22ja%22%2C%22language%22%3A%22ja%22%2C%22osId%22%3A%22792898937266030878164166465223921%22%2C%22countryCode%22%3A%22jp%22%2C%22detectedOSBit%22%3A%22%22%2C%22platformName%22%3A%22Windows%22%2C%22platformId%22%3A%22487192269364721453674728010296573%22%2C%22versionName%22%3A%22Windows+10+(64+%E3%83%93%E3%83%83%E3%83%88)%22%2C%22versionId%22%3A%22792898937266030878164166465223921%22%2C%22osLanguageName%22%3A%22ja%22%2C%22osLanguageCode%22%3A%22ja%22%2C%22hpTermsOfUseURL%22%3A%22https%3A%2F%2Fsupport.hp.com%2Fjp-ja%2Fdocument%2Fc05262090%22%2C%22inOSDriverLinkURL%22%3A%22https%3A%2F%2Fsupport.hp.com%2Fjp-ja%2Fdocument%2Fc01824963%22%2C%22termsOfUseTitle%22%3A%22%E3%83%80%E3%82%A6%E3%83%B3%E3%83%AD%E3%83%BC%E3%83%89%E3%81%AB%E3%82%88%E3%82%8A%E3%80%81%E5%90%8C%E6%84%8F%E3%81%97%E3%81%BE%E3%81%99+HP%E3%81%AE%E5%88%A9%E7%94%A8%E8%A6%8F%E7%B4%84+undefined%22%2C%22privyPolicyURL%22%3A%22http%3A%2F%2Fwww8.hp.com%2Fjp%2Fja%2Fprivacy%2Fprivacy.html%22%2C%22bitInfoUrl%22%3A%22https%3A%2F%2Fsupport.hp.com%2Fjp-ja%2Fdocument%2Fc03672062%22%2C%22sku%22%3A%22%22%2C%22productSeriesOid%22%3A%2216449890%22%2C%22productSeriesName%22%3A%22hp-z4-g4-workstation%22%7D"


#最初のHTTPレスポンスに含まれるもの
#tembaseJson / swdJson (-> ConvertFrom-JsonしたHTTPレスポンスに、.swdJsonでアクセスする)
#.swdJsonでアクセスした後、ハッシュテーブルのオブジェクトコレクションになるので%でアクセス

#「swdJson」が持つハッシュテーブルコレクションの各ハッシュテーブルのKeys
#   -> id = これ以上広がりはないし、使い道なさそう。各ドライバの識別子ではなくて各項目名の識別子っぽいから
#   -> accordianName = カテゴリ名「BIOS」「ソフトウェア」「診断」みたいなやつ。HPでは、この「カテゴリ名」の「softwareDriversList」が、そのカテゴリに入るすべてのドライバの詳細を持っている
#   -> typeDriver = 多分ドライバかいなかをTrue/Falseでだしてる。「カテゴリ名にドライバーって入ってるやつはTrue」
#   -> severityWeight = あんまり取得しても意味ない。多分まだ個別の緊急度じゃないっぽい
#   -> softwareDriversList = こいつが持つハッシュテーブルコレクションの各ハッシュテーブルのKeys
#      -> submittalTypeID #owari
#      -> layoutType #よくわからん文字列だけ多分意味なさそう
#      -> associatedContentList #README的なHTMLだけ乗ってるから取る意味ない
#      -> subID　#よくわからん数値だけ意味なさそう
#      -> publicationId #識別IDになりそうだからとる意味ありそう
#      -> latestVersionDriver
#      -> previousVersionOfDriversList
#   -> tmsName = 超ざっくりの区分け。「Driver」「Software」「Utility」とかで分かれてるし、あまり識別できる感じじゃない








$ret

$test = $ret.Content | ConvertFrom-Json

$wow = $test.swdJson | ConvertFrom-Json | ConvertTo-Hashtable

$wow | % {
    $ha = $_['SoftwareDriversList']

    ForEach ($item in $ha) {
        Write-Host '------------------'
        $_['accordianName']
        ($item['latestVersionDriver'])['Version']
        ($item['latestVersionDriver'])['title']
        ($item['latestVersionDriver'])['fileUrl']
        ($item['latestVersionDriver'])['osBit']
        ($item['latestVersionDriver'])['versionUpdatedDate']
        ($item['latestVersionDriver'])['fileSize']
    }


}

#$wow.GetType()

#$wow['id']
#$wow['accordianName']
#$wow['typeDriver']
#$wow['severityWeight']
#$wow['softwareDriversList']
#$wow['tmsName']


#ForEach ($item in $wow.keys) {
##$item
#}
pause

