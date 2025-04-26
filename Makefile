define HEADER

                                ..                                
                              ...                                 
                      ..........................                  
                   ................................               
                     .................................            
                   .....................................          
                  ........................................        
                .............................................     
               ................................................   
              ...............................................     
              ................................................    
              ................................................    
              .................................................   
              ....................................-............   
              ...................--...............+#...........   
              ...................##...............###...........  
             ...................+###.............+###+..........  
                ...............+#####...........-+####-....... .. 
                 ..+##........+##+++--...............-#.......    
                  .####......+#-....--#-......+-.....+#-......    
 ...---           .+####+.....#-.......#+..#.##-++-+-###.....     
 .++++-..+-.........+######...##-+++++-#########..-+####.. .      
 -+++++++..............-++####+#########################-                           _
.+++++++.....................-##############+####+-..-+++-                         | |            __
.++++++-.........................-++#########+-+-++++++++.        _______ __ __  __| | ____      |__| ____   ______
.++++++-...............................++.....-+++++++++-         \_  __ \  |  \/ __ |/ __ \_____|  |/ __ \ /  ___/ 
 .+++++-......................................++++++++++.          |  | \/  |  / /_/ \  ___/_____/  \  ___/ \___ \  
    .-++.....................................++++++++++.           |__|  |____/\____ |\___  >/\__|  |\___  >____  > 
         ..................................#-+++++++++-                             \/    \/ \______|    \/     \/          

=======================================================================================================================
endef
export HEADER

define APP_HEADER


██ ███    ██  ██████ ███████ ██████  ████████ ██  ██████  ███    ██ 
██ ████   ██ ██      ██      ██   ██    ██    ██ ██    ██ ████   ██ 
██ ██ ██  ██ ██      █████   ██████     ██    ██ ██    ██ ██ ██  ██ 
██ ██  ██ ██ ██      ██      ██         ██    ██ ██    ██ ██  ██ ██ 
██ ██   ████  ██████ ███████ ██         ██    ██  ██████  ██   ████ 
                                                                    
                                                                
endef
export APP_HEADER

REQ = srcs/requirements

COMPOSEFILE = srcs/docker-compose.yml
COMPOSER = docker compose

SRC =	$(COMPOSEFILE) \
		$(REQ)/nginx/Dockerfile \
		$(REQ)/mariadb/Dockerfile \
		$(REQ)/wordpress/Dockerfile \


CONFIG =	srcs/.env \
			$(REQ)/nginx/ssl \


VOLUMES =	srcs_mariadb \
			srcs_wordpress \


VOLUME_BIND =	~/data \
				~/data/mariadb \
				~/data/wordpress \
				~/data/ruinformatique \


SQL_SAVE =	srcs/secrets/dump.sql

up: $(SRC) header $(CONFIG)
		@mkdir -p $(VOLUME_BIND)
		@$(COMPOSER) -f $(COMPOSEFILE) up -d

$(CONFIG):
		@$(MAKE) build --no-print-directory

down: $(SRC)
		@echo "Dumping mariadb to secrets/dump.sql..."
		@docker exec -i mariadb sh -c 'mysqldump -u root -p$$MYSQL_ROOT_PASSWORD -h localhost $$MYSQL_DATABASE' > $(SQL_SAVE)_tmp && rm -rf $(SQL_SAVE) && mv $(SQL_SAVE)_tmp $(SQL_SAVE) || rm -rf $(SQL_SAVE)_tmp
		@$(COMPOSER) -f $(COMPOSEFILE) down

build: $(SRC)
		@echo -e Missing config files!
		@echo -e Generating default config...
		@bash srcs/setup.sh
		@echo -e "\nBuilding docker images...\n"
		@$(COMPOSER) -f $(COMPOSEFILE) build > /dev/null

fclean: clean
		@echo -e "\t[INFO]\t[Inception]\tClearing config files..."
		@rm -rf $(CONFIG)
		@echo -e "\t[INFO]\t[Inception]\tClearing volumes..."
		@docker volume rm $(VOLUMES) 2> /dev/null || echo -n
		@sudo rm -rf $(VOLUME_BIND)
		@echo -e "\t[INFO]\t[Inception]\tProject is fully cleaned 🗑️"

clean:
		@echo -e "\t[INFO]\t[Inception]\tShutting down containers..."
		@$(MAKE) down --no-print-directory || echo -n

header:
		@echo -e "$$HEADER"
		@echo -e "$$APP_HEADER"

.PHONY = all clean fclean re header help build up down
