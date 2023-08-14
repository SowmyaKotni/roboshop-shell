echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Create Catalogue Service    <<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/test
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log
echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Create MongoDB Service    <<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/test
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
echo -e "\e[36m>>>>>>>>>>>>>>>>> Install NodeJS Repos    <<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/test
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Install NodeJS    <<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/test
yum install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Create Application User    <<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/test
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Create Application Directory    <<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/test
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Download Application Content    <<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/test
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Extract Application Content    <<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/test
cd /app
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Download NodeJS Dependencies    <<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/test
npm install &>>/tmp/roboshop.log
echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Install Mongo Client    <<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/test
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Load Catalogue Schema    <<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/test
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js &>>/tmp/roboshop.log
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log

