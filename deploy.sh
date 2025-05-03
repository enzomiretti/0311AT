#!/bin/bash

# ==============================================
# 📌 CONFIGURACIÓN
# ==============================================
STATIC_SITE_PATH="C:/Users/Dell/0311AT/static-website"
REPO_MANIFIESTOS="https://github.com/enzomiretti/K8S_Cloud_Computing.git"
REPO_STATIC="https://github.com/enzomiretti/static-website.git"
MAIN_DIR="$HOME/0311AT"
MANIFESTS_DIR="$MAIN_DIR/K8S_Cloud_Computing"
STATIC_DIR="$MAIN_DIR/static-website"

# ==============================================
# ✅ VALIDACIÓN DE DEPENDENCIAS
# ==============================================
echo "🔍 Verificando dependencias..."

for cmd in git minikube kubectl; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "❌ Error: '$cmd' no está instalado. Abortando."
        exit 1
    fi
done

# ==============================================
# 🧼 LIMPIEZA DE CLUSTER (evita errores de montaje)
# ==============================================
echo "🧨 Eliminando cluster Minikube previo (si existe)..."
minikube delete &> /dev/null

# ==============================================
# 📁 CREACIÓN DE CARPETAS Y CLONADO
# ==============================================
echo "📁 Preparando estructura de carpetas en $MAIN_DIR..."
mkdir -p "$MAIN_DIR"
cd "$MAIN_DIR" || exit 1

if [ ! -d "$MANIFESTS_DIR" ]; then
    echo "📥 Clonando manifiestos..."
    git clone "$REPO_MANIFIESTOS"
fi

if [ ! -d "$STATIC_DIR" ]; then
    echo "📥 Clonando sitio web estático..."
    git clone "$REPO_STATIC"
fi

# ==============================================
# 🚀 INICIAR MINIKUBE CON MOUNT
# ==============================================
echo "🚀 Iniciando Minikube con volumen montado..."
minikube start --driver=docker --mount --mount-string="${STATIC_SITE_PATH}:/mnt/web"
if [ $? -ne 0 ]; then
    echo "❌ Fallo al iniciar Minikube. Abortando."
    exit 1
fi

# ==============================================
# 📄 APLICAR MANIFIESTOS
# ==============================================
echo "📄 Aplicando manifiestos de Kubernetes..."

cd "$MANIFESTS_DIR" || exit 1

for dir in pv pvc deployments services; do
    if [ -d "$dir" ]; then
        kubectl apply -f "$dir"
    fi
done

# ==============================================
# ⏳ ESPERAR POD EN EJECUCIÓN
# ==============================================
echo "⏳ Esperando a que el pod esté en ejecución..."
until kubectl get pods | grep static-site | grep Running &> /dev/null; do
    echo "⌛ Esperando..."
    sleep 2
done

# ==============================================
# 🌐 ABRIR SERVICIO EN EL NAVEGADOR
# ==============================================
echo "🌐 Abriendo sitio web en el navegador..."
minikube service static-site-service

echo "✅ Despliegue completo."
