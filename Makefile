all: unisay names quotes

unisay:
	git clone "https://github.com/maandree/unisay.git" "unisay"

names: unisay
	mv "./unisay/share-src/unisay/ponyquotes/ponies" "./unisay/share-src/unisay/ponyquotes/ponies~"
	chmod 755 "./sed-gen.sh"
	./sed-gen.sh
	chmod 755 "./sed.sh"
	./sed.sh

quotes: names
	(cd "./unisay" ; make -B ponyquotes)
	mv "./unisay/share/unisay/ponyquotes/" "."

clean:
	yes | rm -r "./unisay/" || echo -n
	yes | rm -r "./ponyquotes/" || echo -n
	rm "./sed.sh" || echo -n
