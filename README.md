# Closet Monster Web App

## Some history
I think every app or every website are created to solve a problem, in this case my closet. I used to take the first t-shirt and jeans that came across and sometimes I used the same t-shirt 3 times a week because I didn't pay attention to what I was using. One time I even used the same t-shirt for the same event 1 year after and I was so embarrased when I saw the pictures.  
 
So I came with a "simple" solution: I'm a developer, so I can make a basic web app to record all my clothes and keep track of when was the last time I used them. And so I started to write down my ideas using trello and making little tasks to organize them. I even came with the name right away: **Closet Monster**. The name came from a movie that I love although it doesn't have anything to do with clothing, but the name perfectly fitted with the problem.  

I had to learn a lot of stuff that I needed, specifically for the production environment. Things like deploying using heroku, configuring a AWS bucket to store the images and more. I had already bought domains before but never configured them to a hosting service like heroku.  
  
After I had the first version where you can create a cloth, brand and type, upload an image and login as an admin or monster user I deployed to production and ever since that December 28th 2020 I have been updating the app with more stuff. Like the table view and pagination.   

-Manuel E. Topete Ortega

### Notion Wiki: https://www.notion.so/Closet-Monster-Project-c283a7f10db7475b981aeb0d7dd29361

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
