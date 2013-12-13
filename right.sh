#!/bin/bash
chown -R puppet:puppet /etc/puppet /var/*/puppet && \
find /etc/puppet -type f -exec chmod 0640 {} + && \
find /etc/puppet -type d -exec chmod 2750 {} + && \
chmod 0750 /etc/puppet/{etckeeper-commit-{pre,post},right.sh}
chmod 0755 /etc/puppet/modules/users/files/dotfiles/*/install* /etc/puppet/modules/iptables/files/iptables/iptables-commands
