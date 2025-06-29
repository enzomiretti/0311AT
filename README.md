# 🚀 Despliegue automático de sitio web en Kubernetes con Minikube

Este proyecto permite desplegar automáticamente un sitio web estático en un clúster local de Kubernetes utilizando Minikube, Docker y un script en Bash.

---

## 📁 Estructura del proyecto

```
0311AT/
├── deploy.sh                  # Script de despliegue automático
├── K8S_Cloud_Computing/       # Repositorio con manifiestos de Kubernetes
└── static-website/            # Repositorio con el sitio web estático
```

---

## 🔧 Requisitos previos

Antes de comenzar, asegurate de tener instalados:

- **Git**
- **Docker Desktop** (y que esté **ejecutándose**)
- **Minikube**
- **Kubectl**
- Recomendado: **Git Bash** en Windows (no usar CMD o PowerShell)

---

## ▶️ Cómo usar este proyecto

1. Cloná este repositorio:

```bash
git clone https://github.com/enzomiretti/0311AT.git
cd 0311AT
```

---

2. Ejecutá el script de despliegue:

```bash
./deploy.sh
```

---

✅ ¡Listo! Tu sitio web está corriendo en Kubernetes con Minikube.

---
