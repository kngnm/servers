docker:
  containers:
    sympa:
      image: cloyne/sympa
      network_mode:
        name: server2.cloyne.org
      environment:
        VIRTUAL_HOST: cloyne.org
        VIRTUAL_ALIAS: /lists,/lists-static/
        SET_REAL_IP_FROM: 172.19.0.0/16
        REMOTES: mail
      volumes:
        /srv/sympa/etc/shared:
          bind: /etc/sympa/shared
        /srv/var/log/sympa:
          bind: /var/log/sympa
        /srv/sympa/data:
          bind: /var/lib/sympa
        /srv/sympa/nullmailer:
          bind: /var/spool/nullmailer
        /srv/sympa/spool:
          bind: /var/spool/sympa
        /srv/sympa/etc/includes:
          bind: /etc/sympa/includes
      dependencies:
        - mail
        - pgsql