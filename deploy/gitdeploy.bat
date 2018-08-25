set user=
set host=
set pwd=

set commit_msg=%1

REM todo : condition if commit_msg empty or not set, no git ?
git add .
git commit -m %commit_msg%
git push -u origin master
plink %user%@%host% -m deploy.sh -pw %pwd% -t