#!/bin/bash
# Vozera: instala a versão mais recente publicada para macOS.
set -euo pipefail

if [[ "$(uname -s)" != Darwin ]]; then
  echo 'Este instalador funciona somente no macOS.' >&2
  exit 1
fi
if ! ( : < /dev/tty ) 2>/dev/null; then
  echo 'Abra o Terminal do Mac e execute o comando novamente para responder às perguntas do instalador.' >&2
  exit 1
fi

arquitetura="$(uname -m)"
if [[ "$(/usr/sbin/sysctl -n hw.optional.arm64 2>/dev/null || true)" == 1 || "$arquitetura" == arm64 ]]; then
  nome='Vozera-macOS-Apple-Silicon.zip'
elif [[ "$arquitetura" == x86_64 ]]; then
  nome='Vozera-macOS-Intel.zip'
else
  echo 'Este processador não é reconhecido pelo instalador.' >&2
  exit 1
fi

pasta="$(mktemp -d "${TMPDIR:-/tmp}/vozera-instalador.XXXXXXXX")"
# A pasta temporária permanece disponível se o instalador apresentar erro.
url_api='https://api.github.com/repos/djghuilbox-hub/vozera/releases?per_page=100'
echo 'Consultando as versões do Vozera...'
if ! /usr/bin/curl -fsSL --proto '=https' --proto-redir '=https' --max-time 40 \
  -H 'Accept: application/vnd.github+json' -H 'User-Agent: Vozera-Instalador' \
  "$url_api" -o "$pasta/releases.json"; then
  echo 'Não foi possível consultar as versões no GitHub. Confira a conexão e tente novamente.' >&2
  exit 1
fi

# JavaScript for Automation e Foundation já fazem parte do macOS; não exige Python, Node ou jq.
if ! info="$(/usr/bin/osascript -l JavaScript - "$pasta/releases.json" "$nome" <<'JXA'
ObjC.import('Foundation');
function run(argv) {
  var raw = $.NSString.stringWithContentsOfFileEncodingError($(argv[0]), $.NSUTF8StringEncoding, null);
  if (!raw) throw new Error('Não foi possível ler a lista de versões.');
  var releases = JSON.parse(ObjC.unwrap(raw));
  if (!Array.isArray(releases)) throw new Error('Lista de versões inválida.');
  var names = ['Vozera-macOS-Apple-Silicon.zip', 'Vozera-macOS-Intel.zip'];
  var rows = [];
  releases.forEach(function (release) {
    if (release.draft || !Array.isArray(release.assets)) return;
    var match = /^v(\d{1,9})\.(\d{1,9})\.(\d{1,9})(-beta)?$/.exec(String(release.tag_name || ''));
    if (!match) return;
    var hasBoth = names.every(function(name) { return release.assets.some(function(a) { return a.name === name && a.state === 'uploaded'; }); });
    if (!hasBoth) return;
    var selected = release.assets.filter(function(a) { return a.name === argv[1] && a.state === 'uploaded'; });
    if (selected.length !== 1) return;
    var asset = selected[0];
    var expected = 'https://github.com/djghuilbox-hub/vozera/releases/download/' + release.tag_name + '/' + argv[1];
    if (asset.browser_download_url !== expected || !/^sha256:[a-f0-9]{64}$/.test(String(asset.digest || ''))) return;
    rows.push({ tag: release.tag_name, hash: asset.digest.substring(7), url: expected,
      version: [Number(match[1]), Number(match[2]), Number(match[3])], stable: !match[4] });
  });
  rows.sort(function(a, b) {
    for (var i = 0; i < 3; i++) if (a.version[i] !== b.version[i]) return b.version[i] - a.version[i];
    return Number(b.stable) - Number(a.stable);
  });
  if (!rows.length) throw new Error('Nenhuma versão de Mac com instaladores verificáveis foi encontrada.');
  return rows[0].tag + '|' + rows[0].hash + '|' + rows[0].url;
}
JXA
)"; then
  echo 'Não foi possível identificar uma versão válida para o Mac.' >&2
  exit 1
fi
IFS='|' read -r versao hash url <<< "$info"
if [[ ! "$versao" =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-beta)?$ || ! "$hash" =~ ^[a-f0-9]{64}$ || "$url" != "https://github.com/djghuilbox-hub/vozera/releases/download/$versao/$nome" ]]; then
  echo 'Os dados da versão recebida são inválidos.' >&2
  exit 1
fi

echo "Baixando $versao para $nome..."
if ! /usr/bin/curl -fL --proto '=https' --proto-redir '=https' --connect-timeout 30 --max-time 600 \
  "$url" -o "$pasta/vozera.zip"; then
  echo 'Não foi possível baixar o instalador.' >&2
  exit 1
fi
if [[ "$(/usr/bin/shasum -a 256 "$pasta/vozera.zip" | /usr/bin/awk '{print $1}')" != "$hash" ]]; then
  echo 'A verificação do instalador falhou. Nada foi instalado.' >&2
  exit 1
fi
echo 'Arquivo conferido. Preparando a instalação...'
/usr/bin/ditto -x -k "$pasta/vozera.zip" "$pasta"
instalador="$pasta/pacote/Instalar Vozera.command"
if [[ ! -f "$instalador" || ! -d "$pasta/pacote/Vozera.app" ]]; then
  echo 'O pacote não contém o aplicativo e o instalador esperados.' >&2
  exit 1
fi
# Com pipe, a entrada padrão contém o script; as perguntas devem ler do Terminal.
/bin/bash "$instalador" < /dev/tty
