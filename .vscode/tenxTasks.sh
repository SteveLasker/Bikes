declare -a tenxFiles=("/usr/bin/tenx" "/usr/share/tenx" "/usr/local/bin/tenx" "$TENX_HOME/tenx.sh")
tenx=""
for t in "${tenxFiles[@]}"
do
  if [ -e $t ]; then
    tenx=$t
    break
  fi
done

echo $(date) debug start
$tenx debug start
if [ $? -ne 0 ]
then
  echo start debugging failed.
  exit $?
fi
