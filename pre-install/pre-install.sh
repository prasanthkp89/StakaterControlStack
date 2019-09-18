#!/usr/bin/env sh
set -e

if [ ! $# -eq 1 ];
then
    echo "Expecting only one argument. Value should be `true` for dry run and `false` otherwise"
    return 1;
fi;

IS_DRY_RUN=$1
DRY_RUN_FLAG=""

if $IS_DRY_RUN;
then
    DRY_RUN_FLAG="--dry-run"
fi;

echo "Installing tiller service account, and cluster role binding $DRY_RUN_FLAG"
kubectl apply -f tiller.yaml $DRY_RUN_FLAG || true

echo "Initializing helm with service account tiller $DRY_RUN_FLAG"
helm init --service-account tiller $DRY_RUN_FLAG || true

echo "Installing konfigurator CRD $DRY_RUN_FLAG"
kubectl apply -f konfigurator-crd.yaml $DRY_RUN_FLAG || true

echo "Installing Sealed Secret CRD $DRY_RUN_FLAG"
kubectl apply -f sealed-secret-crd.yaml $DRY_RUN_FLAG || true

echo "Installing ElasticSearchCluster CRD $DRY_RUN_FLAG"
kubectl apply -f es-operator-crd.yaml $DRY_RUN_FLAG || true

echo "Installing HelmRelease CRD $DRY_RUN_FLAG"
kubectl apply -f helm-release-crd.yaml $DRY_RUN_FLAG || true

echo "Creating storage-class-ssd $DRY_RUN_FLAG"
kubectl apply -f storage-class-ssd.yaml $DRY_RUN_FLAG || true

echo "Installing AlertManager CRD $DRY_RUN_FLAG"
kubectl apply -f alert-manager-crd.yaml $DRY_RUN_FLAG || true

echo "Installing Prometheus CRD $DRY_RUN_FLAG"
kubectl apply -f prometheus-crd.yaml $DRY_RUN_FLAG || true

echo "Installing Prometheus Rules CRD $DRY_RUN_FLAG"
kubectl apply -f prometheus-rules-crd.yaml $DRY_RUN_FLAG || true

echo "Installing ServiceMonitor CRD $DRY_RUN_FLAG"
kubectl apply -f servicemonitor-crd.yaml $DRY_RUN_FLAG || true

echo "Creating Cluster role binding for dashboard $DRY_RUN_FLAG"
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard $DRY_RUN_FLAG || true