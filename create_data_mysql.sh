oc delete pod/mysql-1-deploy
oc cp database.sql $(oc get pods -o jsonpath='{.items[?(@.status.phase=="Running")].metadata.name}'):/opt/app-root/src
oc exec -i $(oc get pods -o jsonpath='{.items[?(@.status.phase=="Running")].metadata.name}') -- mysql -u $(oc get secret/mysql -o jsonpath='{.data.database-user}' | base64 --decode) -p$(oc get secret/mysql -o jsonpath='{.data.database-password}' | base64 --decode)<database.sql
