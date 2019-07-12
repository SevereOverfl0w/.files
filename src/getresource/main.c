#include <stdio.h>
#include <X11/Xresource.h>
#include <string.h>

int main(int argc, char **argv){
	Display* display;
	XrmDatabase db;
	char *resource_manager;
	XrmValue ret;
	char *var = 0;
	char *type = 0;

	if (argc < 2){
		return -1;
	}

	XrmInitialize();

	if (!(display = XOpenDisplay(NULL))) {
		printf("Couldn't open display\n");
		return -1;
	}

	resource_manager = XResourceManagerString(display);

	if (resource_manager == NULL)
		return -2;

	db = XrmGetStringDatabase(resource_manager);

	XrmGetResource(db, argv[1], "String", &type, &ret);

	if (ret.addr != NULL && !strncmp("String", type, 64)) {
		var = ret.addr;
	} else {
		XCloseDisplay(display);
		return -1;
	}

	printf("%s\n", var);

	XCloseDisplay(display);

	return 0;
}
