if command -v guix >/dev/null; then
    if [ -f /run/current-system/etc/profile ]; then
        emulate sh -c '. /run/current-system/etc/profile'
    fi

    HOME_ENVIRONMENT=${HOME}/.guix-home
    if [ -d "${HOME_ENVIRONMENT}" ]; then
        emulate sh -c '. "${HOME_ENVIRONMENT}/setup-environment"'
        if [ "${XDG_RUNTIME_DIR}" ]; then
            "${HOME_ENVIRONMENT}/on-first-login"
        fi
    fi
    unset HOME_ENVIRONMENT
fi
