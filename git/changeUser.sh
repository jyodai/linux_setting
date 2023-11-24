

main() {
    case "$1" in
        "c")
            changeCompanyUser
            ;;
        "p")
            changePrivateUser
            ;;
        *)
            echo "undefined";;
    esac
}

chooseSedCommand() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "gsed"
    else
        echo "sed"
    fi
}

changeCompanyUser() {
    echo "change company user : $GITHUB_COMPANY_USER"
    $SED_COMMAND -i "s/\(name\s*=\).*$/\1$GITHUB_COMPANY_USER/" $SETTING_PATH/.gitconfig.user
    $SED_COMMAND -i "s/\(email\s*=\).*$/\1$GITHUB_COMPANY_MAIL/" $SETTING_PATH/.gitconfig.user
}

changePrivateUser() {
    echo "change private user : $GITHUB_PRIVATE_USER"
    $SED_COMMAND -i "s/\(name\s*=\).*$/\1$GITHUB_PRIVATE_USER/" $SETTING_PATH/.gitconfig.user
    $SED_COMMAND -i "s/\(email\s*=\).*$/\1$GITHUB_PRIVATE_MAIL/" $SETTING_PATH/.gitconfig.user
}

. $HOME/.env
SED_COMMAND=$(chooseSedCommand)
main $1

