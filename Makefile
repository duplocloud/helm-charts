.PHONY: pending
pending: ## Show commits to charts/aos since last release
	@bash scripts/pending-changes.sh
