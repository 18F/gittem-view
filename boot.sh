sudo apt-get update && sudo apt-get install -y php5 git wget
wget https://s3.amazonaws.com/gitlist/gitlist-0.5.0.tar.gz
tar xfz gitlist-0.5.0.tar.gz
mkdir -p gitlist/cache
chmod 777 gitlist/cache
sudo cp /vagrant/config.ini /home/vagrant/gitlist/config.ini
sudo rm -rf /var/www/html
sudo ln -s /home/vagrant/gitlist /var/www/html

mkdir -p responses
sudo chmod 777 responses
cd responses
bash /vagrant/gittem.sh /vagrant/respondents.csv

sudo su

cat > /etc/apache2/conf-available/gitlist.conf  << EOF
<Directory /var/www/>
  Options FollowSymLinks
  AllowOverride All
</Directory>
EOF

a2enconf gitlist
service apache2 reload
a2enmod rewrite
service apache2 restart
