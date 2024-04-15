#!/usr/bin/env fish

function multimatch
    # Function cleanup handler
    function cleanup --on-signal SIGINT --on-signal SIGTERM
        for pid in $pids
            kill $pid >/dev/null 2>&1
        end
        for file in $temp_files
            rm $file
        end
    end

    # Check if rg (ripgrep) is installed
    if not type -q rg
        echo "Error: rg (ripgrep) is not installed. Please install it and retry."
        return 1
    end

    # Check for at least one search term
    if test (count $argv) -lt 1
        echo "Usage: $(status current-command) <search_term1> [<search_term2> ...]"
        return 1
    end

    # Set array to hold search results for each term
    set search_results
    set pids

    # Loop through arguments and search in parallel
    for term in $argv
        set temp_file (mktemp)
        rg --files-with-matches "$term" . >$temp_file &
        set pids $pids $last_pid
        set search_results $search_results $temp_file
    end

    # Wait for all searches to finish
    for pid in $pids
        wait $pid
    end

    # Sort search results
    for file in $search_results
        sort -o $file $file
    end

    # Find common results
    set final_result $search_results[1]
    for i in (seq 2 (count $search_results))
        if not test -s $final_result
            cleanup
            return 0
        end
        touch "$final_result"_temp
        comm -12 $final_result $search_results[$i] >"$final_result"_temp
        mv "$final_result"_temp $final_result
    end
    cat $final_result

    # Clean up
    cleanup
end
