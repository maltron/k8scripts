oc new-project ${1}
oc delete limitrange/$(oc config view --minify --output 'jsonpath={..namespace}')-core-resource-limits
oc adm policy add-scc-to-group privileged system:serviceaccounts:${1}
oc adm policy add-scc-to-group anyuid system:serviceaccounts:${1}
eval "oc patch servicemeshmemberroll/default --type=json --patch '[{\"op\":\"add\",\"path\":\"/spec/members/0\",\"value\":\"$(oc config view --minify --output 'jsonpath={..namespace}')\"}]' --namespace ossm-system"
