# Disable CRA auto opening Chrome
export BROWSER=off
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
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
# $(pyenv init --path)
export PATH="${PYENV_ROOT}/shims:${PATH}"
export PATH="$PYENV_ROOT/bin:$PATH"

# Disable dotnet telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export GH_PACKAGE_READ_TOKEN=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

export OPAM_SWITCH_PREFIX='/Users/kellen/.opam/default'; export OPAM_SWITCH_PREFIX;
CAML_LD_LIBRARY_PATH='/Users/kellen/.opam/default/lib/stublibs:/Users/kellen/.opam/default/lib/ocaml/stublibs:/Users/kellen/.opam/default/lib/ocaml'; export CAML_LD_LIBRARY_PATH;
OCAML_TOPLEVEL_PATH='/Users/kellen/.opam/default/lib/toplevel'; export OCAML_TOPLEVEL_PATH;
PKG_CONFIG_PATH='/Users/kellen/.opam/default/lib/pkgconfig'; export PKG_CONFIG_PATH;
PATH='/Users/kellen/.opam/default/bin:/Users/kellen/Downloads/google-cloud-sdk/bin:/Users/kellen/.local/share/bin:/Users/kellen/.pyenv/plugins/pyenv-virtualenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/usr/local/share/dotnet:/Applications/Keybase.app/Contents/SharedSupport/bin:/opt/X11/bin:~/.dotnet/tools:/Library/Apple/usr/bin:/Users/kellen/.pyenv/bin:/Users/kellen/.pyenv/shims:/Users/kellen/.poetry/bin:/Users/kellen/.cargo/bin:/Users/kellen/bin:/Applications/Postgres.app/Contents/Versions/12/bin:/Users/kellen/.local/share/bin:/Users/kellen/.local/bin:/usr/pgsql-12/bin:/Users/kellen/go/bin'; export PATH;
