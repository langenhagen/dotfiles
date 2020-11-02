system.exec_command("/bin/bash -c '${HOME}/.pyenv/shims/python ${HOME}/Dev/scripts/random_word.py 4 | tee /home/andreasl/.random_word'")

output = system.exec_command("head -1 /home/andreasl/.random_word")
keyboard.send_keys(output)
