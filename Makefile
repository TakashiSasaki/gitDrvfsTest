prepare:
	sudo apt-get install -y libssh-dev  ;\
	sudo apt-get install -y libssl-dev  ;\
	sudo apt-get install -y autoconf ;\
	sudo apt-get install -y gettext ;\
	sudo apt-get install -y libcurl4-openssl-dev ;\
	/usr/bin/git submodule add -f --depth=1 https://github.com/git/git.git ;\
	/usr/bin/git submodule add -f --depth=1 ./git git1;\
	/usr/bin/git submodule add -f --depth=1 ./git git2;\
	/usr/bin/git submodule add -f --depth=1 ./git git3;\
	/usr/bin/git submodule add -f --depth=1 ./git git4

git1:
	cd git1; \
	make clean; \
	make configure ;\
	./configure --without-tcktk --prefix=/tmp/git1; 

git2:
	cd git2; \
	make clean; \
	make configure NO_MMAP=1;\
	./configure --without-tcktk --prefix=/tmp/git2; 

git3:
	cd git3; \
	make clean; \
	make configure;\
	./configure --without-tcktk --prefix=/tmp/git3 NO_MMAP=1; 

git4:
	cd git4; \
	make clean; \
	make configure NO_MMAP=1;\
	./configure --without-tcktk --prefix=/tmp/git4 NO_MMAP=1; 

