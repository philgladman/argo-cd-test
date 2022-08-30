set-local

WORKING_DIR=$(pwd)
echo $WORKING_DIR


echo $GH_CSN_PAT > ./pat.txt
sleep 2
kubectl create secret generic argocd-csn-repo-secret --from-file ./pat.txt

# deploy argocd
cd $WORKING_DIR/studio-charts/kustomize/argocd
CHART_NAME=$(basename $(pwd))
RELEASE_NAME=$CHART_NAME
helm template --release-name $RELEASE_NAME ../../charts/$CHART_NAME -f values.yaml --include-crds --debug > release.yaml
kubectl apply -k .

# deploy app of apps
kubectl apply -f $WORKING_DIR/studio-apps/kustomize/software-studio/software-studio-app.yaml