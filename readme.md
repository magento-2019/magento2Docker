Build
`docker build -t magento-php7 .`

Run
`docker run -p 88:80 -v /home/sahnouski/PhpstormProjects/magentoDocker/myDocker/dockerFiles/magento2:/var/www -v /var/log/magentoPhp7:/var/log/magento -ti --entrypoint=/bin/bash magento-php7`