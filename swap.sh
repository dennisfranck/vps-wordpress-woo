#!/bin/sh

# Checa Parametros vazios
if [ ! "$#" -ge 1 ]; then
    echo "Parametros: $0 {size}"
    echo "Exemplo: $0 2G"
    echo "Path opcional: Parametros: $0 {size} {path}"
    exit 1
fi


# Mensagens
echo "=================================================================="
echo "Bem Vindo ao Script de Criacao de SWAP - EdisonCosta"
echo "Este script de instalacao cria automaticamente um arquivo de swap."
echo "=================================================================="
echo ""

# Setup variaveis
SWAP_SIZE=$1
SWAP_PATH="/swapfile"
if [ ! -z "$2" ]; then
    SWAP_PATH=$2
fi


# Inicia script
fallocate -l $SWAP_SIZE $SWAP_PATH
chmod 600 $SWAP_PATH
mkswap $SWAP_PATH
swapon $SWAP_PATH
echo "$SWAP_PATH   none    swap    sw    0   0" | tee /etc/fstab -a
sysctl vm.swappiness=10
echo "vm.swappiness=10" | tee /etc/sysctl.conf -a
sysctl vm.vfs_cache_pressure=50
echo "vm.vfs_cache_pressure=50" | tee /etc/sysctl.conf -a


# Finalizado
echo ""
echo "=============================================================="
echo "Finalizado! Para aplicar as alteracoes reinicie o Servidor:"
echo "$ reboot now"
echo "=============================================================="
echo ""
