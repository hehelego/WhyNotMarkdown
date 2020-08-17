for a in `find . -type l`
do
    stat -L $a >/dev/null 2>/dev/null
    if [ $? -gt 0 ]
    then
      rm $a
    fi
done
