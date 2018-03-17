#
###############################################################################

clean:
	-rm -rf projects/1_basic/work/*
	-rm -rf projects/1_basic/iseconfig/
	-rm -rf projects/2_additional/work/*
	-rm -rf projects/2_additional/iseconfig/

distclean: clean

###############################################################################

MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PROJECT_DIR := $(notdir $(patsubst %/,%,$(dir $(MAKEFILE_PATH))))

dist: distclean
	cd ../ && zip -9r \
		${PROJECT_DIR}-$$(date +%F-%T | sed 's/:/-/g').zip \
		${PROJECT_DIR}

###############################################################################
