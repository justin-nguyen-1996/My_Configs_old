
# temp.sh

echo
while true; do
read -p "Are you ready? " yn
case $yn in
	[Yy]* | "" ) break;;
	[Nn]*      ) ;;
	*          ) echo "Please answer yes or no.";;
esac
done
