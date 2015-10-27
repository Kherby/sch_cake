obj-m := sch_cake.o
KERNEL_VERSION := $(shell uname -r)
IDIR := /lib/modules/$(KERNEL_VERSION)/kernel/net/sched/
KDIR := /lib/modules/$(KERNEL_VERSION)/build
PWD := $(shell pwd)
VERSION := $(shell git rev-parse HEAD || echo sha1)
default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules LDFLAGS_MODULE="--build-id=0x$(VERSION)"

install:
	install -v -m 644 sch_cake.ko $(IDIR)
	depmod
	modprobe sch_cake

clean:
	rm -rf Module.markers modules.order Module.symvers sch_cake.ko sch_cake.mod.c sch_cake.mod.o sch_cake.o
