# Простой расширяемый сайт на Luvit

## Зависимости

Docker, интернет-соединение

## Запуск

Сборка/пересборка сайта + запуск

```bash
docker stop luvit-profile-site
docker rm luvit-profile-site
docker rmi luvit-profile-site
docker build -t luvit-profile-site .
docker run -d -it -p ПОРТ_НА_КОТОРОМ_ПОДНЯТЬ_САЙТ:8080 --name luvit-profile-site --restart unless-stopped luvit-profile-site
docker builder prune -f
```

## Очистка, удаление

Выключение + удаление всего что связано с сайтом

```bash
docker stop luvit-profile-site
docker rm luvit-profile-site
docker rmi luvit-profile-site
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
docker stop luvit-profile-site
docker rm luvit-profile-site
docker rmi luvit-profile-site
docker build -t luvit-profile-site .
docker save -o luvit-profile-site.tar luvit-profile-site
docker rmi luvit-profile-site
docker builder prune -f
```

Загрузка докер-образа с диска + запуск сайта

```bash
docker stop luvit-profile-site
docker rm luvit-profile-site
docker rmi luvit-profile-site
docker load -i luvit-profile-site.tar
docker run -d -it -p ПОРТ_НА_КОТОРОМ_ПОДНЯТЬ_САЙТ:8080 --name luvit-profile-site --restart unless-stopped luvit-profile-site
docker builder prune -f
```