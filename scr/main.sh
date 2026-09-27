from linux import bash
from bashplus import key
from path import rm
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