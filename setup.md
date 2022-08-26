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

TODO: Write helper scripts for this garbage

# Bash helpers

Put this in your `~/.zshrc` (or whatever you're using) then do a `source ~/.zshrc` to reload

```
# DOCKER

# attaches to the current running web instance for debugging
ddebug() {
  docker attach $(docker container ls | grep 'zeemee-ui_web' | grep -Eo '^[^ ]+')
}
# rails c
alias dcon='docker-compose exec web rails console'
# rails s
alias dup='docker-compose up'
```

## Misc Notes

* originally based on this project: [https://github.com/ryanwi/rails7-on-docker](https://github.com/ryanwi/rails7-on-docker)
