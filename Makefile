EXTDIR=${DESTDIR}/etc
MAN8=${DESTDIR}/usr/share/man/man8
SBIN=${DESTDIR}/sbin
MODE=754
CONFMODE=644

all:
	@grep "^install" Makefile | cut -d ":" -f 1
	@echo "Select an appropriate install target from the above list"

install-everything: install-networkfix install-swapfix install-fake-hwclock install-rngd install-sshd-keygen install-switch-cpu-governor

uninstall-everything: uninstall-networkfix uninstall-swapfix uninstall-fake-hwclock uninstall-rngd uninstall-sshd-keygen uninstall-switch-cpu-governor

install-networkfix:
	echo "vm.min_free_kbytes=8192" >> ${EXTDIR}/sysctl.conf

uninstall-networkfix:
	sed -i '/vm.min_free_kbytes=8192/d' ${EXTDIR}/sysctl.conf

install-swapfix:
	mv ${EXTDIR}/rc.d/rcS.d/S20swap ${EXTDIR}/rc.d/rcS.d/S60swap
	echo "vm.swappiness=1" >> ${EXTDIR}/sysctl.conf

uninstall-swapfix:
	mv ${EXTDIR}/rc.d/rcS.d/S60swap ${EXTDIR}/rc.d/rcS.d/S20swap
	sed -i '/vm.swappiness=1/d' ${EXTDIR}/sysctl.conf

install-fake-hwclock:
	install -m ${MODE} sbin/fake-hwclock   ${SBIN}
	install -m ${MODE} sbin/fake-hwclock.8 ${MAN8}
	install -m ${MODE} init.d/fake-hwclock ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/fake-hwclock ${EXTDIR}/rc.d/rcS.d/S01fake-hwclock
	ln -sf  ../init.d/fake-hwclock ${EXTDIR}/rc.d/rc0.d/K01fake-hwclock
	ln -sf  ../init.d/fake-hwclock ${EXTDIR}/rc.d/rc1.d/K01fake-hwclock
	ln -sf  ../init.d/fake-hwclock ${EXTDIR}/rc.d/rc6.d/K01fake-hwclock

uninstall-fake-hwclock:
	rm ${SBIN}/fake-hwclock
	rm ${MAN8}/fake-hwclock.8
	rm ${EXTDIR}/rc.d/init.d/fake-hwclock
	rm ${EXTDIR}/rc.d/rcS.d/S01fake-hwclock
	rm ${EXTDIR}/rc.d/rc0.d/K01fake-hwclock
	rm ${EXTDIR}/rc.d/rc1.d/K01fake-hwclock
	rm ${EXTDIR}/rc.d/rc6.d/K01fake-hwclock

install-rngd:
	install -m ${MODE} init.d/rngd ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/rngd ${EXTDIR}/rc.d/rc0.d/K45rngd
	ln -sf  ../init.d/rngd ${EXTDIR}/rc.d/rc1.d/K45rngd
	ln -sf  ../init.d/rngd ${EXTDIR}/rc.d/rc2.d/K45rngd
	ln -sf  ../init.d/rngd ${EXTDIR}/rc.d/rc3.d/S25rngd
	ln -sf  ../init.d/rngd ${EXTDIR}/rc.d/rc4.d/S25rngd
	ln -sf  ../init.d/rngd ${EXTDIR}/rc.d/rc5.d/S25rngd
	ln -sf  ../init.d/rngd ${EXTDIR}/rc.d/rc6.d/K45rngd

uninstall-rngd:
	rm ${EXTDIR}/rc.d/init.d/rngd
	rm ${EXTDIR}/rc.d/rc0.d/K45rngd
	rm ${EXTDIR}/rc.d/rc1.d/K45rngd
	rm ${EXTDIR}/rc.d/rc2.d/K45rngd
	rm ${EXTDIR}/rc.d/rc3.d/S25rngd
	rm ${EXTDIR}/rc.d/rc4.d/S25rngd
	rm ${EXTDIR}/rc.d/rc5.d/S25rngd
	rm ${EXTDIR}/rc.d/rc6.d/K45rngd

install-sshd-keygen:
	install -m ${MODE} init.d/sshd ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/sshd ${EXTDIR}/rc.d/rc0.d/K30sshd
	ln -sf  ../init.d/sshd ${EXTDIR}/rc.d/rc1.d/K30sshd
	ln -sf  ../init.d/sshd ${EXTDIR}/rc.d/rc2.d/K30sshd
	ln -sf  ../init.d/sshd ${EXTDIR}/rc.d/rc3.d/S30sshd
	ln -sf  ../init.d/sshd ${EXTDIR}/rc.d/rc4.d/S30sshd
	ln -sf  ../init.d/sshd ${EXTDIR}/rc.d/rc5.d/S30sshd
	ln -sf  ../init.d/sshd ${EXTDIR}/rc.d/rc6.d/K30sshd

uninstall-sshd-keygen:
	rm ${EXTDIR}/rc.d/init.d/sshd
	rm ${EXTDIR}/rc.d/rc0.d/K30sshd
	rm ${EXTDIR}/rc.d/rc1.d/K30sshd
	rm ${EXTDIR}/rc.d/rc2.d/K30sshd
	rm ${EXTDIR}/rc.d/rc3.d/S30sshd
	rm ${EXTDIR}/rc.d/rc4.d/S30sshd
	rm ${EXTDIR}/rc.d/rc5.d/S30sshd
	rm ${EXTDIR}/rc.d/rc6.d/K30sshd

install-switch-cpu-governor:
	install -m ${MODE} init.d/switch_cpu_governor ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/switch_cpu_governor ${EXTDIR}/rc.d/rcS.d/S95switch_cpu_governor

uninstall-switch-cpu-governor:
	rm ${EXTDIR}/rc.d/init.d/switch_cpu_governor
	rm ${EXTDIR}/rc.d/rcS.d/S95switch_cpu_governor
