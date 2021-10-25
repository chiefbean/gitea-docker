FROM alpine:edge

EXPOSE 3000
EXPOSE 22

# install deps
RUN apk --update add git sqlite sudo openvpn wget

# setup sudo user
RUN addgroup -g 1000 git && adduser \
        -S \
        -s /bin/bash \
        -g 'Git Version Control' \
        -D \
        -G git \
        -h /home/git \
        git \
        && echo "git ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/git \
        && chmod 0440 /etc/sudoers.d/git

RUN wget -O /tmp/gitea https://dl.gitea.io/gitea/1.14.6/gitea-1.14.6-linux-amd64 \
        && mv /tmp/gitea /usr/local/bin \
        && chmod +x /usr/local/bin/gitea \
        && mkdir -p /var/lib/gitea/{custom,data,log} \
        && chown -R git:git /var/lib/gitea/ \
        && chmod -R 750 /var/lib/gitea/ \
        && mkdir /etc/gitea \
        && chown root:git /etc/gitea \
        && chmod 770 /etc/gitea


ENV USER git
ENV GITEA_CUSTOM /data/gitea

VOLUME ["/data"]

# copy files over
COPY BEAN-GIT.ovpn /home/git/BEAN-GIT.ovpn
COPY init.sh /home/git/init.sh

CMD ["/bin/sh", "/home/git/init.sh"]