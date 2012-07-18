all: unisay ponysay names quotes edit

unisay:
	git clone "https://github.com/maandree/unisay.git" "unisay"

ponysay:
	git clone "https://github.com/erkin/ponysay.git" "ponysay"

names:
	mv "./unisay/share-src/unisay/ponyquotes/ponies" "./unisay/share-src/unisay/ponyquotes/ponies~"
	chmod 755 "./sed-gen.sh"
	./sed-gen.sh
	chmod 755 "./sed.sh"
	./sed.sh
	chmod 755 "./addln.sh"
	./addln.sh

quotes:
	(cd "./unisay" ; make -B ponyquotes)
	mv "./unisay/share/unisay/ponyquotes/" "."

edit:
	sed -e 's/.\//\/usr\/share\/ponyquotes4ponysay\//g' < "./pq4ps" > "./pq4ps.install"
	sed -e 's/.\//\/usr\/share\/ponyquotes4ponysay\//g' < "./pq4ps.pl" > "./pq4ps.pl.install"

install:
	install -d "$(DESTDIR)/usr/bin"
	install -d "$(DESTDIR)/usr/share/ponyquotes4ponysay"
	install -m 755 "pq4ps.install" "$(DESTDIR)/usr/bin/pq4ps"
	install -m 755 "pq4ps.pl.install" "$(DESTDIR)/usr/bin/pq4ps.pl"
	install -m 755 "pq4ps-list" "$(DESTDIR)/usr/bin/pq4ps-list"
	install -m 755 "pq4ps-list.pl" "$(DESTDIR)/usr/bin/pq4ps-list.pl"
	install -m 644 ponyquotes/* "$(DESTDIR)/usr/share/ponyquotes4ponysay"

uninstall:
	unlink "$(DESTDIR)/usr/bin/pq4ps"
	unlink "$(DESTDIR)/usr/bin/pq4ps.pl"
	unlink "$(DESTDIR)/usr/bin/pq4ps-list"
	unlink "$(DESTDIR)/usr/bin/pq4ps-list.pl"
	rm -r "$(DESTDIR)/usr/share/ponyquotes4ponysay"

clean:
	yes | rm -r "./unisay/" || echo -n
	yes | rm -r "./ponysay/" || echo -n
	rm -r "./ponyquotes/" || echo -n
	rm "./sed.sh" || echo -n
	rm "./pq4ps.install" || echo -n
	rm "./pq4ps.pl.install" || echo -n

