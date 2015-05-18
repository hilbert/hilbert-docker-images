U=malex984
I=dockapp
APP=appchoo

IMG=$U/$I:$(APP)

all: build

build: .timestamp

.timestamp: Dockerfile menu.sh $(APP).list imgs
	docker build -t $(IMG) .
	docker images -a $(IMG) > .timestamp

$(APP).list: txt2jpg.sh
	./txt2jpg.sh A_Test_App_A B_Same_Test_App Alsa_Test GUI_Shell Bash_in_Main X11_Shell X11Server Xephyr Iceweasel Q3 Skype Cups_Server Media_Players AppChoo Test QUIT > $(APP).list

clean: 
	rm -f $(APP).list imgs/*.jpg
	rmdir imgs

