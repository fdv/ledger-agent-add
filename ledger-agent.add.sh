#!/bin/bash
LEDGER_BIN=$(which ledger-agent)
LEDGER_HOST="${1}"
LEDGER_CONF="${HOME}/.ssh/ledger.conf"
EXIT_SUCCESS=0
EXIT_ERROR=1

if [ -z "${LEDGER_HOST}" ]; then
  echo "Usage: ${0} user@host"
  echo exiting
  exit ${EXIT_ERROR}
fi

if [ -z "${LEDGER_BIN}" ]; then
  echo "The Ledger Agent binary is missing or not in the path, exiting"
  exit ${EXIT_ERROR}
fi

echo "Generating the private key, please confirm on the Nano S..."
key=$(ledger-agent ${LEDGER_HOST})
echo "${key}" | cut -f 3 -d ' ' >> ${LEDGER_CONF}

echo "Adding ${LEDGER_HOST} to your ssh config"
ssh_host=$(echo ${LEDGER_HOST} | cut -f 2 -d '@')
ssh_user=$(echo ${LEDGER_HOST} | cut -f 1 -d '@')

echo "Host ${ssh_host}
    HostName ${ssh_host}
    Port 22
    User ${ssh_user}
    PreferredAuthentications publickey
" >> ${HOME}/.ssh/config

echo "Your new public key is now into your clipboard!"
echo "${key}" | cut -f 1,2 -d ' ' | pbcopy

echo "Now reloading the Ledger agent"
${LEDGER_BIN} ${LEDGER_CONF} -v -s

exit ${EXIT_SUCCESS}
