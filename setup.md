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

Open [http://localhost:3000](http://localhost:3000)

