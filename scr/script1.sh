from linux import bash
from bashplus import key
from ftp import create
from json import list
from access_point import create

# Вызываем json
# @ - это как имя пользователя
@json.list(list.json):
    [
    {
        "id": 0,
        "name": "user1",
        "password": "secret1"
    },
    {
        "id": 1,
        "name": "user2",
        "password": "secret2"
    },
    ]

@app.data(variables):
    path = "/"
    list.json:
@app.data(cd):
# Програма будет работать в корне диска
    $ 'cd' + path
    key root
    key rm
@app.bash(echo):
    echo "Всё работает!"
    # Создаём ftp сервер
    ftp create json:
        list.json
    # открываем порты и показываем пользователю результат 2 команда
    ufwfinale = sudo ufw allow 21/tcp
                sudo ufw allow 20/tcp
    # запускаем сервер и показываем результат команды
    # В результате команды будет указан ip
    ftpfinale = ftp run
    echo ufwfinale + ftpfinale
    key # это строка включает фоновый режим
@app.bash(point):
    read -p "Имя сети: " NAME
    read -p "Пароль от сети: " PASSWORD

    # Переменные не постоянные
    crate access_point name=$NAME$ type=WPA2 password=$PASSWORD$
    access_point run
    key