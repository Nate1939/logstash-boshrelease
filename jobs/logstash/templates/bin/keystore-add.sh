#!/bin/bash
set -e

export PATH=$PATH:/var/vcap/packages/logstash/bin
export LOGSTASH_PATH_CONF=/var/vcap/jobs/logstash/config

<% if_p('logstash.secure_settings') do |secure_settings| %>
rm -f "$LOGSTASH_PATH_CONF/logstash.keystore"
( echo y ) | logstash-keystore --path.settings "$LOGSTASH_PATH_CONF" create

echo "== Configure secure settings =="
<% secure_settings.each do |setting| %>
echo "<%= setting['command'] %>: <%= setting['name'] %>"
<% if setting['command'] == 'add' then %>
( echo "<%= setting['value'] %>" ) | logstash-keystore --path.settings "$LOGSTASH_PATH_CONF" add <%= setting['name'] %>
<% end %>
chown vcap:vcap "$LOGSTASH_PATH_CONF/logstash.keystore"
<% end %>
echo "== Secure settings =="
logstash-keystore --path.settings "$LOGSTASH_PATH_CONF" list || true
<% end %>