#!/usr/bin/env bash
#-------------------------------------------------------------------------------

#==  FUNCTION  =================================================================
#        NAME: main
# DESCRIPTION:
#===============================================================================
function main() {
    #---------------------------------------------------------------------------
    # TODO: remove hack to determine IPs
    #---------------------------------------------------------------------------
    declare -gr   cinder_proxy_private_address="$( facter ipaddress            )"
    declare -gr      ec2_proxy_private_address="$( facter ipaddress            )"
    declare -gr   glance_proxy_private_address="$( facter ipaddress            )"
    declare -gr keystone_proxy_private_address="$( facter ipaddress            )"
    declare -gr     nova_proxy_private_address="$( facter ipaddress            )"
    declare -gr  neutron_proxy_private_address="$( facter ipaddress            )"
    declare -gr    swift_proxy_private_address="$( facter ipaddress            )"
    declare -gr       s3_proxy_private_address="$( facter ipaddress            )"
    declare -gr           slapd_public_address="$( facter slapd_public_address )"
    declare -gr                   slapd_basedn="$( facter slapd_basedn         )"
    declare -gr                   slapd_binddn="$( facter slapd_binddn         )"
    declare -gr                 slapd_password="$( facter slapd_password       )"
    declare -gr                       slapd_ou="$( facter slapd_ou             )"
    #---------------------------------------------------------------------------
#   manage_db_sync
    create_tenant
    create_role
    create_user
#   create_service
    #---------------------------------------------------------------------------
}

#==  FUNCTION  =================================================================
#        NAME: manage_db_sync
# DESCRIPTION:
#        TODO: migrate to db-relation-changed hook
#===============================================================================
function manage_db_sync() {
    #---------------------------------------------------------------------------
    local password
    #---------------------------------------------------------------------------
    password="$( facter mysql_server_password )"
    #---------------------------------------------------------------------------
    mysql -u root                                                        <<-EOF
	DROP DATABASE IF EXISTS  keystone;
	        CREATE DATABASE  keystone;
	GRANT ALL PRIVILEGES ON  keystone.*
	                     TO 'keystone'@'%'
	          IDENTIFIED BY '${password}';
	GRANT ALL PRIVILEGES ON  keystone.*
	                     TO 'keystone'@'localhost'
	          IDENTIFIED BY '${password}';
	EOF
    #---------------------------------------------------------------------------
    service keystone stop
    #---------------------------------------------------------------------------
    keystone-manage db_sync
    #---------------------------------------------------------------------------
    service keystone start
    #---------------------------------------------------------------------------
}

#==  FUNCTION  =================================================================
#        NAME: create_tenant
# DESCRIPTION:
#===============================================================================
function create_tenant() {
    #---------------------------------------------------------------------------
    local    tenant
    local -a tenants
    #---------------------------------------------------------------------------
    tenants=( admin
              service
              pds-dev-lcms
              pds-dev-lcsa
              pds-dev-lro
              pds-dev-phoenix
              pds-dev-productportal
              pds-int-lcms
              pds-int-lcsa
              pds-int-lro
              pds-int-phoenix
              pds-int-productportal
              pds-stg-lcms
              pds-stg-lcsa
              pds-stg-lro
              pds-stg-phoenix
              pds-stg-productportal
              pds-uat-lcms
              pds-uat-lcsa
              pds-uat-lro
              pds-uat-phoenix
              pds-uat-productportal
              pds-prd-lcms
              pds-prd-lcsa
              pds-prd-lro
              pds-prd-phoenix
              pds-prd-productportal
            )
    #---------------------------------------------------------------------------
    for tenant in ${tenants[@]}
    do
        keystone tenant-create                                                 \
               --enable true                                                   \
               --name   ${tenant}
    done
    #---------------------------------------------------------------------------
}

#==  FUNCTION  =================================================================
#        NAME: create_role
# DESCRIPTION:
#===============================================================================
function create_role() {
    #---------------------------------------------------------------------------
    local    role
    local -a roles
    #---------------------------------------------------------------------------
    roles=( admin
            compute-user
            Member
          )
    #---------------------------------------------------------------------------
    for role in ${roles[@]}
    do
        keystone role-create                                                   \
               --name ${role}
    done
    #---------------------------------------------------------------------------
}

#==  FUNCTION  =================================================================
#        NAME: create_user
# DESCRIPTION:
#===============================================================================
function create_user() {
    #---------------------------------------------------------------------------
    local    email
    local    pass
    local    password
    local    role_id
    local    service
    local -a services
    local    tenant_id
    local    user
    local -a users
    local    user_id
    #---------------------------------------------------------------------------
        pass="changeme"
    password="$( facter mysql_server_password )"
    services=( admin
               cinder
               ec2
               glance
               nova
               neutron
               s3
               swift
             )
       users=(
             $( get_ldap_directReports vsamsalo )
             )
    #---------------------------------------------------------------------------
    for service in ${services[@]}
    do
        tenant_id="$( get_keystone_tenant_ids 'service' )"
          role_id="$( get_keystone_role_ids   'admin'   )"
          user_id="$( keystone user-create                                     \
                             --enabled   true                                  \
                             --name      ${service}                            \
                             --pass      ${password}                           \
                             --tenant_id ${tenant_id}                          \
                    |      awk '/ id / {print $4}'
                    )"
        if [[ "${tenant_id}" ]]                                                \
        && [[ "${user_id}"   ]]                                                \
        && [[ "${role_id}"   ]]
        then
            setup_keystone_user_role_add ${tenant_id} ${user_id} ${role_id}
        fi
    done
    #---------------------------------------------------------------------------
    for user in ${users[@]}
    do
          email="$( get_ldap_email        ${user}                             )"
        user_id="$( get_keystone_user_ids ${user} ${email} ${pass}            )"
        role_id="$( get_keystone_role_ids ${user}                             )"
        #----------------------------------------------------------------------
        for tenant_id in $( get_keystone_tenant_ids 'pds-' )
        do
            if [[ "${tenant_id}" ]]                                            \
            && [[ "${user_id}"   ]]                                            \
            && [[ "${role_id}"   ]]
            then
                setup_keystone_user_role_add ${tenant_id} ${user_id} ${role_id}
            fi
        done
    done
    #---------------------------------------------------------------------------
}

#==  FUNCTION  =================================================================
#        NAME: setup_keystone_user_role_add
# DESCRIPTION:
#===============================================================================
function setup_keystone_user_role_add() {
    #---------------------------------------------------------------------------
    local role_id
    local tenant_id
    local user_id
    #---------------------------------------------------------------------------
    tenant_id="${1}"
      user_id="${2}"
      role_id="${3}"
    #---------------------------------------------------------------------------
    if [[ "${user_id}"   ]]                                                    \
    && [[ "${role_id}"   ]]                                                    \
    && [[ "${tenant_id}" ]]
    then
        keystone user-role-add                                                 \
               --user-id   ${user_id}                                          \
               --role-id   ${role_id}                                          \
               --tenant-id ${tenant_id}
    fi
    #---------------------------------------------------------------------------
}

#==  FUNCTION  =================================================================
#        NAME: create_service
# DESCRIPTION:
#        TODO: load balance services
#===============================================================================
function create_service() {
    #---------------------------------------------------------------------------
    local adminurl
    local internalurl
    local publicurl
    local region
    local service_id
    #---------------------------------------------------------------------------
    region="RegionOne"
    #---------------------------------------------------------------------------
    # TODO: migrate to nova-relation-changed hook
    #---------------------------------------------------------------------------
       adminurl="http://${nova_proxy_private_address}:8774/v2/$(tenant_id)s"
    internalurl="http://${nova_proxy_private_address}:8774/v2/$(tenant_id)s"
      publicurl="http://${nova_proxy_private_address}:8774/v2/$(tenant_id)s"
     service_id="$( keystone service-create                                    \
                           --name         nova                                 \
                           --type         compute                              \
                           --description 'OpenStack Compute Service'           \
                  |      awk '/ id / {print $4}'
                  )"
    #---------------------------------------------------------------------------
    if [[ "${adminurl}"    ]]                                                  \
    && [[ "${internalurl}" ]]                                                  \
    && [[ "${publicurl}"   ]]                                                  \
    && [[ "${service_id}"  ]]
    then
        keystone endpoint-create                                               \
          --region      ${region}                                              \
          --service-id  ${service_id}                                          \
          --adminurl    ${adminurl}                                            \
          --internalurl ${internalurl}                                         \
          --publicurl   ${publicurl}
    fi
    #---------------------------------------------------------------------------
       adminurl="http://${keystone_proxy_private_address}:35357/v2.0"
    internalurl="http://${keystone_proxy_private_address}:5000/v2.0"
      publicurl="http://${keystone_proxy_private_address}:5000/v2.0"
     service_id="$( keystone service-create                                    \
                           --name         keystone                             \
                           --type         identity                             \
                           --description 'OpenStack Identity Service'          \
                  |      awk '/ id / {print $4}'
                  )"
    #---------------------------------------------------------------------------
    if [[ "${adminurl}"    ]]                                                  \
    && [[ "${internalurl}" ]]                                                  \
    && [[ "${publicurl}"   ]]                                                  \
    && [[ "${service_id}"  ]]
    then
        keystone endpoint-create                                               \
          --region      ${region}                                              \
          --service-id  ${service_id}                                          \
          --adminurl    ${adminurl}                                            \
          --internalurl ${internalurl}                                         \
          --publicurl   ${publicurl}
    fi
    #---------------------------------------------------------------------------
    # TODO: migrate to glance-relation-changed hook
    #---------------------------------------------------------------------------
       adminurl="http://${glance_proxy_private_address}:9292/v1"
    internalurl="http://${glance_proxy_private_address}:9292/v1"
      publicurl="http://${glance_proxy_private_address}:9292/v1"
     service_id="$( keystone service-create                                    \
                           --name         glance                               \
                           --type         image                                \
                           --description 'OpenStack Image Service'             \
                  |      awk '/ id / {print $4}'
                  )"
    #---------------------------------------------------------------------------
    if [[ "${adminurl}"    ]]                                                  \
    && [[ "${internalurl}" ]]                                                  \
    && [[ "${publicurl}"   ]]                                                  \
    && [[ "${service_id}"  ]]
    then
        keystone endpoint-create                                               \
          --region      ${region}                                              \
          --service-id  ${service_id}                                          \
          --adminurl    ${adminurl}                                            \
          --internalurl ${internalurl}                                         \
          --publicurl   ${publicurl}
    fi
    #---------------------------------------------------------------------------
    # TODO: migrate to neutron-relation-changed hook
    #---------------------------------------------------------------------------
       adminurl="http://${neutron_proxy_private_address}:9696"
    internalurl="http://${neutron_proxy_private_address}:9696"
      publicurl="http://${neutron_proxy_private_address}:9696"
     service_id="$( keystone service-create                                    \
                           --name         neutron                              \
                           --type         network                              \
                           --description 'OpenStack Network Service'           \
                  |      awk '/ id / {print $4}'
                  )"
    #---------------------------------------------------------------------------
    if [[ "${adminurl}"    ]]                                                  \
    && [[ "${internalurl}" ]]                                                  \
    && [[ "${publicurl}"   ]]                                                  \
    && [[ "${service_id}"  ]]
    then
        keystone endpoint-create                                               \
          --region      ${region}                                              \
          --service-id  ${service_id}                                          \
          --adminurl    ${adminurl}                                            \
          --internalurl ${internalurl}                                         \
          --publicurl   ${publicurl}
    fi
    #---------------------------------------------------------------------------
    # TODO: migrate to swift-proxy-relation-changed hook
    #---------------------------------------------------------------------------
      publicurl="http://${swift_proxy_private_address}:8080/v1/AUTH_$(tenant_id)s"
       adminurl="http://${swift_proxy_private_address}:8080/v1"
    internalurl="http://${swift_proxy_private_address}:8080/v1/AUTH_$(tenant_id)s"
     service_id="$( keystone service-create                                    \
                           --name         swift                                \
                           --type         object-store                         \
                           --description 'OpenStack Storage Service'           \
                  |      awk '/ id / {print $4}'
                  )"
    #---------------------------------------------------------------------------
    if [[ "${adminurl}"    ]]                                                  \
    && [[ "${internalurl}" ]]                                                  \
    && [[ "${publicurl}"   ]]                                                  \
    && [[ "${service_id}"  ]]
    then
        keystone endpoint-create                                               \
          --region      ${region}                                              \
          --service-id  ${service_id}                                          \
          --adminurl    ${adminurl}                                            \
          --internalurl ${internalurl}                                         \
          --publicurl   ${publicurl}
    fi
    #---------------------------------------------------------------------------
    # TODO: migrate to cinder-relation-changed hook
    #---------------------------------------------------------------------------
       adminurl="http://${cinder_proxy_private_address}:8776/v1/$(tenant_id)s"
    internalurl="http://${cinder_proxy_private_address}:8776/v1/$(tenant_id)s"
      publicurl="http://${cinder_proxy_private_address}:8776/v1/$(tenant_id)s"
     service_id="$( keystone service-create                                    \
                           --name         cinder                               \
                           --type         volume                               \
                           --description 'OpenStack Volume Service'            \
                  |      awk '/ id / {print $4}'
                  )"
    #---------------------------------------------------------------------------
    if [[ "${adminurl}"    ]]                                                  \
    && [[ "${internalurl}" ]]                                                  \
    && [[ "${publicurl}"   ]]                                                  \
    && [[ "${service_id}"  ]]
    then
        keystone endpoint-create                                               \
          --region      ${region}                                              \
          --service-id  ${service_id}                                          \
          --adminurl    ${adminurl}                                            \
          --internalurl ${internalurl}                                         \
          --publicurl   ${publicurl}
    fi
    #---------------------------------------------------------------------------
    # TODO: migrate to nova-relation-changed hook
    #---------------------------------------------------------------------------
       adminurl="http://${ec2_proxy_private_address}:8773/services/Admin"
    internalurl="http://${ec2_proxy_private_address}:8773/services/Cloud"
      publicurl="http://${ec2_proxy_private_address}:8773/services/Cloud"
     service_id="$( keystone service-create                                    \
                           --name         ec2                                  \
                           --type         ec2                                  \
                           --description 'EC2 Service'                         \
                  |      awk '/ id / {print $4}'
                  )"
    #---------------------------------------------------------------------------
    if [[ "${adminurl}"    ]]                                                  \
    && [[ "${internalurl}" ]]                                                  \
    && [[ "${publicurl}"   ]]                                                  \
    && [[ "${service_id}"  ]]
    then
        keystone endpoint-create                                               \
          --region      ${region}                                              \
          --service-id  ${service_id}                                          \
          --adminurl    ${adminurl}                                            \
          --internalurl ${internalurl}                                         \
          --publicurl   ${publicurl}
    fi
    #---------------------------------------------------------------------------
    # TODO: migrate to nova-relation-changed hook
    #---------------------------------------------------------------------------
       adminurl="http://${s3_proxy_private_address}:3333"
    internalurl="http://${s3_proxy_private_address}:3333"
      publicurl="http://${s3_proxy_private_address}:3333"
     service_id="$( keystone service-create                                    \
                           --name         s3                                   \
                           --type         s3                                   \
                           --description 'S3 Service'                          \
                  |      awk '/ id / {print $4}'
                  )"
    #---------------------------------------------------------------------------
    if [[ "${adminurl}"    ]]                                                  \
    && [[ "${internalurl}" ]]                                                  \
    && [[ "${publicurl}"   ]]                                                  \
    && [[ "${service_id}"  ]]
    then
        keystone endpoint-create                                               \
          --region      ${region}                                              \
          --service-id  ${service_id}                                          \
          --adminurl    ${adminurl}                                            \
          --internalurl ${internalurl}                                         \
          --publicurl   ${publicurl}
    fi
    #---------------------------------------------------------------------------
}

#==  FUNCTION  =================================================================
#        NAME: get_keystone_tenant_ids
# DESCRIPTION:
#===============================================================================
function get_keystone_tenant_ids() {
    #---------------------------------------------------------------------------
    local tenant
    #---------------------------------------------------------------------------
    tenant="${1}"
    #---------------------------------------------------------------------------
    ( keystone tenant-list                                                     \
    |      awk "/${tenant}/ {print \$2}"
    )
    #---------------------------------------------------------------------------
}

#==  FUNCTION  =================================================================
#        NAME: get_keystone_role_ids
# DESCRIPTION:
#===============================================================================
function get_keystone_role_ids() {
    #---------------------------------------------------------------------------
    local role
    local user
    #---------------------------------------------------------------------------
    user="${1}"
    #---------------------------------------------------------------------------
    if [[ "${user}" =~ "admin" ]]                                              \
    ||  get_ldap_memberOfs ${user}                                             \
    |   grep -q "_LCS Deployment"
    then
        role="admin"
    else
        role="compute-user"
    fi
    #---------------------------------------------------------------------------
    ( keystone role-list                                                       \
    |      awk "/${role}/ {print \$2}"
    )
    #---------------------------------------------------------------------------
}

#==  FUNCTION  =================================================================
#        NAME: get_keystone_user_ids
# DESCRIPTION:
#===============================================================================
function get_keystone_user_ids() {
    #---------------------------------------------------------------------------
    local email
    local pass
    local user
    #---------------------------------------------------------------------------
     user="${1}"
    email="${2}"
     pass="${3}"
    #---------------------------------------------------------------------------
    if [[ "${user}"  ]]                                                        \
    && [[ "${pass}"  ]]                                                        \
    && [[ "${email}" ]]
    then
        keystone user-create                                                   \
               --enabled true                                                  \
               --name    ${user}                                               \
               --pass    ${pass}                                               \
               --email   ${email,,}                                            \
      |      awk '/ id / {print $4}'
    fi
    #---------------------------------------------------------------------------
}

#==  FUNCTION  =================================================================
#        NAME: get_ldap_directReports
# DESCRIPTION:
#===============================================================================
function get_ldap_directReports() {
    #---------------------------------------------------------------------------
    local slapd_cn
    #---------------------------------------------------------------------------
    slapd_cn="${1}"
    #---------------------------------------------------------------------------
    if [[ "${slapd_public_address}" ]]                                         \
    && [[ "${slapd_basedn}"         ]]                                         \
    && [[ "${slapd_binddn}"         ]]                                         \
    && [[ "${slapd_password}"       ]]                                         \
    && [[ "${slapd_cn}"             ]]
    then
      ( echo ${slapd_cn,,}
        for slapd_cn in                                                        \
         $( ldapsearch -x                                                      \
                       -LLL                                                    \
                       -E pr=200/noprompt                                      \
                       -h ${slapd_public_address}                              \
                       -b ${slapd_basedn}                                      \
                       -D ${slapd_binddn}                                      \
                       -w ${slapd_password}                                    \
                     '(&(cn='"${slapd_cn}"')
                      (!(userAccountControl:1.2.840.113556.1.4.803:=2)))'      \
                             directReports                         2>/dev/null \
          |        awk -F '=|,'                                                \
                          '/^directReports:/ {print $2}'
          )
        do
            ( get_ldap_directReports ${slapd_cn} ) &
        done
      )                                                                        \
      | sort
    fi
    #---------------------------------------------------------------------------
}

#==  FUNCTION  =================================================================
#        NAME: get_ldap_email
# DESCRIPTION:
#===============================================================================
function get_ldap_email() {
    #---------------------------------------------------------------------------
    local slapd_cn
    #---------------------------------------------------------------------------
    slapd_cn="${1}"
    #---------------------------------------------------------------------------
    if [[ "${slapd_public_address}" ]]                                         \
    && [[ "${slapd_basedn}"         ]]                                         \
    && [[ "${slapd_binddn}"         ]]                                         \
    && [[ "${slapd_password}"       ]]                                         \
    && [[ "${slapd_cn}"             ]]
    then
      ( ldapsearch -x                                                          \
                   -LLL                                                        \
                   -E pr=200/noprompt                                          \
                   -h ${slapd_public_address}                                  \
                   -b ${slapd_basedn}                                          \
                   -D ${slapd_binddn}                                          \
                   -w ${slapd_password}                                        \
                      '(cn='"${slapd_cn}"')'                                   \
                         mail                                      2>/dev/null \
      |        awk    '/^mail: / {print $2}'
      )
    fi
    #---------------------------------------------------------------------------
}

#==  FUNCTION  =================================================================
#        NAME: get_ldap_memberOfs
# DESCRIPTION:
#===============================================================================
function get_ldap_memberOfs() {
    #---------------------------------------------------------------------------
    local slapd_cn
    #---------------------------------------------------------------------------
    slapd_cn="${1}"
    #---------------------------------------------------------------------------
    if [[ "${slapd_public_address}" ]]                                         \
    && [[ "${slapd_basedn}"         ]]                                         \
    && [[ "${slapd_binddn}"         ]]                                         \
    && [[ "${slapd_password}"       ]]                                         \
    && [[ "${slapd_cn}"             ]]
    then
      ( ldapsearch -x                                                          \
                   -LLL                                                        \
                   -E pr=200/noprompt                                          \
                   -h ${slapd_public_address}                                  \
                   -b ${slapd_basedn}                                          \
                   -D ${slapd_binddn}                                          \
                   -w ${slapd_password}                                        \
                      '(cn='"${slapd_cn}"')'                                   \
                        memberOf                                   2>/dev/null \
      |        awk    '/^memberOf: / {print}'
      )
    fi
    #---------------------------------------------------------------------------
}

main "${@}"
