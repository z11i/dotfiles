#!/usr/bin/env fish

function multimatch
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

    # Temporary file to hold intermediate results
    set temp_file (mktemp)

    # Initialize the temporary file with the list of all files
    rg --files . >$temp_file

    # Loop through all arguments
    for term in $argv
        set temp_file_next (mktemp)
        # Use rg to search for the term and update the list of files
        gxargs -a "$temp_file" rg -l "$term" >$temp_file_next 2>/dev/null
        mv $temp_file_next $temp_file
    end

    # Output the final list of files containing all terms
    cat $temp_file

    # Clean up
    rm $temp_file
end
