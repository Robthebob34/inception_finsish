all:
	@chmod +x ./srcs/requirements/tools/setup.sh
	@./srcs/requirements/tools/setup.sh
	@sudo hostsed add 127.0.0.1 rheck.42.fr && echo "successfully added rheck.42.fr to /etc/hosts"
	sudo docker compose -f ./srcs/docker-compose.yml up -d

clean:
	sudo docker compose -f ./srcs/docker-compose.yml down --rmi all -v
#	uncomment the following line to remove the images too
#	sudo docker system prune -a

fclean: clean
	@sudo hostsed rm 127.0.0.1 rheck.42.fr && echo "successfully removed rheck.42.fr from /etc/hosts"
	@if [ -d "/home/rheck/data/wordpress" ]; then \
	sudo rm -rf /home/rheck/data/wordpress/* && \
	echo "successfully removed all contents from /home/rheck/data/wordpress/"; \
	fi;

	@if [ -d "/home/rheck/data/mariadb" ]; then \
	sudo rm -rf /home/rheck/data/mariadb/* && \
	echo "successfully removed all contents from /home/rheck/data/mariadb/"; \
	fi;

re:
	sudo docker compose -f ./srcs/docker-compose.yml down --rmi all
	sudo docker compose -f ./srcs/docker-compose.yml up -d --build

ls:
	sudo docker image ls
	sudo docker ps

.PHONY: all, clean, fclean, re, ls
