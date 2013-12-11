SOLR_VERSION="4.4.0" # Apache Solr version number
APACHESOLR_VERSION="7.x-1.6" # Drupal Apache Solr module version number

apt-get update

cd /vagrant

wget -nc "http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz"
wget -nc "http://ftp.drupal.org/files/projects/apachesolr-$APACHESOLR_VERSION.tar.gz"

tar -xf "solr-$SOLR_VERSION.tgz"
tar -xf "apachesolr-$APACHESOLR_VERSION.tar.gz"

# Copy Solr examples directory
cp -ar "solr-$SOLR_VERSION/example" "solr-$SOLR_VERSION/drupal"

# Copy Drupal Solr config over to Drupal multicore Solr instance
cp -arf apachesolr/tests/conf/* "solr-$SOLR_VERSION/drupal/multicore/core0/conf"
cp -arf apachesolr/solr-conf/solr-4.x/* "solr-$SOLR_VERSION/drupal/multicore/core0/conf"

if [ $SOLR_VERSION = "4.5.0" || $SOLR_VERSION = "4.6.0" ]; then

	# Get path to file that user needs to update
	SOLRCONFIG_PATH=eval "pwd"
	SOLRCONFIG_PATH+="/solr-$SOLR_VERSION/drupal/multicore/core0/conf/solrconfig.xml"

	echo "Version $SOLR_VERSION of Apache Solr module may have some issues with Drupal's solrconfig.xml."
	echo "Check around line 207 of $SOLRCONFIG_PATH and comment out the following:"
	echo ""
	echo "  <useCompoundFile>false</useCompoundFile>"
    echo "  <ramBufferSizeMB>32</ramBufferSizeMB>"
    echo "  <mergeFactor>10</mergeFactor>"
    echo ""
    echo "Please see https://drupal.org/node/2107417 for more information."
fi

cd "solr-$SOLR_VERSION/drupal"
java -Dsolr.solr.home=multicore -jar start.jar

echo "Solr server up and running."
echo "View admin page at http://localhost:8989/solr"