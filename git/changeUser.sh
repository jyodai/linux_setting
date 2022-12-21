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
    sed -i "s/\(GITHUB_USER=\).*$/\1$GITHUB_COMPANY_USER/" $SETTING_PATH/.env
    sed -i "s/\(GITHUB_MAIL=\).*$/\1$GITHUB_COMPANY_MAIL/" $SETTING_PATH/.env
}

changePrivateUser() {
    echo "change private user : $GITHUB_PRIVATE_USER"
    sed -i "s/\(GITHUB_USER=\).*$/\1$GITHUB_PRIVATE_USER/" $SETTING_PATH/.env
    sed -i "s/\(GITHUB_MAIL=\).*$/\1$GITHUB_PRIVATE_MAIL/" $SETTING_PATH/.env
}



. $HOME/.env
main $1
