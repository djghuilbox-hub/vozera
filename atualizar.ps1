& {
    $ErrorActionPreference = 'Stop'
    $ProgressPreference = 'SilentlyContinue'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $releases = Invoke-RestMethod 'https://api.github.com/repos/djghuilbox-hub/vozera/releases?per_page=30' -Headers @{'User-Agent'='Vozera'}
    $release = $releases | Where-Object { -not $_.draft -and $_.tag_name -match '^v\d+\.\d+\.\d+(?:-beta)?$' -and @($_.assets | Where-Object { $_.name -eq 'Vozera-Instalador.zip' }).Count -gt 0 } | Sort-Object @{Expression={[version]($_.tag_name -replace '^v','' -replace '-beta$','')};Descending=$true}, @{Expression={ $_.tag_name -notmatch '-beta$' };Descending=$true} | Select-Object -First 1
    if (-not $release) { throw 'Versão do Vozera não encontrada.' }
    $asset = $release.assets | Where-Object { $_.name -eq 'Vozera-Instalador.zip' } | Select-Object -First 1
    $url = 'https://github.com/djghuilbox-hub/vozera/releases/download/' + $release.tag_name + '/Vozera-Instalador.zip'
    if ($asset.browser_download_url -cne $url -or $asset.digest -notmatch '^sha256:[a-f0-9]{64}$') { throw 'Informações do instalador inválidas.' }
    $pasta = Join-Path $env:TEMP ('Vozera-' + [guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $pasta | Out-Null
    $zip = Join-Path $pasta 'instalador.zip'
    Write-Host "Baixando e conferindo $($release.tag_name)..."
    Invoke-WebRequest -Uri $url -OutFile $zip
    if ((Get-FileHash -LiteralPath $zip -Algorithm SHA256).Hash -ne $asset.digest.Substring(7)) { throw 'Verificação do instalador falhou.' }
    Expand-Archive -LiteralPath $zip -DestinationPath (Join-Path $pasta 'conteudo')
    & powershell.exe -STA -NoProfile -ExecutionPolicy Bypass -File (Join-Path $pasta 'conteudo\Instalar.ps1')
    if ($LASTEXITCODE -ne 0) { throw 'A instalação não foi concluída. Confira a mensagem acima.' }
}