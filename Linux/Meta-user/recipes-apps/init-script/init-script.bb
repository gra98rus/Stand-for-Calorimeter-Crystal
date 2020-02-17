#
# This file is the init-script recipe.
#

SUMMARY = "Simple init-script application"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://script.sh \
	"

S = "${WORKDIR}"

#do_install() {
#	     install -d ${D}/${bindir}
#	     install -m 0755 ${S}/init-script ${D}/${bindir}
#}
do_install() {
             install -d ${D}${sysconfdir}/init.d
             install -d ${D}${sysconfdir}/rcS.d
             install -d ${D}${sysconfdir}/rc1.d
             install -d ${D}${sysconfdir}/rc2.d
             install -d ${D}${sysconfdir}/rc3.d
             install -d ${D}${sysconfdir}/rc4.d
             install -d ${D}${sysconfdir}/rc5.d
             install -d ${D}${sbindir}

             install -m 0755 ${WORKDIR}/script.sh      ${D}${sysconfdir}/init.d/

             ln -sf ../init.d/script.sh      ${D}${sysconfdir}/rc1.d/K90script.sh
             ln -sf ../init.d/script.sh      ${D}${sysconfdir}/rc2.d/K90script.sh
             ln -sf ../init.d/script.sh      ${D}${sysconfdir}/rc3.d/K90script.sh
             ln -sf ../init.d/script.sh      ${D}${sysconfdir}/rc4.d/K90script.sh
             ln -sf ../init.d/script.sh      ${D}${sysconfdir}/rc5.d/S90script.sh
}

FILES_${PN} += "script.sh"
