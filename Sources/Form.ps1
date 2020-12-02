#================================================================================
Add-Type -AssemblyName System.Windows.Forms
#================================================================================
Function CreateTabControl {
    [OutputType([System.Windows.Forms.TabControl])]
    [CmdletBinding()] 
    Param (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $Size
    )
    Begin {}
    Process {
        $TabControl = New-Object System.Windows.Forms.TabControl
        $TabControl.size = $Size
    }
    End {
        return $TabControl
    }
}
#================================================================================
Function CreateTabPage {
    [OutputType([System.Windows.Forms.TabPage])]
    [CmdletBinding()] 
    Param (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $Text
    )
    Begin {}
    Process {
        $TabPage = New-Object System.Windows.Forms.TabPage
        $TabPage.Text = $Text
    }
    End {
        return $TabPage
    }
}
#================================================================================
Function CreateDateTimePicker {
    [OutputType([System.Windows.Forms.DatetimePicker])]
    [CmdletBinding()] 
    Param (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $Location
    )
    Begin {}
    Process {
        $DateTimePicker = New-Object System.Windows.Forms.DatetimePicker
        $DateTimePicker.location = $Location
    }
    End {
        return $DateTimePicker
    }
}
#================================================================================
Function CreateForm {
    [OutputType([System.Windows.Forms.Form])]
    [CmdletBinding()] 
    Param (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $Size,
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $Text,
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $StartPosition
    )
    Begin {}
    Process {
        $Form = New-Object System.Windows.Forms.Form
        $Form.Size = $Size
        $Form.StartPosition = $StartPosition
        $Form.Text = $Text
    } 
    End {
        return $Form
    }
}
#================================================================================
#ボタン
Function CreateButton {
    [OutputType([System.Windows.Forms.Button])]
    [CmdletBinding()] 
    Param (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $Location,
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $Size,
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $Text
    )
    Begin {}
    Process {
        $Button = New-Object System.Windows.Forms.Button
        $Button.Location = $Location
        $Button.Size = $Size
        $Button.Text = $Text
        $Button.DialogResult = [System.Windows.Forms.DialogResult]::OK
    } 
    End {
        return $Button
    }
}
#================================================================================
Function AddControls {
    [CmdletBinding()] 
    Param (
        [parameter(
            Mandatory = $true,
            ValueFromPipeline
        )]
        [ValidateNotNullOrEmpty()]
        $Parent,
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $ChildControls
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
Function AddControl {
    [OutputType([System.Windows.Forms.Form])]
    [CmdletBinding()] 
    Param (
        [parameter(
            Mandatory = $true,
            ValueFromPipeline
        )]
        [ValidateNotNullOrEmpty()]
        $Parent,
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $ChildControl
    )
    Begin {}
    Process {
        $Parent.Controls.Add($ChildControl)
    } 
    End {
        return $Parent
    }
}
#================================================================================
Class Form {
}
#================================================================================
Function CreateMainForm1() {
    #全てのフォームとコントロールを作成
    $MainForm1 = CreateForm -Size "500,500" -Text "DeviceDriversManager" -StartPosition "CenterScreen"
    #フォームで選択されたボタンを識別する値を格納する非表示ラベル
    $ResultContainerAsHiddenLabel = New-Object System.Windows.Forms.Label
    #表示するボタンのサイズとテキストを設定
    $Button1 = CreateButton -Location "30,50" -Size "300,80" -Text "ダウンロード可能なドライバを探す"
    $Button2 = CreateButton -Location "30,150" -Size "300,80" -Text "ダウンロードしたドライバを管理する"
    $Button3 = CreateButton -Location "30,250" -Size "300,80" -Text "ファイルに出力する"
    #コントロールリストにまとめる
    $MainForm1Controls = @(
        $ResultContainerAsHiddenLabel
        $Button1
        $Button2
        $Button3 
    )
    #コントロールをメインフォームに追加
    $MainForm1.Controls.AddRange($MainForm1Controls)
    #各ボタンのイベントを設定
    $Button1_Event1 = {
        $ResultContainerAsHiddenLabel.Text = 1
    }
    $Button2_Event1 = {
        $ResultContainerAsHiddenLabel.Text = 2
    }
    $Button3_Event1 = {
        $ResultContainerAsHiddenLabel.Text = 3
    }
    #各ボタンのイベントをボタンに追加
    $Button1.Add_Click($Button1_Event1)
    $Button2.Add_Click($Button2_Event1)
    $Button3.Add_Click($Button3_Event1)

    $DialogResult = $MainForm1.ShowDialog()

    if ($DialogResult -eq "OK") {
        return $ResultContainerAsHiddenLabel.Text
    }

}
#================================================================================
Function CreateDownloadForm1() {

    $ModelCode = 3

    $HttpParametersInstance = [HttpParameters]::New()
    $HttpParameters = $HttpParametersInstance.GetHttpParametersByModelCode($ModelCode)
    $HttpRawResponse = [Http]::SendHttpRequest($HttpParameters)
    $HttpParsedResponseArray = [HttpResponseParser]::ParseHttpResponseToArray($HttpRawResponse, $ModelCode)

    $DownloadItemsFormWidth = 1500
    $DownloadItemsFormHeight = 1000

    # フォーム
    $Form = New-Object System.Windows.Forms.Form
    $Form.Size = "$DownloadItemsFormWidth,$DownloadItemsFormHeight"
    $Form.StartPosition = "CenterScreen"
    $Form.Text = "利用可能なダウンロード一覧"

    $ListViewWidth = $DownloadItemsFormWidth - 100
    $ListViewHeight = $DownloadItemsFormHeight - 100

    # リストビューの設置（チェック・ボックス付き）
    $ListView = New-Object System.Windows.Forms.ListView
    $ListView.Location = "10,10"
    $ListView.Size = "$ListViewWidth,$ListViewHeight"
    $ListView.View = "Details"
    $ListView.GridLines = $True
    $ListView.CheckBoxes = $True
    $ListView.AllowColumnReorder = $True

    # リストビューにヘッダーを追加
    #タイトル一覧
    $Columns = @(
        "No"
        "タイトル"
        "日付"
        "カテゴリ"
        "URL"
        "重要度"
        "名前"
        "バージョン"
        "タイプ"
        "ファイルサイズ"
    )

    [Int]$EachColumnWidth = $ListViewWidth / $Columns.Length

    $Columns | % {
        [void]$ListView.Columns.Add($_, $EachColumnWidth)
    }

    $Number = 1
    $HttpParsedResponseArray | % {

        If ([String]$_[9] -ne 'TXT README') {
            $Item = New-Object System.Windows.Forms.ListViewItem($Number)#No
            [void]$Item.SubItems.Add([String]$_[0])#"タイトル"
            [void]$Item.SubItems.Add([String]$_[13])#"日付"
            [void]$Item.SubItems.Add([String]$_[3])#"カテゴリ"
            [void]$Item.SubItems.Add([String]$_[4])#"URL"
            [void]$Item.SubItems.Add([String]$_[5])#"重要度"
            [void]$Item.SubItems.Add([String]$_[7])#"名前"
            [void]$Item.SubItems.Add([String]$_[8])#"バージョン"
            [void]$Item.SubItems.Add([String]$_[9])#"タイプ"
            [void]$Item.SubItems.Add([String]$_[11])#"ファイルサイズ"
            #ForEach ($SubItem in $_) {
            #[void]$Item.SubItems.Add([String]$SubItem)
            #}
            $Item.Checked = $False
            [void]$ListView.Items.Add($Item)
            $Number += 1
        }
    }

    $TabControlViewWidth = $DownloadItemsFormWidth
    $TabControlViewHeight = $DownloadItemsFormHeight

    # タブコントロール
    $TabControl = New-Object System.Windows.Forms.TabControl
    $TabControl.size = "$TabControlViewWidth,$TabControlViewHeight"
    # タブページ1
    $Tab1 = New-Object System.Windows.Forms.TabPage
    $Tab1.Text = "タブ1"
    $Tab1.Controls.AddRange(@($ListView))

    # タブページ2
    $Tab2 = New-Object System.Windows.Forms.TabPage
    $Tab2.Text = "タブ2"

    # タブコントロールに各タブページを入れる
    $TabControl.Controls.AddRange(@($Tab1, $Tab2))

    # フォームにタブコントロールを入れる
    $Form.Controls.Add($TabControl)

    #$Form.Controls.AddRange(@($ListView))

    $ListView.add_ColumnClick( { SortListView $_.Column })

    $ListView.AutoResizeColumns(1)
 
    $Form.Showdialog()
}
#================================================================================
function SortListView {
    param([parameter(Position = 0)][UInt32]$Column)
    $Numeric = $true # determine how to sort
    # if the user clicked the same column that was clicked last time, reverse its sort order. otherwise, reset for normal ascending sort
    if ($Script:LastColumnClicked -eq $Column) {
        $Script:LastColumnAscending = -not $Script:LastColumnAscending
    }
    else {
        $Script:LastColumnAscending = $true
    }
    $Script:LastColumnClicked = $Column
    $ListItems = @(@(@())) # three-dimensional array; column 1 indexes the other columns, column 2 is the value to be sorted on, and column 3 is the System.Windows.Forms.ListViewItem object
    foreach ($ListItem in $ListView.Items) {
        # if all items are numeric, can use a numeric sort
        if ($Numeric -ne $false) {
            # nothing can set this back to true, so don't process unnecessarily
            try {
                $Test = [Double]$ListItem.SubItems[[int]$Column].Text
            }
            catch {
                $Numeric = $false # a non-numeric item was found, so sort will occur as a string
            }
        }
        $ListItems += , @($ListItem.SubItems[[int]$Column].Text, $ListItem)
    }
    # create the expression that will be evaluated for sorting
    $EvalExpression = {
        if ($Numeric)
        { return [Double]$_[0] }
        else
        { return [String]$_[0] }
    }
    # all information is gathered; perform the sort
    $ListItems = $ListItems | Sort-Object -Property @{Expression = $EvalExpression; Ascending = $Script:LastColumnAscending }
    ## the list is sorted; display it in the listview
    $ListView.BeginUpdate()
    $ListView.Items.Clear()
    foreach ($ListItem in $ListItems) {
        $ListView.Items.Add($ListItem[1])
    }
    $ListView.EndUpdate()
}
#================================================================================