<p align="center"><img src="assets/vozera-logo.png" alt="Logo do Vozera" width="120"></p>

<h1 align="center">Vozera</h1>
<p align="center"><strong>Seu estúdio de narração no Windows.</strong><br>Transforme seus roteiros em áudio com sua conta ElevenLabs.</p>
<p align="center"><a href="https://github.com/djghuilbox-hub/vozera/releases/download/v0.2.0-beta/Vozera-Instalador.zip"><strong>⬇ Baixar instalador para Windows</strong></a> · <a href="https://github.com/djghuilbox-hub/vozera/releases/tag/v0.2.0-beta">Detalhes da versão beta</a></p>

## O que você pode fazer

- Escolher suas vozes e modelos disponíveis na ElevenLabs e usar tags compatíveis.
- Dividir roteiros longos em partes, ouvir o resultado e salvar cada parte ou o áudio completo.
- Juntar arquivos de áudio, consultar a biblioteca e dar um título às narrações.
- Acompanhar o saldo, uma estimativa de duração e uma estimativa de consumo.

**Versão beta:** confira a narração completa antes de utilizá-la. A geração longa, especialmente no modelo v4 Turbo, ainda precisa de validação adicional. A estimativa de consumo não é uma cobrança confirmada.

## Antes de instalar

Você precisa de Windows, internet e uma conta ElevenLabs com sua própria chave de API. Há acesso inicial gratuito com limitações e opções de pagamento conforme o uso; alguns recursos, limites ou direitos comerciais podem exigir plano pago. Gerar narração consome os créditos da sua conta.

## Instalação passo a passo

1. [Baixe o instalador](https://github.com/djghuilbox-hub/vozera/releases/download/v0.2.0-beta/Vozera-Instalador.zip) e coloque `Vozera-Instalador.zip` na pasta **Downloads**.
2. Abra o menu Iniciar, procure **PowerShell** e abra-o.
3. Copie e cole o comando abaixo no PowerShell e pressione **Enter**:

```powershell
$zip = Join-Path $env:USERPROFILE 'Downloads\Vozera-Instalador.zip'; if (!(Test-Path -LiteralPath $zip)) { throw 'Coloque o ZIP na pasta Downloads e tente novamente.' }; $pasta = Join-Path $env:TEMP ('Vozera-' + [guid]::NewGuid().ToString('N')); Expand-Archive -LiteralPath $zip -DestinationPath $pasta; powershell.exe -STA -NoProfile -ExecutionPolicy Bypass -File (Join-Path $pasta 'Instalar.ps1')
```

4. Pressione **Enter** para instalar em `C:\Vozera` ou digite **2** para escolher outra pasta no Explorador.
5. Acompanhe as etapas e aceite eventuais solicitações de instalação do FFmpeg, necessário para juntar os áudios. Em alguns computadores, pode ser necessário abrir o PowerShell como administrador para criar a pasta em `C:\`.
6. Abra o atalho **Vozera** na Área de Trabalho. As narrações salvas vão para `C:\Vozera\Narrações` ou para a pasta escolhida na instalação.

Você não precisa instalar Git, Python ou Claude. O Claude Code também pode ajudar a executar o instalador no Windows.

## Como criar sua chave da ElevenLabs

1. Entre na sua conta e acesse a [página de chaves de API](https://elevenlabs.io/app/api/api-keys).
2. Crie uma chave e copie o código. Nas permissões, habilite **Text to Speech** e a leitura de **Voices**; para saldo e histórico, habilite também a leitura de **User/Subscription** e **History**, quando disponíveis.
3. No Vozera, cole a chave e clique em **Conectar**. Os nomes das permissões podem mudar; o app oferece um tutorial na própria tela.

A chave é protegida pelo Windows no seu computador. Não compartilhe sua chave com outras pessoas.

## Precisa de ajuda?

Se a instalação do FFmpeg não funcionar, confira as mensagens no terminal e tente novamente. Se o áudio for interrompido, salve as partes já geradas e confira o histórico da ElevenLabs antes de tentar outra geração: a tentativa anterior pode ter consumido créditos. O aplicativo precisa de internet para acessar a ElevenLabs.

O Vozera é uma ferramenta independente e utiliza a API da ElevenLabs. Os arquivos aqui são de distribuição; o código-fonte do aplicativo não está neste repositório público.
