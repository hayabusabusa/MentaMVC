.PHONY: inject-token

inject-token:
	echo "let qiitaAccessToken = \"${TOKEN}\"" > ./MentaMVC/Secrets.swift