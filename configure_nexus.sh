#!/bin/bash

file="/nexus-data/admin.password"

while [ ! -f "$file" ]
do
    echo "admin.password doesn't exist yet"
    sleep 10s
done
echo "admin.password exist! Let's wait for nexus webservice"

sed -i "s|/service/siesta/rest/v1/script/|/service/rest/v1/script/|g" /tmp/change_password_script/change_admin_password.sh

source /tmp/change_password_script/change_admin_password.sh 

CHANGE_ADMIN_PASSWORD_STATUS="" ;
while [[ ${CHANGE_ADMIN_PASSWORD_STATUS} != *"succeeded!" ]]
do
    sleep 10s

    echo "webservice not running yet"
    CHANGE_ADMIN_PASSWORD_STATUS=`change_admin_password localhost:8081 $(cat /nexus-data/admin.password) admin123 -k`
done
echo "webservice is running!"

cd /tmp/nexus-scripting-examples-master/simple-shell-example/

sh setAnonymous.sh true
sh create.sh npm.json
sh run.sh npm

#npm config set registry http://localhost:8081/repository/npmjs-org/ 

#cd /tmp
#cd my-nexus-project
#mvn install -Dvaadin.version=14.0.4 -Pproduction -DskipTests
