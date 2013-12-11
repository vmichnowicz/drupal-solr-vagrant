# Solr Vagrant

````
vagrant up
vagrant provision
````

This will install Solr in a multiple core configuration. It will override `core0` with config files from the Drupal Solr module. Solr admin will then be accessible from http://localhost:8989/solr. The Solr core will be accessible from http://localhost:8989/solr/core0.

After the initial `vagrant provision` you can start Solr again by SSHing into your Vagrant box and starting Solr manually:

````
cd /vagrant/solr-4.4.0/drupal
java -Dsolr.solr.home=multicore -jar start.jar
````