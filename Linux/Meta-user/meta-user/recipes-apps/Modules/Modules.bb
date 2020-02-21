#
# This file is the Modules recipe.
#

SUMMARY = "Simple Modules application"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://*.tar.* \
                  "

S = "${WORKDIR}"

do_install() {
             install -d ${D}/tmp_files
             install ${THISDIR}/files/crystallServer.tar.gz ${D}/tmp_files
             install ${THISDIR}/files/python-periphery-master.tar.xz ${D}/tmp_files
             install ${THISDIR}/files/Django-1.11.28.tar.gz ${D}/tmp_files
             install ${THISDIR}/files/pytz-2006p.tar.gz ${D}/tmp_files
             install ${THISDIR}/files/wsgiref-0.1.2.tar.gz ${D}/tmp_files
             install ${THISDIR}/files/getpass.py ${D}/tmp_files
}
FILES_${PN} += "/tmp_files"
