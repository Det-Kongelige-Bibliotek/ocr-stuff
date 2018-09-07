#!/bin/bash



utils/load_exist.pl --suffix xml  --user admin --password $1 --host-port xstorage-test-01.kb.dk:8080 --context /exist/rest/db --load ../innovation-alto/pq/den-kbd-all-110304010217 --target pq
utils/load_exist.pl --suffx xml --user admin --password $1 --host-port xstorage-test-01.kb.dk:8080 --context /exist/rest/db --load ../innovation-alto/pq/den-kbd-all-110308039908 --target pq
utils/load_exist.pl --suffix xml --user admin --password $1 --host-port xstorage-test-01.kb.dk:8080 --context /exist/rest/db --load ../innovation-alto/pq/den-kbd-all-110308027669 --target pq
utils/load_exist.pl --suffix xml --user admin --password $1 --host-port xstorage-test-01.kb.dk:8080 --context /exist/rest/db --load ../innovation-alto/pq/den-kbd-all-110308050622 --target pq


