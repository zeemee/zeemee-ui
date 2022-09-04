# Setup

[Install Docker https://docs.docker.com/desktop/install/mac-install/](https://docs.docker.com/desktop/install/mac-install/)

```
mkdir -p ~/dev/zm
cd ~/dev/zm
git clone https://github.com/zeemee/zeemee-ui
cd zeemee-ui

cp .env.example .env
docker compose build
docker compose run --rm web bin/rails db:setup
docker compose up
```

Open [http://localhost:3001](http://localhost:3001)

All code assumes you're running the main ZeeMee project on `localhost:3000` right now

## Console

```
docker-compose exec web rails console
```

## Debugging

Rails 7 using `binding.break` but it's a bit involved in Docker

1. `docker compose up`
2. open another terminal window
3. find container id with `docker container ls` and get the id for `zeemee-ui`
4. then attach: `docker attach {id}`
5. then you can hit `binding.break`

Note: You can do this in the same window with detached: `docker compose up -d` ... then - when you want to kill the server `docket compose down`

# ENV/Configuration

Rails > 4 introduced an encrypted config file. To use this you need `config/master.key` ... you can just create this file and and copy/paste the value from `Heroku -> Settings -> Config Vars -> RAILS_MASTER_KEY` 

# Bash helpers

Put this in your `~/.zshrc` (or whatever you're using) then do a `source ~/.zshrc` to reload

```
# DOCKER
# attaches to current docker web for console debugging
ddebug() {
  docker attach $(docker container ls | grep 'zeemee-ui_web' | grep -Eo '^[^ ]+')
}
# edit credentials.yml file
# TODO: there's got to be a faster way to do this
dcred() {
  docker run --rm -it --mount type=bind,src=${PWD},target=/usr/src/app \
  zeemee-ui_web /bin/sh -c \
  'apt update && apt install -y vim && EDITOR=vim bin/rails credentials:edit'
}
# bash shell for checking local file system, etc
dcbash() {
  docker exec -it $(docker container ls | grep 'zeemee-ui_web' | grep -Eo '^[^ ]+') /bin/bash
}
# rails base
alias drails='docker-compose exec web rails'
# rails c
alias dcon='drails console'
# rails s
alias dup='docker-compose up'
# rebuild container
alias dbuild='docker compose build'
# deploy
alias zui-stg-deploy=git push heroku master -a zui-stg
alias zui-prod-deploy=git push heroku master -a zui-prod
```

## Deploy

Setup:

```
heroku git:remote -a zui-stg
heroku git:remote -a zui-prod
```

Deploy:

```
zui-(stg/prod)-deploy
```

## Misc Notes

* speed up https://www.bigbinary.com/blog/speeding-up-docker-image-build-process-of-a-rails-application
* originally based on this project: [https://github.com/ryanwi/rails7-on-docker](https://github.com/ryanwi/rails7-on-docker)
