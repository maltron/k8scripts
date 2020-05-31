oc new-app mysql-ephemeral -p MYSQL_DATABASE=chapter04 -p MYSQL_ROOT_PASSWORD=maltron -p MYSQL_USER=mauricio -p MYSQL_PASSWORD=maltron
sleep 4
oc wait --for=condition=Ready pod --selector name=mysql
sleep 3
oc cp database.sql $(oc get pods -o jsonpath='{.items[?(@.status.phase=="Running")].metadata.name}'):/opt/app-root/src
oc exec -i $(oc get pods -o jsonpath='{.items[?(@.status.phase=="Running")].metadata.name}') -- mysql -u $(oc get secret/mysql -o jsonpath='{.data.database-user}' | base64 --decode) -p$(oc get secret/mysql -o jsonpath='{.data.database-password}' | base64 --decode)<database.sql
