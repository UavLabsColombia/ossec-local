# OSSEC

Las fuentes de ossec y otra documentación, puede encontrarla en:
https://github.com/ossec/ossec-hids

## Scripts para ossec

### Rápida instalación 

```
curl -k https://raw.githubusercontent.com/dorancemc/ossec-local/master/ossec_install.sh | sh -x
```

Para instalar el server web en CentOS/RHEL.  
Este ambiente gráfico es sólo para temas demostrativos.   
En producción, Se recomienda realizar una instalación sobre una plataforma de analisis, en el siguiente enlace se explica una integración con kibana [ossec+kibana](http://vichargrave.com/create-an-ossec-log-management-console-with-kibana-4/)
```
yum install ossec-wui && cd /usr/share/ossec-wui/ && ./setup.sh && chmod 770 tmp/ && chgrp apache tmp/ && sed -i "s/AllowOverride AuthConfig/AllowOverride AuthConfig Limit/g" /etc/httpd/conf.d/ossec.conf && service httpd restart
```


