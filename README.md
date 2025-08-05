# Простой сайт на luvit

## Зависимости

Docker, интернет-соединение

## Запуск

Сборка/пересборка сайта + запуск

```bash
docker stop $(docker ps -aq --filter ancestor=luvit-server) 2>/dev/null
docker rm $(docker ps -aq --filter ancestor=luvit-server) 2>/dev/null
docker rmi luvit-server 2>/dev/null || true
docker build -t luvit-server .
docker run -d -it -p 8080:8080 --name lua-server luvit-server
docker builder prune -f
```

## Очистка, удаление

Выключение + удаление всего что связано с сайтом

```bash
docker stop $(docker ps -aq --filter ancestor=luvit-server) 2>/dev/null
docker rm $(docker ps -aq --filter ancestor=luvit-server) 2>/dev/null
docker rmi luvit-server 2>/dev/null || true
docker builder prune -f
```

## Бэкапчики

Сборка/пересборка сайта + сохранение докер-образа на диск

```bash
docker stop $(docker ps -aq --filter ancestor=luvit-server) 2>/dev/null
docker rm $(docker ps -aq --filter ancestor=luvit-server) 2>/dev/null
docker rmi luvit-server 2>/dev/null || true
docker build -t luvit-server .
docker save -o luvit-server.tar luvit-server
docker rmi luvit-server 2>/dev/null || true
docker builder prune -f
```

Загрузка докер-образа с диска + запуск сайта

```bash
docker stop $(docker ps -aq --filter ancestor=luvit-server) 2>/dev/null
docker rm $(docker ps -aq --filter ancestor=luvit-server) 2>/dev/null
docker rmi luvit-server 2>/dev/null || true
docker load -i luvit-server.tar
docker run -d -it -p 8080:8080 --name lua-server luvit-server
docker builder prune -f
```