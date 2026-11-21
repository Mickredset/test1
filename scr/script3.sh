from linux import bash
from bashplus import key
from @class import class
from bashplus import function
from @files import files
from file-tools import base, gui

@app.bash():
    $TEXT$=file open:
        text.txt
    if file.error:
        echo "Ошибка! Файла нету"

@app.bash(gui):
    $GUI$=@files(root)
    root.text "Привет!" # Тестова функция
    root.run