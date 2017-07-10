build:
	@docker-compose -p jenkins build 

run:
	@docker-compose -p jenkins up -d master

logs:
	@docker logs -f jenkins_master_1

stop:
	@docker-compose -p jenkins stop

clean: stop
	@docker-compose -p jenkins rm master

cleanup: clean-containers clean-images

clean-images:
	@docker rmi `docker images -q -f "dangling=true"`

clean-containers:
	@docker rm -v `docker ps -a -q -f status=exited`

