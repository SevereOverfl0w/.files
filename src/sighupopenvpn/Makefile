sighupopenvpn: main.c
	cc ./main.c -o sighupopenvpn

.PHONY: install
install: sighupopenvpn
	cp sighupopenvpn /etc/zzz.d/resume/
	chown root:shutdown /etc/zzz.d/resume/sighupopenvpn
	chmod ug+rwx /etc/zzz.d/resume/sighupopenvpn
	chmod u+s /etc/zzz.d/resume/sighupopenvpn
