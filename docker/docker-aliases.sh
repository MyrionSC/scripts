############################################################################
#                                                                          #
#               ------- Useful Docker Aliases --------                     #
#                                                                          #
#     # Installation :                                                     #
#     copy/paste these lines into your .bashrc or .zshrc file or just      #
#     type the following in your current shell to try it out:              #
#     wget -O - https://gist.githubusercontent.com/jgrodziski/9ed4a17709baad10dbcd4530b60dfcbb/raw/d84ef1741c59e7ab07fb055a70df1830584c6c18/docker-aliases.sh | bash
#                                                                          #
#     # Usage:                                                             #
#     daws <svc> <cmd> <opts> : aws cli in docker with <svc> <cmd> <opts>  #
#     dc             : docker-compose                                      #
#     dcu            : docker-compose up -d                                #
#     dcd            : docker-compose down                                 #
#     dcr            : docker-compose run                                  #
#     dex <container>: execute a bash shell inside the RUNNING <container> #
#     di <container> : docker inspect <container>                          #
#     dim            : docker images                                       #
#     dip            : IP addresses of all running containers              #
#     dol <container>: docker logs -f <container>                          #
#     dnames         : names of all running containers                     #
#     dps            : docker ps                                           #
#     dpsa           : docker ps -a                                        #
#     drmc           : remove all exited containers                        #
#     drmid          : remove all dangling images                          #
#     drun <image>   : execute a bash shell in NEW container from <image>  #
#     dsr <container>: stop then remove <container>                        #
#                                                                          #
############################################################################

# help
function doh-fn() {
cat <<EOF >&2
daws <svc> <cmd> <opts> : aws cli in docker with <svc> <cmd> <opts>
dc             : docker-compose
dcu            : docker-compose up -d
dcd            : docker-compose down
dcr            : docker-compose run
dex <container>: execute a bash shell inside the RUNNING <container>
di <container> : docker inspect <container>
dim            : docker images
dip            : IP addresses of all running containers
dol <container>: docker logs -f <container>
dor <container>: docker restart <container>
dnames         : names of all running containers
dps            : docker ps
dpsa           : docker ps -a
drmc           : remove all exited containers
drmid          : remove all dangling images
drun <image>   : execute a bash shell in NEW container from <image>
dsr <container>: stop then remove <container>
EOF
}


function dnames-fn {
docker ps --format '{{.Names}}'
}

function dip-fn {
echo "IP addresses of all named running containers"

for DOC in `dnames-fn`
do
IP=`docker inspect $DOC | grep -m3 IPAddress | cut -d '"' -f 4 | tr -d "\n"`
OUT+=$DOC'\t'$IP'\n'
done
echo $OUT|column -t
}

function dex-fn {
if [ -z "$1" ]; then
    docker exec -it $(dnames | fzf --height 30) ${2:-bash}
else
    docker exec -it $1 ${2:-bash}
fi
}

function di-fn {
if [ -z "$1" ]; then
    ID=$(dnames | fzf --height 30)
    docker inspect $ID
    history -s di $ID
else
    docker inspect $1
fi
}

# can be used with piping eg: dol NAME | grep GET
function dol-fn {
if [ -z "$1" ]; then
    ID=$(dnames | fzf --height 30)
    docker logs -f $ID
    history -s dol $ID
else
    docker logs -f $1
fi
}

function dor-fn {
if [ -z "$1" ]; then
    ID=$(dnames | fzf --height 30)
    docker restart $ID
    history -s dor $ID
else
    docker restart $1
fi
}

function drun-fn {
docker run -it $1 $2
}

function dcr-fn {
docker-compose run $@
}

function dsr-fn {
if [ -z "$1" ]; then
    ID=$(dnames | fzf --height 30)
    docker stop $ID;docker rm $ID
    history -s di $ID
else
    docker stop $1;docker rm $1
fi
}

function drmc-fn {
docker rm $(docker ps --all -q -f status=exited)
}

function drmid-fn {
DANGLING_IMGS=$(docker images -q -f dangling=true)
if [ -z $DANGLING_IMGS ]; then
    echo No dangling images detected
else
    docker rmi $DANGLING_IMGS
fi
}

# in order to do things like dex $(dlab label) sh
function dlab {
docker ps --filter="label=$1" --format="{{.ID}}"
}

function dc-fn {
docker-compose $*
}

function d-aws-cli-fn {
docker run \
-e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
-e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
-e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
amazon/aws-cli:latest $1 $2 $3
}

alias edals='vim ~/bin/docker/docker-aliases.sh'
alias edockals='vim ~/bin/docker/docker-aliases.sh'

alias doh=doh-fn
alias daws=d-aws-cli-fn
alias dc=dc-fn
alias dcu="docker-compose up -d --remove-orphans"
alias dcd="docker-compose down --remove-orphans"
alias dcdu="docker-compose down --remove-orphans && docker-compose up -d"
alias dcr=dcr-fn
alias dex=dex-fn
alias di=di-fn
alias dim="docker images"
alias dip=dip-fn
alias dol=dol-fn
alias dor=dor-fn
alias dnames=dnames-fn
alias dps="docker ps"
alias dpsa="docker ps -a"
alias drmc=drmc-fn
alias drmid=drmid-fn
alias drun=drun-fn
alias dsp="docker system prune --all"
alias dsr=dsr-fn
