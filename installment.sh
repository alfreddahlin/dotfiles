# Install Emacs editor
sudo apt install emacs

# Setup git and github
git config --global user.name "Alfred Dahlin"

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
gh auth login

cd projects/
git clone git@github.com:alfreddahlin/dotfiles.git
cd dotfiles/

# Installing pyenv and pyenv-virtualenv
sudo apt-get update; sudo apt-get install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~/.pyenv && src/configure && make -C src && cd ~
exec "$SHELL"
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
exec "$SHELL"
#pyenv install 3.10.4
#pyenv virtualenv 3.10.4 latest
# ADD ZSH FILES TO DOTFILES REPO: .zprofile and .zshrc

# Installing Google CLI
sudo rm /etc/apt/sources.list.d/google-cloud-sdk.list # If error reading list
sudo apt-get install apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-cli
gcloud init

# Postgres
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get install postgresql
sudo service postgresql start
sudo -i -u postgres
CREATE ROLE jead WITH LOGIN PASSWORD 'postgres';
ALTER ROLE jead CREATEDB;

# General good to have dependencies (broken dependencies)
pip install wheel
sudo apt-get install --reinstall libpq-dev


# Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install yarn -y


# Node
# use nvm for this



# ----- Per project setup -----
# -----------------------------
# Python keyring for authenticating environment (will need config files)
pip install keyring
pip install keyrings.google-artifactregistry-auth
#pyenv install 3.10.4
#pyenv virtualenv 3.10.4 latest