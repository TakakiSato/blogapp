#!/bin/sh
rake assets:precompile RAILS_ENV=production
SECRET_KEY_BASE=$(rake secret) rails s -eproduction &
