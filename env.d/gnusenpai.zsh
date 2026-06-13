case ${PATH} in
    *${HOME}/bin*) ;;
    *) PATH="${HOME}/bin:${HOME}/.local/bin:${HOME}/.cargo/bin:${PATH}";;
esac
