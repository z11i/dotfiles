function linecount -d 'Counting lines in a file, wc -l ignores last line if it does not end with new line'
    awk 'END{print NR}' "$argv"
end
