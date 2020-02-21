mkdir /server
tar -xf /tmp_files/pytz-2006p.tar.gz -C /tmp_files
tar -xf /tmp_files/python-periphery-master.tar.xz -C /tmp_files
tar -xf /tmp_files/crystallServer.tar.gz -C /server
tar -xf /tmp_files/wsgiref-0.1.2.tar.gz -C /tmp_files
tar -xf /tmp_files/Django-1.11.28.tar.gz -C /tmp_files

echo "Installing necessary packages..."
cd /tmp_files/pytz-2006p
python setup.py install 1> /dev/null
cd /tmp_files/wsgiref-0.1.2/
python setup.py install 1> /dev/null
cd /tmp_files/python-periphery-master/
python setup.py install 1> /dev/null
mv /tmp_files/getpass.py /usr/lib/python2.7/site-packages/
echo "Done!"

echo "Installing Django-1.11.28..."
cd /tmp_files/Django-1.11.28/
python setup.py install 1> /dev/null
echo "Done!"

echo "Start Crystall Server..."
cd /server/crystall
python manage.py migrate
python manage.py runserver 0.0.0.0:8000 &
echo "Done!"

cd /
#rm -rf /tmp_files/
#rm -r /tmp_files/*.tar.*
#rm -rf /tmp_files/pytz-2006p
#rm -r /tmp_files/python-periphery-master
#rm -rf /tmp_files/Django-1.11.28
#rm -rf /tmp_files/wsgiref-0.1.2

echo "Hello! It is Stand of Calorimeter' Crystals!"
