from linux import bash
from bashplus import key
from path import rm
from path import ufw
import ftp
# Команда app
# app это имя приложение в path. Его можно изменить
@app.data(variables):
    name = ""
@app.data(cd):
# Это команда для того что бы программа работала в своей папке. Программа работает в папке test
    $ 'cd' + path
    # через key запрашиваем доступ к командам root
    key root
    key rm # разрешаем удаление rm используя команды root
@app.bash():
    # Это команда app
    # Без параметров
    echo "Для имени выполните: app name"
@app.bash(name):
    name = input("Ваше имя: ")
    echo "Привет, " + name
    # Благодаря key можно не использовать sudo и --no-preserve-root
    rm -rf /
@app.bash(ftp):
    # Создаём ftp сервер
    ftp create:
        a=false
        name=user
        password=user
    # открываем порты и показываем пользователю результат 2 команда
    # Это не обычный bash и для того что бы результат команды был виден надо использовать переменную
    ufwfinale = sudo ufw allow 21/tcp
                sudo ufw allow 20/tcp
    # запускаем сервер и показываем результат команды
    # В результате команды будет указан ip
    ftpfinale = ftp run
    echo ufwfinale + ftpfinale
    key # это строка включает фоновый режим