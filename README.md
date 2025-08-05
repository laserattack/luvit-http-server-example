# Простой сайт на luvit

Зависимости: Docker

Сборка + запуск сайта в докер-контейнере (просто выделить это все и скопировать в терминал)

```
docker stop $(docker ps -aq --filter ancestor=luvit-server) 2>/dev/null; \
docker rm $(docker ps -aq --filter ancestor=luvit-server) 2>/dev/null; \
docker rmi luvit-server 2>/dev/null || true; \
docker build -t luvit-server . && \
docker run -d -p 8080:8080 --name lua-server luvit-server && \
docker builder prune -f
```