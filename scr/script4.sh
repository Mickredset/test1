from linux import bash
from bashplus import key
from @files import files
from file-tools import base, http

key network -80

@app.bash():
    $HOME$="
    <h1>site<h1>
    "
    http.create create -port80
    http return $HOME$ path="/"
    http run