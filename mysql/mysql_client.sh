oc exec -i -t $(oc get pods -o jsonpath='{.items[?(@.metadata.labels.name=="mysql")].metadata.name}') -- mysql -u $(oc get secret/mysql -o jsonpath='{.data.database-user}' | base64 --decode) -p$(oc get secret/mysql -o jsonpath='{.data.database-password}' | base64 --decode) $(oc get secret/mysql -o jsonpath='{.data.database-name}' | base64 --decode)
