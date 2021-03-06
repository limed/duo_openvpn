CC		:= gcc
CFLAGS	:=
LDFLAGS	:= -fPIC -shared
INSTALL	:= install
DESTDIR	:= /
PREFIX	:= /usr

all: plugin

plugin: duo_openvpn.c
	$(CC) $(CFLAGS) $(LDFLAGS) -I. -c duo_openvpn.c
	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-soname,duo_openvpn.so -o duo_openvpn.so duo_openvpn.o

install: plugin
	mkdir -p $(DESTDIR)$(PREFIX)/lib/openvpn/plugins/
	mkdir -p $(DESTDIR)/etc/openvpn/
	$(INSTALL) -m755 duo_openvpn.so $(DESTDIR)$(PREFIX)/lib/openvpn/plugins/
	$(INSTALL) -m755 duo_openvpn.py $(DESTDIR)$(PREFIX)/lib/openvpn/plugins/
	$(INSTALL) -m600 duo_openvpn.conf.inc $(DESTDIR)/etc/duo_openvpn.conf
	$(INSTALL) -m755 scripts/vpn_kill_users.py $(DESTDIR)$(PREFIX)/lib/openvpn/plugins/

clean:
	rm -f *.o
	rm -f *.so
	rm -f *.pyc
	rm -rf __pycache__
