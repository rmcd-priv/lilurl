# Lilurl

## Docker Development w/ Local Elixir available (preferred)  

### Setup
These instructions assume that you have docker and docker-compose installed locally, as well as elixir 1.12.3-otp-24, and erlang 24.1.7. If you do not have elixir/erlang installed locally, and would prefer to use docker commands directly, you can find an equivalent of each mix command at the bottom of this document.  

To get started with a fresh repo, you should run `mix docker.setup`. This will start a temporary instance of the application & postgres containers, and install any missing deps, as well as create, migrate, and seed the database. The development docker container syncs your local repository with the docker container's /app directory.  

### Testing 
From here, you can run `mix docker.test` to run the full suite of application tests. If you would like to run a single test, you may pass a relative file path to `mix docker.test` as well. 

### Starting a Server  
Running `mix docker.server` will start both the application server, as well as the postgres container in detached mode. After the app server has started, you may watch the logs by running `mix docker.logs`. If you would like to run shell commands from within the container, run `docker exec -it lilurl_web_1 bash`.  

Visit `localhost:8080` on your machine to view the application.  


The following mix commands are available when developing this application with a local installation of Elixir available, and their corresponding shell equivalents.

```bash
  mix docker.build
  -  docker-compose -f docker-compose.dev.yml build
  mix docker.postgres.detached
  - docker-compose -f docker-compose.dev.yml up -d postgres
  mix docker.down
  - docker-compose -f docker-compose.dev.yml down
  mix docker.postgres.drop
  - docker-compose -f docker-compose.dev.yml run web mix ecto.drop
  mix docker.setup
  - docker-compose -f docker-compose.dev.yml run web mix setup
  mix docker.test
  - docker-compose -f docker-compose.dev.yml run -e MIX_ENV=test web mix test
  mix docker.server
  - docker-compose -f docker-compose.dev.yml up -d
  mix docker.logs
  - docker logs lilurl_web_1 --follow
```

## Docker Development without Local Elixir  

### Setup
These instructions assume that you have docker and docker-compose installed locally.

To get started with a fresh repo, you should run `docker-compose -f docker-compose.dev.yml run web mix setup`. This will start a temporary instance of the application & postgres containers, and install any missing deps, as well as create, migrate, and seed the database. The development docker container syncs your local repository with the docker container's /app directory.  

### Testing 
From here, you can run `docker-compose -f docker-compose.dev.yml run -e MIX_ENV=test web mix test` to run the full suite of application tests. If you would like to run a single test, you may pass a relative file path to `docker-compose -f docker-compose.dev.yml run -e MIX_ENV=test web mix test` as well. 

### Starting a Server  
Running `docker-compose -f docker-compose.dev.yml up -d` will start both the application server, as well as the postgres container in detached mode. After the app server has started, you may watch the logs by running `docker logs lilurl_web_1 --follow`. If you would like to run shell commands from within the container, run `docker exec -it lilurl_web_1 bash`.  

Visit `localhost:8080` on your machine to view the application.  
