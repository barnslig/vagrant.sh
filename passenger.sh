#!/usr/bin/env bash

can passenger || {
    echo 'Setting up Passenger Standalone...'
    gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
    gpg --armor --export 561F9B9CAC40B2F7 | sudo apt-key add -

    apt_install apt-transport-https

    echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main' > /etc/apt/sources.list.d/passenger.list
    aptitude update >/dev/null || exit 1

    apt_install passenger
}

function on () {
    local port=${1:-3000}
    local directory=${2:-/vagrant}

    install-bundle $directory
    passenger start $directory --port $port --daemonize --user $user
}
