from linux import bash
from path import git
# Команда app
# app это имя приложение в path. Его можно изменить
@app.data(variables)
url = 0
@app.data(cd)
# Это команда для того что бы программа работала в своей папке. Программа работает в папке test
$ 'cd' + path
@app.bash()
app:
    echo "Для clone используйте команду clone"

@app.bash(clone)
app:
    read -p "Введите URL: " url
    $ 'git clone' + url
    echo "Это программа" > main.txt
    git add main.txt
    git commit -m "Это main.sh работает с git"
    git push