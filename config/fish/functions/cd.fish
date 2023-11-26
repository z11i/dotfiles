# https://stackoverflow.com/questions/46076344/autols-for-fish-shell
function __autols_hook --description "Auto ls" --on-event fish_prompt
    if test "$__autols_last" != (pwd) && test (pwd) != $HOME
        set -f ls_ignores '-I .DS_Store -I .localized -I .git -I .CFUserTextEncoding'
        set -f exa_ignores '-I \'.DS_Store|.localized|.git|.CFUserTextEncoding\''
        set -f LS "ls -A $ls_ignores"
        if type -q eza
            set LS "eza -a $exa_ignores"
        end
        eval $LS
        # Show git information, and if it's not a git repo, throw error
        # into /dev/null
        if test -e ./.git
            git status --short 2>/dev/null
        end
    end
    set -g __autols_last (pwd)
end
