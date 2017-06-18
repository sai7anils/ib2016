Ideaburns
================

Ruby on Rails
-------------

This application requires:

- Ruby 2.3.0
- Rails 4.2.5.2

Edit this files to config for yourself:
```
config/database.yml
config/secrets.yml
config/private_pub.yml
```

Getting Started
---------------
 - `bundle install`

 - `rake db:create`

 - `rake db:migration`

 - `rake db:seed`

 - `rake data:sample`

 - Start realtime server :

   `rackup private_pub.ru -s thin -E production`

 - Start rails app:

   `rails s`


Deployment
---------------
Local:
```
rails s
```

Staging:
```
git remote add heroku https://git.heroku.com/ideaburn-goldenowl.git`
git push heroku master
```

Production:
```
cap production deploy
```