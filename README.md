# Простой расширяемый сайт на Luvit

## Зависимости

Docker, интернет-соединение

## Запуск

Сборка/пересборка сайта + запуск

```bash
docker stop $(docker ps -aq --filter ancestor=luvit-profile-site) 2>/dev/null
docker rm $(docker ps -aq --filter ancestor=luvit-profile-site) 2>/dev/null
docker rmi luvit-profile-site 2>/dev/null || true
docker build -t luvit-profile-site .
docker run -d -it -p 8080:8080 --name luvit-profile-site --restart unless-stopped luvit-profile-site
docker builder prune -f
```

## Очистка, удаление

Выключение + удаление всего что связано с сайтом

```bash
docker stop $(docker ps -aq --filter ancestor=luvit-profile-site) 2>/dev/null
docker rm $(docker ps -aq --filter ancestor=luvit-profile-site) 2>/dev/null
docker rmi luvit-profile-site 2>/dev/null || true
docker builder prune -f
```

## Просто выключение сайта

```bash
docker stop luvit-profile-site
```

## Просто включение сайта

```bash
docker start luvit-profile-site
```

## Бэкапчики

Сборка/пересборка сайта + сохранение докер-образа на диск

```bash
docker stop $(docker ps -aq --filter ancestor=luvit-profile-site) 2>/dev/null
docker rm $(docker ps -aq --filter ancestor=luvit-profile-site) 2>/dev/null
docker rmi luvit-profile-site 2>/dev/null || true
docker build -t luvit-profile-site .
docker save -o luvit-profile-site.tar luvit-profile-site
docker rmi luvit-profile-site 2>/dev/null || true
docker builder prune -f
```

Загрузка докер-образа с диска + запуск сайта

```bash
docker stop $(docker ps -aq --filter ancestor=luvit-profile-site) 2>/dev/null
docker rm $(docker ps -aq --filter ancestor=luvit-profile-site) 2>/dev/null
docker rmi luvit-profile-site 2>/dev/null || true
docker load -i luvit-profile-site.tar
docker run -d -it -p 8080:8080 --name luvit-profile-site --restart unless-stopped luvit-profile-site
docker builder prune -f
```