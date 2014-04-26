#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y git
sudo apt-get install -y curl

curl -L https://get.rvm.io | bash -s stable

source /usr/local/rvm/scripts/rvm
rvm requirements

rvm install ruby-2.1.0
rvm use --default ruby-2.1.0
# rubygems is included since ruby 1.9
# rvm rubygems current

gem install bundler

cd /vagrant

sudo apt-get install -y postgresql postgresql-client libpq-dev
sudo sed -i 's/local[ ]*all[ ]*postgres[ ]*peer/local all postgres peer map=basic/' /etc/postgresql/9.1/main/pg_hba.conf || { error "apply peer fix part 1"; return 1; }
sudo sed -i "$ a\basic $USER postgres" /etc/postgresql/9.1/main/pg_ident.conf || { error "apply peer fix part 2"; return 1; }
# Restart postgresql to apply changes
sudo /etc/init.d/postgresql restart

sudo apt-get install -y libqtwebkit-dev

bundle install
