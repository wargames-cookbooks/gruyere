# CHANGELOG for Gruyere

This file is used to list changes made in each version of gruyere.

## 0.5.0:

* gruyere::apache2_proxy: updates for latest apache2 cookbook (8.1.0)

## 0.4.0:

* Pin apache2 cookbook version to 5.2.1
* Support for debian 9
* CI fixes

## 0.3.0:

* Chef 13 compatibility
* Use Cookstyle instead of rubocop
* Set debian platform version to 8.7

## 0.2.0:

* Chef 12 compatibility
* Use Rake instead of Strainer
* Test harness (rubocop, chefspec, kitchen)
* Debian 7.6 support
* Ubuntu 14.04 support

## 0.1.3:

* Changed license for Apache 2.0

## 0.1.2:

* Integration testing with serverspec and test-kitchen
* Fixed gruyere service
  - Create pidfile when start service
  - Use pidfile for status command

## 0.1.1:

* Readme improvements

## 0.1.0:

* Initial release of gruyere
