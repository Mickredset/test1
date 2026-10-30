from linux import bash
from bashplus import key
from ftp import create
from json import list
@app.data(variables):
    path = "/"
    list.json:
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