# Базовый образ - последняя убунту
FROM ubuntu:22.04

# Копирование файлов в директорию в образе
COPY . /home/server

WORKDIR /home/server

# Установка зависимостей
RUN apt-get update && \
    apt-get install -y \
    make \
    gcc \
    curl

# Сборка проекта
RUN make

# Запуск сервера при запуске контейнера
CMD ["make", "run"]