# OSSEC

Las fuentes de ossec y otra documentación, puede encontrarla en:
https://github.com/ossec/ossec-hids

## Scripts para ossec

### Rápida instalación 

#### Server

```
export install="server" ; curl -k https://raw.githubusercontent.com/dorancemc/ossec-local/master/ossec_install.sh | sh -x
```

#### Agent

```
curl -k https://raw.githubusercontent.com/dorancemc/ossec-local/master/ossec_install.sh | sh -x
```

Para un ambiente de pruebas, puede instalar el server web en CentOS/RHEL, con el siguiente comando:
```
yum install ossec-wui -y && sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config && setenforce 0 && firewall-cmd --zone=public --permanent --add-service=http && service firewalld restart && service httpd restart
```
En ambientes de producción, se recomienda realizar una instalación sobre una plataforma de analisis, en el siguiente enlace se explica una integración con kibana [ossec+kibana](http://vichargrave.com/create-an-ossec-log-management-console-with-kibana-4/)


