export GOPATH=$HOME/go
# Go's new async preemption breaks restic. Since this is the primary use of compiled go program for me, just enable globally
export GODEBUG=asyncpreemptoff=1
export PATH=$GOPATH/bin:$PATH
export PATH=/usr/pgsql-12/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/share/bin:$PATH
export PATH="$(yarn global bin):$PATH"
export KUBECONFIG=$KUBECONFIG:$HOME/.kube/config:$HOME/.kube/configs/kubeconfig.yaml
export PATH=/usr/local/go/bin:$PATH
export B2_ACCOUNT_ID=002ddcd7e5edf170000000009
export B2_ACCOUNT_KEY=K002CCnnPuYkbLREZGZfWEXuX22Wxu4
export PATH="/Applications/Postgres.app/Contents/Versions/12/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH=$HOME/.pyenv/bin:$PATH
export PATH=$HOME/bin:$PATH
export NEXT_TELEMETRY_DISABLED=1
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

export PATH="/usr/local/opt/mysql-client/bin:$PATH"
