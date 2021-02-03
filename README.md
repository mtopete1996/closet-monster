# Closet Monster Web App

## Setting up local
```
git clone git@github.com:mtopete1996/closet-monster.git # Clone repo
bundle install # Install gems
yarn install # Install node_modules
bin/rails db:create
```

## Configure heroku
```
heroku login
heroku git:remote -a closet-monster
```
###### NOTE: If you don't have the credentials ask them to an admin

## Restore database
```
heroku pg:backups:capture
heroku pg:backups:download tmp/latest.dump

pg_restore --verbose --clean --no-acl --no-owner -h localhost -u <pg_user> -d closet_monster_dev tmp/latest.dump
```

## Versions
Ruby: 2.7.2  
Rails: 6.0.3.4  
Bundler: 2.1.4  
PosgreSQL: 13.1  
yarn: 1.22.10  
