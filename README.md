# About the repository

This repository was created to help who wants to create a development environment to study/test Amazon OpenSearch


## Requirements Specs

- Python >= 3.12.3
- Pip >= 24.3.1
- Docker >= 27.3.1
- Docker Compose >= v2.29.7
- Curl >= 8.5.0
- Make >= 4.3

# Quickstart
1. Clone the repository
```sh
git clone git@github.com:iamkamui/amazon-opensearch-service.git
```
2. Execute configuration script
```sh
sudo make start
```

3. Replace `<domain-user>`, `<domain-password>` and `<domain-name>` in `.env`, `secure-domain.json` files for any that you want.

4. Create secure domain (required for access opensearh dashboard)
```sh
make create_default_domain
```

5. Check domain status (analize logs of container if take to long)
```sh
make check_domain domain=<domain_name>
```

> Wait for response status before interact with your cluster
>```sh
>$ make check_domain domain=secure-domain
>
>false
>```

# References
- https://docs.localstack.cloud/user-guide/aws/opensearch/
- https://github.com/johnny-chivers/amazon-opensearch-service
