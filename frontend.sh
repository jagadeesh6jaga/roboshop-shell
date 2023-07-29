log=/tmp/roboshop.log

echo -e "\e{36m  >>>>>>>>>>>>> installing nginx <<<<<<<<<<<\e[0m"
yum install nginx -y &>> ${log}

echo -e "\e{36m  >>>>>>>>>>>>> copy roboshop configurations <<<<<<<<<<<\e[0m"
cp nginx_roboshop.conf /etc/nginx/default.d/roboshop.conf &>> ${log}
echo -e "\e{36m  >>>>>>>>>>>>> clean old content <<<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*  &>> ${log}
echo -e "\e{36m  >>>>>>>>>>>>> download application content <<<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>> ${log}

cd /usr/share/nginx/html 
echo -e "\e{36m  >>>>>>>>>>>>> extract application content  <<<<<<<<<<<\e[0m"
unzip /tmp/frontend.zip &>> ${log}
echo -e "\e{36m  >>>>>>>>>>>>> restart nginx service   <<<<<<<<<<<\e[0m"
systemctl enable nginx &>> ${log}
systemctl restart nginx  &>> ${log}