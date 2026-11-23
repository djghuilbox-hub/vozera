# Vozera

> **Versão beta:** antes de usar uma narração, confira o áudio inteiro. A geração de roteiros longos, especialmente com v4 Turbo, ainda precisa de validação completa.

[Baixar o instalador para Windows](https://github.com/djghuilbox-hub/vozera/releases/download/v0.1.0-beta/Vozera-Instalador.zip)

Transforme seus textos em narrações usando sua própria conta ElevenLabs. O Vozera funciona no Windows e permite escolher vozes e modelos, acompanhar o consumo estimado, gerar e baixar áudio e juntar partes em um único MP3.

## Instalação

1. Abra o **PowerShell** e cole o comando abaixo. O Claude Code no Windows também pode executá-lo.

```powershell
$zip = Join-Path $env:TEMP ('Vozera-' + [guid]::NewGuid().ToString('N') + '.zip'); Invoke-WebRequest 'https://github.com/djghuilbox-hub/vozera/releases/download/v0.1.0-beta/Vozera-Instalador.zip' -OutFile $zip; if ((Get-FileHash -LiteralPath $zip -Algorithm SHA256).Hash -ne '7B090BF39F1314D0C46261F982A2AB90F740E627FDAF3A280CE0A2351CB90093') { throw 'O instalador não passou na verificação de integridade.' }; $pasta = Join-Path $env:TEMP ('Vozera-' + [guid]::NewGuid().ToString('N')); Expand-Archive -LiteralPath $zip -DestinationPath $pasta; powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $pasta 'Instalar.ps1')
```

2. Se preferir, [baixe o ZIP](https://github.com/djghuilbox-hub/vozera/releases/download/v0.1.0-beta/Vozera-Instalador.zip), salve na pasta Downloads e siga o arquivo **COMO INSTALAR.txt** que vem dentro dele.
3. Se o instalador pedir para instalar o FFmpeg, acompanhe as mensagens na tela. O FFmpeg é necessário para juntar os áudios.
4. Ao concluir, abra **Vozera** pela Área de Trabalho. Mantenha a janela do aplicativo aberta durante o uso.

Você não precisa instalar Git nem Python. O aplicativo abre no navegador, mas roda localmente no seu computador. É necessário acesso à internet para conectar à ElevenLabs e gerar narrações.

## Primeiro acesso: chave da ElevenLabs

1. Crie uma conta ou entre na ElevenLabs e abra a página de chaves de API.
2. Crie uma chave com um nome que ajude você a identificá-la.
3. Libere **Text to Speech** e leitura de **Voices**. Para ver saldo e histórico, libere também leitura de **User/Subscription** e **History**, quando disponíveis. Os nomes podem variar na interface.
4. Copie a chave, cole no Vozera e clique em **Conectar**. A chave fica protegida na sua conta do Windows. Não compartilhe esse código.

Há acesso inicial gratuito, com limitações, e também há pagamento conforme o uso. Um plano pago pode ser necessário para determinados recursos, limites ou direitos comerciais. Verifique as condições da sua conta antes de usar o áudio em projetos comerciais.

## Como usar

1. Informe um título e cole o roteiro.
2. Escolha uma voz e um modelo. Confira a estimativa de duração e consumo.
3. Clique em **Gerar narração** e aguarde. A geração usa os créditos da sua conta ElevenLabs; os valores mostrados antes da geração são estimativas.
4. Baixe cada parte separadamente ou o MP3 unido. Você também pode encontrar os arquivos completos na biblioteca local.

Em **Juntar áudios**, você pode selecionar arquivos já existentes na ordem desejada e criar um novo MP3. Essa união é feita no seu computador e não usa créditos de geração.

## Perguntas frequentes

**O Claude precisa estar instalado?** Não. O Claude Code é apenas uma forma opcional de executar o comando de instalação.

**É preciso clonar este repositório?** Não. Basta obter o arquivo de instalação e seguir os passos acima.

**Posso usar minha própria chave?** Sim. Cada pessoa usa a chave da própria conta. O instalador não contém uma chave compartilhada.

**O tempo e o consumo são exatos?** São estimativas antes da geração e podem variar conforme voz, modelo, plano e pausas. Revise o áudio completo antes de usá-lo em um vídeo.

**O áudio parece incompleto?** Baixe as partes disponíveis e confira o conteúdo antes de gerar novamente. Uma nova tentativa pode consumir créditos. Se o aplicativo não conseguir uni-las, use **Juntar áudios** depois de salvá-las.

## Uso e distribuição

A distribuição ou venda do aplicativo sem autorização do responsável não é permitida. Vozera é independente e não é um produto oficial da ElevenLabs.

