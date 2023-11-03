#!/bin/bash


echo "pr running deploy"

#cd $APP_PATH
#pwd

#helm upgrade $HELM_NAME . --install --create-namespace --version=$RELEASE --set architecture=$ARCHITECTURE --set auth.enabled=$AUTH_ENABLED --set persistence.storageClass=$STORAGECLASS --set global.imageRegistry=$DEPLOY_IMAGE_REGISTRY --namespace=$PREVIEW_NAMESPACE --kubeconfig $DEV_CLUSTER

#Following required only if running for NEBU project
#kubectl get service/$HELM_NAME-mongodb-headless -n $PREVIEW_NAMESPACE --kubeconfig $DEV_CLUSTER >/dev/null 2>&1
#if [ $? -ne 0 ];
#then
#	kubectl expose service/$HELM_NAME-mongodb-headless --name=$HELM_NAME -n $PREVIEW_NAMESPACE --kubeconfig $DEV_CLUSTER
#fi
