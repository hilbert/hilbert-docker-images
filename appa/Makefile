mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
COPYFILES   := 
include ../Makefile.inc

RUNTERM=-it -a stdin -a stdout -a stderr
OPTS=--skip-startup-files --skip-runit

CMD=A.sh 
ARGS=AHelloA

# --net=host
# none 

# -e HB_HOST="127.0.0.1"
check: $(TS)
	docker run --rm ${RUNTERM} -e APP_ID=AA_FG --label is_top_app=1 --net=host $(IMG) ${OPTS} -- ${CMD} ${ARGS}


check_bg: $(TS)
	docker run -d -e APP_ID=AA_BG --label is_top_app=1 --net=host $(IMG) ${OPTS} -- ${CMD} ${ARGS}

