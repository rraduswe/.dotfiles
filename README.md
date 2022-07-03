# Create Tmux config to open a project
Create a sh file with the following content:

```
#!/bin/bash

tmux new -d -s example

tmux rename-window -t example:1 'code'
tmux send-keys -t example:1 'cd ~/workspace/folder && nvim .' Enter

tmux new-window -t example:2 -n 'terminal'
tmux send-keys -t esample:2 'cd ~/workspace/folder' Enter

tmux attach-session -t example:1
```
