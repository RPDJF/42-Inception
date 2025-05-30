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

NAME = inception

SRC =	$(COMPOSEFILE) \
		$(REQ)/nginx/Dockerfile \
		$(REQ)/mariadb/Dockerfile \
		$(REQ)/wordpress/Dockerfile \
		$(REQ)/redis/Dockerfile \
		$(REQ)/vsftpd/Dockerfile \
		$(REQ)/ruinformatique-www/Dockerfile \
		$(REQ)/qbittorrent/Dockerfile \
		


CONFIG =	srcs/.env \
			$(REQ)/nginx/ssl \


VOLUMES =	$(NAME)_mariadb \
			$(NAME)_wordpress \
			$(NAME)_ruinformatique \
			$(NAME)_adminer \


VOLUME_ROOT = ~/data

VOLUME_BIND =	$(VOLUME_ROOT)/mariadb \
				$(VOLUME_ROOT)/wordpress \
				$(VOLUME_ROOT)/ruinformatique \
				$(VOLUME_ROOT)/qBittorrent \
				$(VOLUME_ROOT)/adminer \


up: $(SRC) header $(CONFIG)
		@mkdir -p $(VOLUME_BIND)
		@$(COMPOSER) -p $(NAME) -f $(COMPOSEFILE) up -d

$(CONFIG):
		@$(MAKE) build --no-print-directory

down: $(SRC)
		@$(COMPOSER) -p $(NAME) -f $(COMPOSEFILE) down

build: $(SRC)
		@echo -e Missing config files!
		@echo -e Generating default config...
		@bash srcs/setup.sh
		@echo -e "\nBuilding docker images...\n"
		@$(COMPOSER) -p $(NAME) -f $(COMPOSEFILE) build > /dev/null

fclean: clean
		@echo "\t[INFO]\t[$(NAME)]\tRemoving images..."
		@docker images --filter=reference="inception-*" -q | xargs docker rmi -f > /dev/null 2> /dev/null
		@echo -e "\t[INFO]\t[$(NAME)]\tClearing config files..."
		@rm -rf $(CONFIG) 2> /dev/null || true
		@echo -e "\t[INFO]\t[$(NAME)]\tClearing volumes..."
		@docker volume rm $(VOLUMES) 2> /dev/null || true
		@sudo rm -rf $(VOLUME_ROOT)
		@echo -e "\t[INFO]\t[$(NAME)]\tProject is fully cleaned 🗑️"

clean:
		@echo -e "\t[INFO]\t[$(NAME)]\tShutting down containers..."
		@$(MAKE) down --no-print-directory 2> /dev/null || true

header:
		@echo -e "$$HEADER"
		@echo -e "$$APP_HEADER"

.PHONY = all clean fclean header build up down
