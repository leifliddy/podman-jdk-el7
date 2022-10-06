#!/bin/bash

find /output_rpm/ | egrep -v '^/output_rpm/$|\.gitignore' | xargs rm -rf

rpm -ivh /root/$openjdk_srpm
rpmbuild -ba /root/rpmbuild/SPECS/java-17-openjdk.spec

# copy RPMs to output_rpm
find /root/rpmbuild/RPMS/ -type f | grep '\.rpm$' | xargs cp -t /output_rpm/

# copy SRPM to output_rpm
find /root/rpmbuild/SRPMS/ | grep '\.rpm$' | xargs cp -t /output_rpm/

echo -e "\ncontents of /output_rpm"
ls -lA /output_rpm | grep -v .gitignore
