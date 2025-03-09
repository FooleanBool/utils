#!/bin/bash
# for most cases change to ollama, if you run ollama in a docker container, you can add an alias:
# alias dxo="docker exec -it ollama ollama" - this gives the ability to run `dxo` on the host
# machine: `dxo run llama3.1:latest ""` will load the llama3.1 model into memory with a blank prompt.
# `docker exec -it ollama ollama list` becomes `dxo list`
COMMAND="dxo" 

_dxo_completion() {
    local cur prev words cword
    _get_comp_words_by_ref -n : cur prev words cword
    
        # Check for the command
        if [[ ${words[0]} == "$COMMAND" && $prev =~ ^[a-zA-Z]+$ ]]; then
            # Use eval to ensure the alias is expanded correctly
            models=$(eval "$COMMAND list | awk 'NR > 1 {print \$1}'")
        
        COMPREPLY=()
        completions=()
        for m in $models; do
            if [[ "$m" == "$cur"* ]]; then
                completions+=("$m")
            fi
        done
        
        # No matches found, exit early
        if [ ${#completions[@]} -eq 0 ]; then
            return
        elif [ ${#completions[@]} -eq 1 ]; then
            COMPREPLY=( "${completions[0]}" )
        else
            # Sort completions and find common prefix between first and last
            IFS=$'\n' sorted_comps=($(printf '%s\n' "${completions[@]}" | sort))
            unset IFS
            
            local common=${sorted_comps[0]}
            local last=${sorted_comps[-1]}
            
            # Find the shortest length for comparison
            local min_len=$(( ${#common} < ${#last} ? ${#common} : ${#last} ))
            local i=0
            while [ $i -lt $min_len ]; do
                if [[ "${common:i:1}" != "${last:i:1}" ]]; then
                    break
                fi
                ((i++))
            done
            
            common_prefix=${common:0:$i}
            
            compopt -o nospace
            compopt -o bashdefault
            # Check if the common prefix is different from the current input to avoid adding a trailing space
            if [[ "$cur" == "$common_prefix" ]]; then
                COMPREPLY=( "${completions[@]}" )
            else
                COMPREPLY=( "$common_prefix" )
            fi
        fi
    fi
    
    return 0
}

# Register the completion function for 'dxo'
complete -F _dxo_completion dxo