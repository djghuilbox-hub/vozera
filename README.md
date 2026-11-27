<p align="center"><img src="assets/vozera-logo.png" alt="Logo do Vozera" width="120"></p>

<h1 align="center">Vozera</h1>
<p align="center"><strong>Seu estúdio de narração no Windows e no Mac.</strong><br>Transforme seus roteiros em áudio com sua conta ElevenLabs.</p>
<p align="center"><a href="#instalação-no-windows"><strong>Instalar ou atualizar no Windows</strong></a> · <a href="#instalação-no-mac"><strong>Instalar no Mac</strong></a> · <a href="#como-criar-sua-chave-da-elevenlabs"><strong>Configurar a ElevenLabs</strong></a></p>

> **Já tem o Vozera?** Feche o aplicativo e seu terminal antes de atualizar. Depois, execute o mesmo comando e escolha o local da instalação anterior.

## Instalação no Windows

1. Abra o menu Iniciar, procure **PowerShell** e abra-o.
2. Copie e cole o comando abaixo e pressione **Enter**:

```powershell
irm https://raw.githubusercontent.com/djghuilbox-hub/vozera/main/atualizar.ps1 | iex
```

3. Aguarde o download e a verificação do instalador. Em seguida, pressione **Enter** para instalar em `C:\Vozera` ou digite **2** para escolher outro local no Explorador.
4. Acompanhe as etapas e aceite eventuais solicitações de instalação do FFmpeg, necessário para juntar os áudios. Em alguns computadores, pode ser necessário abrir o PowerShell como administrador para criar a pasta em `C:\`.
5. Abra o atalho **Vozera** na Área de Trabalho. As narrações ficam em `C:\Vozera\Narrações` ou no local escolhido.

O comando baixa a versão mais recente disponível, inclusive versões beta, e verifica a integridade do arquivo antes de iniciar o instalador. Ele executa o script público deste repositório: use-o somente se confiar na origem. Você não precisa instalar Git, Python ou Claude.

## O que você pode fazer

- Escolher suas vozes e modelos disponíveis na ElevenLabs e usar tags compatíveis.
- Dividir roteiros longos em partes, ouvir o resultado e salvar cada parte ou o áudio completo.
- Juntar arquivos de áudio, consultar a biblioteca e dar um título às narrações.
- Acompanhar o saldo, uma estimativa de duração e uma estimativa de consumo.
- Usar o tutorial guiado e consultar o guia de tags sempre que precisar.
- Navegar pelas seções e consultar o histórico local por canal, voz e modelo.
- Criar canais locais e salvar configurações de voz e modelo para reutilizar.
- Conferir o roteiro antes de gerar, receber alertas de repetição e acompanhar o progresso.
- Configurar a ElevenLabs em Configurações → Plugins e diagnosticar problemas pelo botão Verificar.
- Consultar automaticamente novas versões e visualizar as novidades no aplicativo.

**Versão beta:** confira a narração completa antes de utilizá-la. A geração longa, especialmente no modelo v4 Turbo, ainda precisa de validação adicional. A estimativa de consumo não é uma cobrança confirmada.

## Antes de instalar

Você precisa de Windows ou macOS, internet e uma conta ElevenLabs com sua própria chave de API. Há acesso inicial gratuito com limitações e opções de pagamento conforme o uso; alguns recursos, limites ou direitos comerciais podem exigir plano pago. Gerar narração consome os créditos da sua conta.

## Instalação no Mac

1. No menu Apple, clique em **Sobre Este Mac** e confira o processador. Se aparecer Apple M1, M2, M3 ou outro chip Apple, baixe a versão [Mac Apple Silicon](https://github.com/djghuilbox-hub/vozera/releases/download/v0.6.0-beta/Vozera-macOS-Apple-Silicon.zip); se aparecer Intel, baixe a versão [Mac Intel](https://github.com/djghuilbox-hub/vozera/releases/download/v0.6.0-beta/Vozera-macOS-Intel.zip).
2. Extraia o ZIP baixado, abra a pasta extraída e execute **Instalar Vozera.command**. Siga as orientações no terminal e escolha onde criar a pasta Vozera. O padrão é `~/Vozera`.
3. O FFmpeg é necessário para juntar áudios. Se ele não estiver instalado, o instalador usará o Homebrew. Se o Homebrew também não estiver instalado, acesse [brew.sh](https://brew.sh/), conclua a instalação e execute o instalador do Vozera novamente.
4. Abra o atalho **Vozera** na Mesa ou o arquivo `Vozera.app` na pasta `Vozera/App`. Os áudios salvos ficam em `Vozera/Narrações`.

O aplicativo para Mac **não possui assinatura de desenvolvedor nem notarização da Apple**. O macOS pode bloquear sua abertura: confira o aviso em **Ajustes do Sistema → Privacidade e Segurança** e, se confiar no arquivo, use a opção oferecida pelo sistema para abri-lo. As duas arquiteturas foram compiladas e testadas automaticamente no macOS 15; a instalação e o uso ainda precisam ser conferidos em Macs reais.

## Tutorial e tags

Ao abrir o aplicativo pela primeira vez, aparece um tutorial em seis passos. Você pode avançar, voltar ou pular. Para ver novamente, clique em **Ver tutorial**. A seção **Ajuda e tags** fica disponível no aplicativo para consulta.

Tags são orientações entre colchetes, colocadas antes do trecho da narração. Por exemplo: `[curious] Como essa história começou?` ou `[whispers] Ninguém sabia do segredo.` Elas funcionam nos modelos Eleven v4, v4 Turbo e v3, mas a interpretação depende da voz e do contexto.

No app, há exemplos e um pedido pronto para copiar e usar no Claude, Codex ou Gemini: a sugestão pede a inserção de tags sem reescrever o roteiro. Revise o texto antes de gerar; o uso de ferramentas externas é opcional.

## Atualizar uma instalação existente

No Windows, feche o Vozera e seu terminal e siga o mesmo comando da seção [Instalação no Windows](#instalação-no-windows). Escolha o mesmo local da instalação anterior: para o padrão `C:\Vozera`, pressione **Enter**; se escolheu outro local, digite **2** e selecione a pasta que contém a pasta Vozera.

No Mac, siga o [guia de atualização](https://github.com/djghuilbox-hub/vozera/releases/tag/v0.6.0-beta) para baixar e instalar a versão correta.

A chave e a biblioteca continuam salvas no computador. A atualização ainda não é instalada automaticamente pelo botão dentro do app.

## Como criar sua chave da ElevenLabs

1. Entre na sua conta e acesse a [página de chaves de API](https://elevenlabs.io/app/api/api-keys).
2. Crie uma chave e copie o código. Nas permissões, habilite **Text to Speech** e a leitura de **Voices**; para saldo e histórico, habilite também a leitura de **User/Subscription** e **History**, quando disponíveis.
3. No Vozera, abra **Configurações → Plugins → ElevenLabs**, cole a chave e clique em **Conectar**. Os nomes das permissões podem mudar; o app oferece um tutorial na própria tela.

A chave é protegida pelo Windows ou armazenada no Acesso às Chaves do macOS. Não compartilhe sua chave com outras pessoas.

## Precisa de ajuda?

Se a instalação do FFmpeg não funcionar, confira as mensagens no terminal e tente novamente. Se o áudio for interrompido, salve as partes já geradas e confira o histórico da ElevenLabs antes de tentar outra geração: a tentativa anterior pode ter consumido créditos. O aplicativo precisa de internet para acessar a ElevenLabs.

O Vozera é uma ferramenta independente e utiliza a API da ElevenLabs. Os arquivos aqui são de distribuição; o código-fonte do aplicativo não está neste repositório público.
