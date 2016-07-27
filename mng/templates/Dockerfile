FROM malex984/dockapp:omd_agent

#### Enabling SSH
# Baseimage-docker disables the SSH server by default. Add the following to your Dockerfile to enable it:

RUN sed -i 's@#Port .*@Port 20@' /etc/ssh/sshd_config
EXPOSE 20

RUN rm -f /etc/service/sshd/down

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh


## Install an SSH of your choice.
COPY ./id_rsa.pub /root/.ssh/authorized_keys
#ADD id_rsa.pub /tmp/tmp_key.pub
#RUN cat /tmp/tmp_key.pub >> /root/.ssh/authorized_keys && rm -f /tmp/tmp_key.pub

#    docker inspect -f "{{ .NetworkSettings.IPAddress }}" <ID>
# Now that you have the IP address, you can use SSH to login to the container, or to execute a command inside it:
#    # Login to the container
#    ssh -i /path-to/your_key root@<IP address>

### ==>>> PORT=20 USER=root + id_rsa

## TODO: note the symbolic links!
COPY . /DOCKAPP
