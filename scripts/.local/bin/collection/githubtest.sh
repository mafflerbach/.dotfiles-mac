#/bin/bash
source ~/dotfiles/.credencials

REPO_OWNER=$(git remote get-url origin | sed 's/git@github.com://g' | sed 's/.git//g' | cut -d'/' -f1)
REPO_NAME=$(git remote get-url origin | sed 's/git@github.com://g' | sed 's/.git//g' | cut -d'/' -f2)
PR_NUMBER=$(gh pr status | sed -n 5p | cut -d' ' -f3 | sed 's/#//')

commit_id=$(git log --format="%H" -n 1)

lineNumber=$2
path=$3

if [[ $path =~ "fugitive:///" ]]; then
    # wtf sed -r 's/.*?\///' seems to match nothing o.O
    path=$(echo $path | sed -e 's/.*\/\///g' -e 's/\//|/' | cut -d'|' -f2)
fi


while getopts lv option

do
    case "${option}"
        in

        l) 
        curl -v -s -H "Authorization: token ${githubToken}" \
            -X POST -d @/tmp/GithubComment.gitcomment \
            "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/pulls/${PR_NUMBER}/comments"

        ;;
    v)

        tee /tmp/GithubComment.gitcomment << END
{
"body": "", 
"path":"${path}", 
"position":${lineNumber}, 
"side": "RIGHT",
"commit_id":"${commit_id}"
}

END

vim /tmp/GithubComment.gitcomment

;;

esac
done





