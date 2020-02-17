tar -xf /tmp_files/pytz-2006p.tar.xz -C /tmp_files
#tar -xf /tmp_files/python-periphery-master.tar.xz -C /tmp_files
tar -xf /tmp_files/giref-0.1.2.tar.gz -C /tmp_files
tar -xf /tmp_files/pytz-2006p.tar.xz -C /tmp_files

cd /tmp_files/pytz-2006p
/usr/bin/python /tmp_files/pytz-2006p/setup.py install
#cd /tmp_files/python-periphery-master/
#/usr/bin/python /tmp_files/python-periphery-master/setup.py install
cd /tmp_files/Django-1.11.28/
python setup.py install
cd /tmp_files/wsgiref-0.1.2/
python setup.py install

rm -r /tmp_files/*.tar.*
rm -rf /tmp_files/pytz-2006p
#rm -r /tmp_files/python-periphery-master
rm -rf /tmp_files/Django-1.11.28
rm -rf /tmp_files/wsgiref-0.1.2

echo "Hello! It is Stand of Calorimeter' Crystals!"

