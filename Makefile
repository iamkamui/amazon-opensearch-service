.PHONY: check_domain
check_domain:
	@awslocal opensearch describe-domain \
    --domain-name ${domain} | jq ".DomainStatus.Processing"

.PHONY: create_default_domain
create_default_domain:
	@awslocal opensearch create-domain --cli-input-json file://./secure-domain.json

.PHONY: start
start:
	@if [ ! -f configure.sh docker-compose.yml secure-domain.json ]; then \
		echo "required files does not exist"; \
		exit 1; \
	fi

	@chmod +x ./configure.sh
	@docker compose up -d localstack
	@sudo ./configure.sh