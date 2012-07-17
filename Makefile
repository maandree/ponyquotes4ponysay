all: unisay quotes

unisay:
	git clone "https://github.com/maandree/unisay.git" "unisay"

quotes:
	(cd "./unisay" ; make -B ponyquotes)
	mv "./unisay/share/unisay/ponyquotes/" "."

clean:
	yes | rm -r "./unisay/" || echo -n
	yes | rm -r "./ponyquotes/" || echo -n
