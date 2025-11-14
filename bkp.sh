#!/bin/sh

# ===== IDENTIFICAÇÃO DO SERVIDOR =====
SERVIDOR=$(hostname)

# ===== CONFIGURAÇÕES =====
ORIGEM="/var/log"
DESTINO="$HOME/backup_logs/$SERVIDOR"
EXTENSAO="log"

# ===== INÍCIO =====
echo "============================================"
echo " FERRAMENTA DE EXTRAÇÃO DE LOGS - Servidor: $SERVIDOR"
echo "============================================"
echo ""

# ===== CRIA PASTA DE DESTINO =====
mkdir -p "$DESTINO"

echo "[SERVIDOR: $SERVIDOR] Extraindo arquivos *.$EXTENSAO..."
cp "$ORIGEM"/*.$EXTENSAO "$DESTINO" 2>/dev/null

# ===== VERIFICAÇÃO =====
if [ $? -ne 0 ]; then
    echo "[SERVIDOR: $SERVIDOR] Nenhum arquivo *.$EXTENSAO encontrado em $ORIGEM."
else
    echo "[SERVIDOR: $SERVIDOR] Logs copiados para $DESTINO"
fi

# ===== COMPACTAÇÃO =====
ARQUIVO_TGZ="$HOME/logs_${SERVIDOR}_$(date +%Y%m%d_%H%M).tar.gz"

echo "[SERVIDOR: $SERVIDOR] Compactando logs..."
tar -czf "$ARQUIVO_TGZ" -C "$DESTINO" .

echo "[SERVIDOR: $SERVIDOR] Arquivo criado: $ARQUIVO_TGZ"
echo ""
echo "===== PROCESSO CONCLUÍDO PARA O SERVIDOR: $SERVIDOR ====="
