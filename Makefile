.ONESHELL:
SHELL := /bin/bash
NAMESPACE ?= control
FOLDER_NAME ?= manifests

pre-install:
	kubectl create namespace $(NAMESPACE) || true
	cd pre-install/
	./pre-install.sh false

pre-install-dry-run:
	cd pre-install
	./pre-install.sh true

install:
	cd $(FOLDER_NAME)
	kubectl apply -f . -n $(NAMESPACE)
	cd kube-system/
	kubectl apply -f . -n kube-system
	cd ..
	cd 1/
	kubectl apply -f . -n $(NAMESPACE)
	sleep 120
	cd ../2/
	kubectl apply -f . -n $(NAMESPACE)

install-dry-run: 
	cd $(FOLDER_NAME)
	kubectl apply -f . -n $(NAMESPACE) --dry-run
	cd kube-system/
	kubectl apply -f . -n kube-system --dry-run
	cd ..
	cd 1/
	kubectl apply -f . -n $(NAMESPACE) --dry-run
	cd ../2/
	kubectl apply -f . -n $(NAMESPACE) --dry-run

delete:
	cd $(FOLDER_NAME)
	kubectl delete -f . -n $(NAMESPACE)
	cd 1/
	kubectl delete -f . -n $(NAMESPACE)
	cd ../2/
	kubectl delete -f . -n $(NAMESPACE)

.PHONY: pre-install pre-install-dry-run install install-dry-run delete
