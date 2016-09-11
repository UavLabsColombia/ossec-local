# OSSEC

Las fuentes de ossec y otra documentación, puede encontrarla en:
https://github.com/ossec/ossec-hids

## Scripts para ossec

### Rápida instalación 

```
curl -k https://raw.githubusercontent.com/dorancemc/ossec-local/master/ossec_install.sh | sh -x
```

### Para instalar el server web en CentOS/RHEL
```
yum install ossec-wui && cd /usr/share/ossec-wui/ && ./setup.sh && chmod 770 tmp/ && chgrp apache tmp/ && sed -i "s/AllowOverride AuthConfig/AllowOverride AuthConfig Limit/g" /etc/httpd/conf.d/ossec.conf && service httpd restart
```


