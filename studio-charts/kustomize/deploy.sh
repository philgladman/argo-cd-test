WORKING_DIR=$(pwd)
echo $WORKING_DIR

# deploy argocd
cd $WORKING_DIR/studio-charts/kustomize/argocd
CHART_NAME=$(basename $(pwd))
RELEASE_NAME=$CHART_NAME
helm template --release-name $RELEASE_NAME ../../charts/$CHART_NAME -f values.yaml --inlude-crds --debug > release.yaml
kubectl apply -k .

# deploy app of apps
kubectl apply -f $WORKING_DIR/studio-apps/kustomize/software-studio/software-studio-app.yaml