# Install utils
```bash
apt update && apt install -y curl jq
```

# Install Docker
```bash
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
```

# Config app
```bash
docker run --rm --name defund_init --network host -v $HOME/.defund:/root/.defund sashaoshurkov/defund:v0.1.0-alpha defundd config chain-id defund-private-2; \
docker run --rm --name defund_init --network host -v $HOME/.defund:/root/.defund sashaoshurkov/defund:v0.1.0-alpha defundd config keyring-backend test
```

# Initialize the validator with a moniker name (Example moniker_name: solid-moon-rock)
```bash
docker run --rm --name defund_init --network host -v $HOME/.defund:/root/.defund sashaoshurkov/defund:v0.1.0-alpha defundd init [moniker_name] --chain-id defund-private-2
```

# Add a new wallet address, store seeds and buy FETF to it (Example wallet_name: solid-moon-rock)
```bash
docker run --rm -it --name defund_init --network host -v $HOME/.defund:/root/.defund sashaoshurkov/defund:v0.1.0-alpha defundd keys add [wallet_name] --keyring-backend test
```

# Add genesis account
```bash
WALLET_ADDRESS=$(docker run --rm -it --name defund_init --network host -v $HOME/.defund:/root/.defund sashaoshurkov/defund:v0.1.0-alpha defundd keys show [wallet_name] -a); \
docker run --rm -it --name defund_init --network host -v $HOME/.defund:/root/.defund sashaoshurkov/defund:v0.1.0-alpha defundd add-genesis-account $WALLET_ADDRESS 100000000ufetf
```

# Generate gentx
```bash
docker run --rm -it --name defund_init --network host -v $HOME/.defund:/root/.defund sashaoshurkov/defund:v0.1.0-alpha defundd gentx [wallet_name] 90000000ufetf --chain-id defund-private-2 --moniker=[moniker_name] --commission-max-change-rate=0.01 --commission-max-rate=0.20 --commission-rate=0.05
```