drmi() {
	docker rmi $(docker images --all | tail -n +2 | fzf -m --header "Select image to delete" | awk '{print $3}')
}

drmc() {
	docker rm $(docker ps --filter "status=exited" | tail -n +2 | fzf -m --header "Select container to delete" | awk '{print $1}')
}

dkill() {
	docker kill $(docker ps | tail -n +2 | fzf -m --header "Select container to kill" | awk '{print $1}')
}
