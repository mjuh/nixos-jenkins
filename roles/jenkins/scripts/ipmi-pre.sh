#!/bin/sh

modprobe ipmi_devintf ipmi_ssif ipmi_si ipmi_msghandler

echo "To reset a password type:"
echo ipmitool -I open lan set 1 password ADMIN
