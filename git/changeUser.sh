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

changeCompanyUser() {
    echo "change company user : $GITHUB_COMPANY_USER"
    sed -i "s/\(name\s*=\).*$/\1$GITHUB_COMPANY_USER/" $SETTING_PATH/.gitconfig.user
    sed -i "s/\(email\s*=\).*$/\1$GITHUB_COMPANY_MAIL/" $SETTING_PATH/.gitconfig.user
}

changePrivateUser() {
    echo "change private user : $GITHUB_PRIVATE_USER"
    sed -i "s/\(name\s*=\).*$/\1$GITHUB_PRIVATE_USER/" $SETTING_PATH/.gitconfig.user
    sed -i "s/\(email\s*=\).*$/\1$GITHUB_PRIVATE_MAIL/" $SETTING_PATH/.gitconfig.user
}



. $HOME/.env
main $1
