from linux import bash
from bashplus import key

@app.bash():
    $ONE$="one"
    $TWO$="TWO"
    # Берём и бросаем объект в другой объект
    # В ONE бросаем TWO
    vbros $ONE$ -$TWO$
    # Мы не сможем вывести объект
    echo $ONE$
    # мы можем сделать
    # vbros bash.main -ДРУГОЙ_ПРОЦЕСС
    # Эта строка перейдёт на другой исполняемый файл