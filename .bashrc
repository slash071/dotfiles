#--------------------------------------------------- config ---
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1 Prompt
PS1='[\u@\h \W]\$ '

# Add directories to PATH
export PATH=$HOME/.cargo/bin/:$HOME/.local/bin/:$PATH

#-------------------------------------------------- aliases ---
source $HOME/.config/shell/alias

#------------------------------------------------ functions ---
take() {
    mkdir -p "${1}"
    cd "${1}"
}

ds() {
    du -h --max-depth="${1}" "${2}" | sort -hr
}

#------------------------------------------ starship prompt ---
# eval "$(starship init bash)"

#----------------------------------------- autostart startx ---
if [[ -z "${DISPLAY}" ]] && [[ "${XDG_VTNR}" -eq 1 ]]; then
    echo -e "\n\033[32mStarting the graphical server in 5 seconds...\033[0m"
    sleep 5
    exec startx -- -quiet
fi
