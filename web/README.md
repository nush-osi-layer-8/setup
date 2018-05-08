
# Web Hacking!

## Some links you can read

* https://github.com/balsn/ctf_writeup/tree/master/20180411-hitbxctfqual#web

## Modifying HTTP Requests

An essential tool for modifying web requests is Burp suite. You can get it [here](https://portswigger.net/burp/communitydownload). I don't use it much because I prefer to manually craft requests using [httpie](https://httpie.org/) or curl. 

## DVWA

A good resource for trying out web hacking is [DVWA](https://github.com/ethicalhack3r/DVWA). Here's how to set it up:

```
sudo apt update
sudo apt install apache2 mysql-server php php-mysqli php-gd libapache2-mod-php unzip
```

Follow the instructions. When prompted for a MySQL root password, enter `p@ssw0rd`. It may not echo the password back to you. 

```
sudo systemctl disable apache2
sudo systemctl disable mysql-server
sudo systemctl restart apache2
sudo systemctl restart mysql-server
```

Once that command completes, check that you can visit [localhost](http://localhost/) from inside the VM. You should be greeted by the default Apache page.

```
cd /var/www
sudo wget https://github.com/ethicalhack3r/DVWA/archive/master.zip
sudo unzip master.zip
sudo mv DVWA-master html/dvwa
cd html/dvwa
sudo cp config/config.inc.php.dist config/config.inc.php
```

Now visit [localhost/dvwa/](http://localhost/dvwa/). It should be working. Next we have to enable some of the "features" of DVWA. 

```
sudo chgrp www-data config hackable/uploads external/phpids/0.6/lib/IDS/tmp/phpids_log.txt
sudo chmod g+w config hackable/uploads external/phpids/0.6/lib/IDS/tmp/phpids_log.txt
sudo sed -i 's/allow_url_include = Off/allow_url_include = On/' /etc/php/7.0/apache2/php.ini
```

If you like, you might want to set up the reCAPTCHA key, but you can ignore it too. Get your key from https://www.google.com/recaptcha/admin

```
RE_PUBLIC_KEY=<YOUR RECAPTCHA PUBLIC KEY>
RE_PRIVATE_KEY=<YOUR RECAPTCHA PRIVATE KEY>

sed "s/'recaptcha_public_key' ]  = ''/'recaptcha_public_key' ]  = '$RE_PUBLIC_KEY'/g" config/config.inc.php
sed "s/'recaptcha_private_key' ]  = ''/'recaptcha_private_key' ]  = '$RE_PRIVATE_KEY'/g" config/config.inc.php
```

Now let's restart Apache and start the MySQL server. 

```
sudo systemctl restart apache2
```

You can now refresh the page, check that most of the features are green, and press the "Create / Reset Database" button. 

You're done! Login with admin / password. 

You'll need to set the security level to something that's not impossible. Let's start with low. Go to [localhost/dvwa/security.php](http://localhost/dvwa/security.php) and set the level. 

Try out some vulnerabilities listed in the sidebar. There's linked resources to give you background for each vulnerability, and a "View Help" to know more on what you are supposed to do. Don't cheat! Try your best first. 

To keep your VM safe, disable Apache when you're done. 

```
sudo systemctl stop apache2
sudo systemctl stop mysql-server
```
