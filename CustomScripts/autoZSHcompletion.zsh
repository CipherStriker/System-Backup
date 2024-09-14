# Zsh completion function for script1.sh
_script1_completions() {
  _files
}

# Zsh completion function for script2.sh
_script2_completions() {
  _files
}

# Register the completion functions for the scripts
compdef _script1_completions ~/System-Planner/System-Setup/CustomScripts/AutoRecon/showFile.sh
compdef _script2_completions show
