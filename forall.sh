#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

CMD="$1"
CMD="${SELFDIR}/${CMD}.sh"
shift 
ARGS=$@

if [[ ! -x "${CMD}" ]]; then 
      echo "ERROR: no management action: '$CMD'!"
      exit 1
fi


BASE_DIR="${BASE_DIR:-${SELFDIR}/STATIONS}"

if [[ ! -d "${BASE_DIR}/" ]];
then 
   echo "Error: missing cached configuration: [${BASE_DIR}]!"
   exit 1
fi


if [[ ! -r "${BASE_DIR}/list" ]];
then 
   echo "Error: broken cached configuration at [${BASE_DIR}]!"
   exit 1
fi

echo "Running command: '${CMD} ${ARGS}' on ... "
echo

for f in $(cat "${BASE_DIR}/list") ; do
  echo "... station '$f': "
  echo 
  
  "${CMD}" "${f}" ${ARGS}
  
  echo 
  echo "Exit code: $?"
  echo 
  
done
