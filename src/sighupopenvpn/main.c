#include <stdlib.h>

int main(){
	system("/usr/bin/pkill --signal SIGHUP --exact openvpn");
}

