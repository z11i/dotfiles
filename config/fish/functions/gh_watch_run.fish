function gh_watch_run -a filterstr
	set -f filter 'fzf'
	if test -n "$filterstr"
		set -f filter grep
	end
	gh run watch (gh run list --workflow=(ls .github/workflows | grep -E 'ya?ml' | $filter $filterstr) --json='headBranch,databaseId,number' | jq '[.[] | select(.headBranch == "'(git branch-name)'")] | max_by(.number) | .databaseId')
end
