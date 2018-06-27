#!/opt/puppetlabs/puppet/bin/ruby
require "fileutils"

# rubocop:disable Style/FormatStringToken
pe_conf = <<~pe_conf
  #----------------------------------------------------------------------------
  # Puppet Enterprise installer configuration file
  # https://docs.puppet.com/pe/latest/install_pe_conf_param.html
  #
  # Format: Hocon
  # https://docs.puppet.com/pe/latest/config_hocon.html
  #----------------------------------------------------------------------------
  {
      #--------------------------------------------------------------------------
      # ⚠️  REQUIRED FOR INSTALLATION ⚠️
      #
      # The password to log into the Puppet Enterprise console.
      #
      # After installation, you may set the console_admin_password to an empty
      # string to avoid storing a password in plain text.
      #--------------------------------------------------------------------------
      "console_admin_password": "#{ENV['PT_console_password']}"


  #--------------------------------------------------------------------------
  # PE Component assignments.
  #
  # If you're performing a monolithic install (recommended), there is no need
  # to change the default settings, and you do not need to set the
  # puppetdb_host and console_host parameters.
  #
  # When performing a split install, do not use the %{::trusted.certname} fact.
  # Instead set the FQDN for all three PE component nodes.
  # For more information, refer to:
  # https://docs.puppet.com/pe/latest/install_text_mode_split.html
  #
  # Overview of PE Components:
  # https://docs.puppet.com/pe/latest/pe_architecture_overview.html
  #-------------------------------------------------------------------------

  # Puppet Enterprise Master
  "puppet_enterprise::puppet_master_host": "%{::trusted.certname}"

  # Puppet Enterprise Console
  #"puppet_enterprise::console_host": ""

  # PuppetDB
  #"puppet_enterprise::puppetdb_host": ""

  # Hostname of database node if pe-postgres is being run on its own node
  #"puppet_enterprise::database_host": ""

  #--------------------------------------------------------------------------
  # DATABASE CONFIGURATION
  #
  # Puppet Enterprise uses PostgreSQL as a database backend.
  # PE can install and manage a new one (recommended), or you can use an
  # existing instance.
  #
  # For details on using an existing PostgreSQL database, visit:
  # https://docs.puppet.com/pe/latest/install_system_requirements.html
  #
  # UPGRADE NOTE:
  # If you’re upgrading and have previously used non-default database names and
  # users, you must uncomment and change these parameters to match what you
  # have used.
  #--------------------------------------------------------------------------

  #"puppet_enterprise::activity_database_name": "pe-activity"
  #"puppet_enterprise::activity_service_migration_db_user": "pe-activity"
  #"puppet_enterprise::activity_service_regular_db_user": "pe-activity"
  #"puppet_enterprise::classifier_database_name": "pe-classifier"
  #"puppet_enterprise::classifier_service_migration_db_user": "pe-classifier"
  #"puppet_enterprise::classifier_service_regular_db_user": "pe-classifier"
  #"puppet_enterprise::orchestrator_database_name": "pe-orchestrator"
  #"puppet_enterprise::orchestrator_service_migration_db_user": "pe-orchestrator"
  #"puppet_enterprise::orchestrator_service_regular_db_user": "pe-orchestrator"
  #"puppet_enterprise::rbac_database_name": "pe-rbac"
  #"puppet_enterprise::rbac_service_migration_db_user": "pe-rbac"
  #"puppet_enterprise::rbac_service_regular_db_user": "pe-rbac"
  #"puppet_enterprise::puppetdb_database_name": "pe-puppetdb"
  #"puppet_enterprise::puppetdb_database_user": "pe-puppetdb"


  # EXTERNAL POSTGRES OPTIONS ONLY
  # If you're using an existing PostgreSQL instance that was not set up by
  # Puppet Enterprise, set the following parameters:

  #"puppet_enterprise::database_ssl": false
  #"puppet_enterprise::database_cert_auth": false
  #"puppet_enterprise::activity_database_password": "PASSWORD"
  #"puppet_enterprise::classifier_database_password": "PASSWORD"
  #"puppet_enterprise::orchestrator_database_password": "PASSWORD"
  #"puppet_enterprise::rbac_database_password": "PASSWORD"
  #"puppet_enterprise::puppetdb_database_password": "PASSWORD"


  #--------------------------------------------------------------------------
  # ADVANCED AND CUSTOM PARAMETERS
  #
  # You can use the following parameters as needed, or add your own parameters
  # to this section.
  #
  # For a complete list of parameters and what they do, visit:
  # https://docs.puppet.com/pe/latest/install_pe_conf_param.html
  #--------------------------------------------------------------------------

  # DNS altnames to be added to the SSL certificate generated for the Puppet
  # master node. Only used at install time.
  #"pe_install::puppet_master_dnsaltnames": ["puppet"]

  #Enabling this configures code manager, all three below values should be enabled and populated at the same time.
  #"puppet_enterprise::profile::master::code_manager_auto_configure": true

  #The ssh url to your existing control repo.
  #"puppet_enterprise::profile::master::r10k_remote": "git@your.git.server.com:puppet/control.git"

  #The private key to your puppetmaster for establishing key-based ssh authentication to your vcs.
  #"puppet_enterprise::profile::master::r10k_private_key": "/etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa"

  #test key that does nothing
  "ref_arch::name": "basic"
  }
pe_conf
# rubocop:enable Style/FormatStringToken

FileUtils.mkdir_p "/tmp/ref_arch_setup" unless Dir.exist? "/tmp/ref_arch_setup"
File.open("/tmp/ref_arch_setup/pe.conf", "w") { |f| f.write(pe_conf) }
