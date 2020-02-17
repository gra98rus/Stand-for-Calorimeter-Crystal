#! /bin/sh

tar -xf /tmp_files/setuptools-39.0.tar.xz -C /tmp_files
tar -xf /tmp_files/pytz-2006p.tar.xz -C /tmp_files
tar -xf /tmp_files/python-periphery-master.tar.xz -C /tmp_files
tar -xf /tmp_files/Django-1.11.tar.gz -C /tmp_files

cd /tmp_files/setuptools-39.0.1/
/usr/bin/python /tmp_files/setuptools-39.0.1/setup.py install
cd /tmp_files/pytz-2006p/
/usr/bin/python /tmp_files/pytz-2006p/setup.py install
cd /tmp_files/python-periphery-master/
/usr/bin/python /tmp_files/python-periphery-master/setup.py install
cd /tmp_files/Django-1.11/
/usr/bin/python /tmp_files/Django-1.11/setup.py install

rm -r /tmp_files/*.tar.*
rm -r /tmp_files/setuptools-39.0.1
rm -r /tmp_files/pytz-2006p
rm -r /tmp_files/python-periphery-master
rm -r /tmp_files/Django-1.11
