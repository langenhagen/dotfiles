# Fish completions for the CLI tool `aws`.
# Requires the tool `aws_completer` that usually comes with `aws`.
#
# Based on: https://stackoverflow.com/questions/26981542/aws-cli-command-completion-with-fish-shell

function __fish_complete_aws
    env COMP_LINE=(commandline -pc) aws_completer | tr -d ' '
end

complete --command aws --no-files --arguments "(__fish_complete_aws)"
