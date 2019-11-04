#!/bin/bash
set -e

function print_error() {
    echo -e "\e[31mERROR: ${1}\e[m"
}

function print_info() {
    echo -e "\e[36mINFO: ${1}\e[m"
}

if [ -z "${RSYNC_HOST}" ]; then
    print_error "not found RSYNC_HOST"
    exit 1
fi

if [ -n "${RSYNC_DEPLOY_KEY}" ]; then

    print_info "setup with RSYNC_DEPLOY_KEY"

    if [ -n "${SCRIPT_MODE}" ]; then
        print_info "run as SCRIPT_MODE"
        SSH_DIR="${HOME}/.ssh"
    else
        SSH_DIR="/root/.ssh"
    fi
    mkdir "${SSH_DIR}"
    ssh-keyscan -t rsa ${RSYNC_HOST} > "${SSH_DIR}/known_hosts"
    echo "${RSYNC_DEPLOY_KEY}" > "${SSH_DIR}/id_rsa"
    chmod 400 "${SSH_DIR}/id_rsa"
fi

if [ -z "${RSYNC_ARG}" ]; then
    print_error "not found RSYNC_ARG"
    exit 1
fi

if [ -z "${PUBLISH_DIR}" ]; then
    print_error "not found PUBLISH_DIR"
    exit 1
fi

if [ -z "${RSYNC_USERNAME}" ]; then
    print_error "not found RSYNC_USERNAME"
    exit 1
fi

if [ -z "${RSYNC_DIST_DIR}" ]; then
    print_error "not found RSYNC_DIST_DIR"
    exit 1
fi

rsync ${RSYNC_ARG} ${GITHUB_WORKSPACE}/${PUBLISH_DIR} ${RSYNC_USERNAME}@${RSYNC_HOST}:${RSYNC_DIST_DIR} && \
print_info "${GITHUB_SHA} was successfully deployed"