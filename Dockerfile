FROM debian:stretch

LABEL maintainer="Rob Pickering <rob@aplisay.uk>"
RUN apt-get update && apt-get install -y openssh-server python3
RUN mkdir /var/run/sshd
RUN mkdir /root/.ssh
RUN echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEez66Xl3rJYqgZHcmn27chkSny3IsFZBHfH3xV1p/fB rob@Robs-MacBook-Pro.local' >/root/.ssh/authorized_keys
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 5061/tcp 443/tcp 80/tcp 22/tcp

COPY entrypoint.sh /
CMD ["/usr/sbin/sshd", "-D"]
