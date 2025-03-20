function fzf-get-dir --description 'Get directory to command line'
    # Get current command line state
    set -l buffer (commandline -b)
    set -l cursor (commandline -C)

    # Use fd command and store results
    set -l results (fd -t d --hidden --follow --min-depth 1 . 2>/dev/null | fzf -m)

    # If no selection, just repaint
    if test -z "$results"
        commandline -f repaint
        return
    end

    # Append each selected directory to the command line
    for result in $results
        commandline -i -- (string escape $result)
        commandline -i -- " "
    end

    commandline -f repaint
end
