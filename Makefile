.PHONY: create_domain
create_domain:
	@awslocal opensearch create-domain --cli-input-json file://./secure-devpillow-study.json

.PHONY: start
start:
	@if [ ! -f configure.sh docker-compose.yml secure-devpilllow-study ]; then \
		echo "required files does not exist"; \
		exit 1; \
	fi

	chmod +x configure.sh
	@docker compose up -d localstack