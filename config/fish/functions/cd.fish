# https://stackoverflow.com/questions/46076344/autols-for-fish-shell
function __autols_hook --description "Auto ls" --on-event fish_prompt
  if test "$__autols_last" != (pwd)
    set -l LS 'ls'
    if type -q exa
      set LS 'exa'
    end
    eval $LS
    # Show git information, and if it's not a git repo, throw error
    # into /dev/null
    if test -e ./.git
      git status --short 2>/dev/null
    end
  end
  set  -g __autols_last (pwd)
end
