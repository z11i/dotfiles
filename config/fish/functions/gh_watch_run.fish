function gh_watch_run
	gh run watch (gh run list --workflow=(ls .github/workflows | grep -E 'ya?ml' | fzf) --json='headBranch,databaseId,number' | jq '[.[] | select(.headBranch == "'(git branch-name)'")] | max_by(.number) | .databaseId')
end
