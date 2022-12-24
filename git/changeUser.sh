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
    git config --global user.name $GITHUB_COMPANY_USER
    git config --global user.email $GITHUB_COMPANY_MAIL
}

changePrivateUser() {
    echo "change private user : $GITHUB_PRIVATE_USER"
    git config --global user.name $GITHUB_PRIVATE_USER
    git config --global user.email $GITHUB_PRIVATE_MAIL
}



. $HOME/.env
main $1
