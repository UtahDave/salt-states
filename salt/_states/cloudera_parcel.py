# -*- coding: utf-8 -*-
'''
Manage Cloudera Parcels
=======================

:maintainer: Khris Richardson <khris.richardson@gmail.com>
:maturity:   new
:depends:    cm_api Python module
:platform:   all

Example:

.. code-block:: yaml

    CDH:
        cloudera_parcel.installed:
          - cluster: Cluster 1 - CDH4
          - version: 4.5.0-1.cdh4.5.0.p0.30
'''

# Import python libs
import logging

log = logging.getLogger(__name__)

try:
    from cm_api.api_client import ApiResource
    HAS_CMAPI = True
except ImportError:
    HAS_CMAPI = False


def __virtual__():
    '''
    Only load if Cloudera Manager API is available.
    '''
    return 'cloudera_parcel' if HAS_CMAPI else False


def installed(name, version, cluster, **cm_args):
    '''
    Verify that the parcel is installed, and that it is the correct version
    (if specified).

    name
        The name of the product to be installed.

    version
        The version of the product to be installed.

    cluster
        The cluster on which to install the product.
    '''
    ret = {'changes' : {},
           'comment' : '',
           'name'    : name,
           'result'  : False}
    if __salt__['cloudera.parcel_is_installed'](name, version,
                                                cluster, **cm_args):
        ret['result'] = True
        ret['comment'] = '{0}-{1} already installed'.format(name, version)
        return ret


def removed(name, cluster, **cm_args):
    '''
    Verify that the parcel is removed.

    name
        The name of the product to be removed.

    version
        The version of the product to be removed.

    cluster
        The cluster from which to remove the product.
    '''
    ret = {'changes' : {},
           'comment' : '',
           'name'    : name,
           'result'  : False}
    if not __salt__['cloudera.parcel_is_installed'](name, version,
                                                    cluster, **cm_args):
        ret['result'] = True
        ret['comment'] = '{0}-{1} already removed'.format(name, version)
        return ret
