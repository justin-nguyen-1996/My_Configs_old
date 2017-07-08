
# generate and save the new ssh key
echo 
echo "You're about to see a prompt that's going to ask you for a file location and passphrase"
echo "Just hit 'enter' 3 times"

echo
ssh-keygen -t rsa -b 4096 -C "2014justinnguyen@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
clip < ~/.ssh/id_rsa.pub

echo
echo "Just copied the ~/.ssh/id_rsa.pub file into the clipboard. So don't try to copy anything (i.e. don't use Ctrl-c)"
echo "A hyperlink will open soon. After it does, go back to these instructions (more will pop up after the link is opened)"

echo
while true; do
read -p "Are you ready? " yn
case $yn in
	[Yy]* ) break;;
	[Nn]* ) ;;
	* ) echo "Please answer yes or no.";;
esac
done
echo

cygstart https://github.com/settings/keys
while true; do
read -p "Ready for the rest of the instructions? " yn
case $yn in
	[Yy]* ) break;;
	[Nn]* ) ;;
	* ) echo "Please answer yes or no.";;
esac
done
echo

echo "1. Log in to Github"
echo "2. Click New SSH Key"
echo "3. Put in an appropriate title"
echo "4. Press Ctrl-v in the Key box (it should match the contents of ~/.ssh/id_rsa.pub)"
echo "5. Click Add SSH Key"

echo
while true; do
read -p "Are you done? " yn
case $yn in
	[Yy]* ) break;;
	[Nn]* ) ;;
	* ) echo "Please answer yes or no.";;
esac
done
echo

