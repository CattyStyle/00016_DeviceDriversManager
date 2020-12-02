#AkurahArabia
#Classはインスタンス化するより、Staticメンバとしてアクセスするほうが処理速度が早い
#複数の構造化されたデータへのアクセスはハッシュテーブルが基本的に最も処理速度が早い

#エラー発生時の挙動
$ErrorActionPreference = 'Stop'

#Verbose出力有無を定義
$VerbosePreference = 'Continue'
#$VerbosePreference = 'SilentlyContinue'

#アプリケーションログの出力段階を定義(0~5:Trace/Debug/Info/Warn/Error/Fatal)
$AppLogPreference = 0

#定数クラスをインポート
Import-Module (Join-Path (Split-Path $Script:MyInvocation.MyCommand.Path -Parent) 'Construct.ps1')

#パス定義クラスのデフォルトコンストラクタを呼び出し標準出力はVoidにキャスト
[Void][PathDefiner]::New()

#Transcriptを開始する
Start-Transcript -Path ([PathDefiner]::TranscriptLogPath) -Append

#リソースとなるモジュールファイルを読み込み
Import-Module ([PathDefiner]::AppLogModulePath)
Import-Module ([PathDefiner]::FormModulePath)
Import-Module ([PathDefiner]::GeneralConversionModulePath)
Import-Module ([PathDefiner]::HistoryModulePath)
Import-Module ([PathDefiner]::HttpModulePath)
Import-Module ([PathDefiner]::UpdateModulePath)
Import-Module ([PathDefiner]::VisualizeModulePath)

#実行単位の開始をログ
WriteAppLog -LogLevel 0 -LogString ('プロセスが開始しました')
#================================================================================
$ExitPreference = $False

Do {

    $MainFormResult = CreateMainForm1

    if ($null -eq $MainFormResult) {
        Write-Host "閉じられました"
        $ExitPreference = $True
    }
    else {
        Switch ($MainFormResult) {
            1 {
                Write-Host "1が選ばれました"
                CreateDownloadForm1
            }
            2 { Write-Host "2が選ばれました" }
            3 { Write-Host "3が選ばれました" }
        }
    }

}While ($False -eq $ExitPreference)
#================================================================================
#実行単位の終了をログ
WriteAppLog -LogLevel 0 -LogString ('プロセスが終了しました')

#Transcriptを終了する
Stop-Transcript

pause