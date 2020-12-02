#AkurahArabia
#Class�̓C���X�^���X��������AStatic�����o�Ƃ��ăA�N�Z�X����ق����������x������
#�����̍\�������ꂽ�f�[�^�ւ̃A�N�Z�X�̓n�b�V���e�[�u������{�I�ɍł��������x������

#�G���[�������̋���
$ErrorActionPreference = 'Stop'

#Verbose�o�͗L�����`
$VerbosePreference = 'Continue'
#$VerbosePreference = 'SilentlyContinue'

#�A�v���P�[�V�������O�̏o�͒i�K���`(0~5:Trace/Debug/Info/Warn/Error/Fatal)
$AppLogPreference = 0

#�萔�N���X���C���|�[�g
Import-Module (Join-Path (Split-Path $Script:MyInvocation.MyCommand.Path -Parent) 'Construct.ps1')

#�p�X��`�N���X�̃f�t�H���g�R���X�g���N�^���Ăяo���W���o�͂�Void�ɃL���X�g
[Void][PathDefiner]::New()

#Transcript���J�n����
Start-Transcript -Path ([PathDefiner]::TranscriptLogPath) -Append

#���\�[�X�ƂȂ郂�W���[���t�@�C����ǂݍ���
Import-Module ([PathDefiner]::AppLogModulePath)
Import-Module ([PathDefiner]::FormModulePath)
Import-Module ([PathDefiner]::GeneralConversionModulePath)
Import-Module ([PathDefiner]::HistoryModulePath)
Import-Module ([PathDefiner]::HttpModulePath)
Import-Module ([PathDefiner]::UpdateModulePath)
Import-Module ([PathDefiner]::VisualizeModulePath)

#���s�P�ʂ̊J�n�����O
WriteAppLog -LogLevel 0 -LogString ('�v���Z�X���J�n���܂���')
#================================================================================
$ExitPreference = $False

Do {

    $MainFormResult = CreateMainForm1

    if ($null -eq $MainFormResult) {
        Write-Host "�����܂���"
        $ExitPreference = $True
    }
    else {
        Switch ($MainFormResult) {
            1 {
                Write-Host "1���I�΂�܂���"
                CreateDownloadForm1
            }
            2 { Write-Host "2���I�΂�܂���" }
            3 { Write-Host "3���I�΂�܂���" }
        }
    }

}While ($False -eq $ExitPreference)
#================================================================================
#���s�P�ʂ̏I�������O
WriteAppLog -LogLevel 0 -LogString ('�v���Z�X���I�����܂���')

#Transcript���I������
Stop-Transcript

pause