# Run fzy in the current working directory, appending the selected path, if
# any, to the current command, followed by a space.
function insert-path-in-command-line() {
    local selected_path
    # Print a newline or we'll clobber the old prompt.
    echo
    # Find the path; abort if the user doesn't select anything.
    selected_path=$(fd --type f | fzy) || return
    # Append the selection to the current command buffer.
	LBUFFER="$LBUFFER${(q)selected_path} "
    # Redraw the prompt since fzy has drawn several new lines of text.
    zle reset-prompt
}
# Create the zle widget
zle -N insert-path-in-command-line
# Bind the key to the newly created widget
bindkey "\et" "insert-path-in-command-line"

# CTRL-R - Paste the selected command from history into the command line
function fzy-history() {
  BUFFER=$(history -n 1 | tac | fzy --query "$LBUFFER")
  CURSOR=$#BUFFER

  zle reset-prompt
}

zle -N fzy-history
bindkey '^r' fzy-history
