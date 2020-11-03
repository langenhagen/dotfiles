output = system.exec_command("/bin/bash -c '${HOME}/.pyenv/shims/python ${HOME}/Dev/scripts/random_word.py 4'")
keyboard.send_keys(output)
