logs=/tmp/roboshop.log

echo -e '\e[31m>>>>>>>>>>>>>>> downloading nodejs <<<<<<<<<<<<<<<<<<<<<\e[0m'
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${log}
echo -e '\e[31m>>>>>>>>>>>>>>> installing nodejs <<<<<<<<<<<<<<<<<<<<<\e[0m'
yum install nodejs -y &>> ${log}
echo -e '\e[31m>>>>>>>>>>>>>>> adduser  <<<<<<<<<<<<<<<<<<<<<\e[0m'
useradd roboshop &>> ${log}
echo -e '\e[31m>>>>>>>>>>>>>>> copy service file  <<<<<<<<<<<<<<<<<<<<<\e[0m'
cp catalogue.service  /etc/systemd/system/catalogue.service &>> ${log}
echo -e '\e[31m>>>>>>>>>>>>>>> copy mongo repo  file  <<<<<<<<<<<<<<<<<<<<<\e[0m'
cp mongo.repo /etc/yum.repos.d/mongo.repo &>> ${log}
echo -e '\e[31m>>>>>>>>>>>>>>> remove app if already exist  <<<<<<<<<<<<<<<<<<<<<\e[0m'
rm -rf /app &>> ${log}
echo -e '\e[31m>>>>>>>>>>>>>>> make dir app  <<<<<<<<<<<<<<<<<<<<<\e[0m'
mkdir /app  &>> ${log}
echo -e '\e[31m>>>>>>>>>>>>>>> download  app  <<<<<<<<<<<<<<<<<<<<<\e[0m'
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip  &>> ${log}
cd /app 
echo -e '\e[31m>>>>>>>>>>>>>>> unzip the app <<<<<<<<<<<<<<<<<<<<<\e[0m'
unzip /tmp/catalogue.zip &>> ${log}
echo -e '\e[31m>>>>>>>>>>>>>>> install npm <<<<<<<<<<<<<<<<<<<<<\e[0m'
npm install  &>> ${log}
echo -e '\e[31m>>>>>>>>>>>>>>> reload and start <<<<<<<<<<<<<<<<<<<<<\e[0m'
systemctl daemon-reload
systemctl enable catalogue 
systemctl restart catalogue
echo -e '\e[31m>>>>>>>>>>>>>>> install mongo db <<<<<<<<<<<<<<<<<<<<<\e[0m'
yum install mongodb-org-shell -y &>> ${log}
echo -e '\e[31m>>>>>>>>>>>>>>> copy schema <<<<<<<<<<<<<<<<<<<<<\e[0m'
mongo --host mongo.jdevops.online </app/schema/catalogue.js


