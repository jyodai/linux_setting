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
    sed -i "s/\(GITHUB_USER=\).*$/\1$GITHUB_COMPANY_USER/" $HOME/.env
    sed -i "s/\(GITHUB_MAIL=\).*$/\1$GITHUB_COMPANY_MAIL/" $HOME/.env
}

changePrivateUser() {
    echo "change private user : $GITHUB_PRIVATE_USER"
    sed -i "s/\(GITHUB_USER=\).*$/\1$GITHUB_PRIVATE_USER/" $HOME/.env
    sed -i "s/\(GITHUB_MAIL=\).*$/\1$GITHUB_PRIVATE_MAIL/" $HOME/.env
}



. $HOME/.env
main $1
