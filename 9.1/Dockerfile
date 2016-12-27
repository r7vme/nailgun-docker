FROM centos:7
MAINTAINER Roman Sokolkov <rsokolkov@mirantis.com>

# Configure MOS repos
COPY mos.repo /etc/yum.repos.d/
RUN echo '9.0' > /etc/yum/vars/fuelver

# Install packages
RUN yum -y install supervisor \
                   postgresql-server \
                   fuel-nailgun \
                   python-fuelclient

# Disable Keystone auth
RUN sed -i 's/AUTHENTICATION_METHOD:.*/AUTHENTICATION_METHOD:\ \"none\"/' \
            /etc/nailgun/settings.yaml

# Supervisor configuration
COPY postgresql.ini /etc/supervisord.d/
COPY nailgun.ini /etc/supervisord.d/

COPY start.sh .

# Expose nailgun port
EXPOSE 8000

CMD ["./start.sh"]
