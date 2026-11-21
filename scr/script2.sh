from linux import bash
from bashplus import key
from @class import class
from bashplus import function

@app.data(variables):
    path = "/"
    list.json
@app.data(cd):
# Програма будет работать в корне диска
    $ 'cd' + path
    key root
    key rm

@class(Testclass):
    function __init__(self, hp, bash):
        $SELF.HP$
        $SELF.BASH$
    
    function test(self):
        echo "hp и bash" + $SELF.HP$ + " " + $SELF.BASH$
    
@app.bash():
    $CAT$=@class Testclass(50, "Крутой bashplus")
    echo $CAT.HP$
    echo $CAT.BASH$
    CAT.test