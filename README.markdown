# java

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with java](#setup)
    * [What java affects](#what-java-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with java](#beginning-with-java)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This is the java module. It allows to install Java OpenJDK or Oracle JDK and configure the default java alternative.

## Module Description

The module provides classes and defines to install Java OpenJDK from distribution packages
or rather install Oracle JDK. Furthermore, it allows to configure the java alternative on Debian and RedHat family distributions.
It allows to install multiple Java versions on the same node.
It allows to install java 8 even if it is not in the standard repository in Ubuntu 12.04 and 14.04 via ppa.

## Setup

### What java affects

The module installs the OpenJDK package from the repositories or the Oracle JDK from the download archive.

If required, the module sets up the alternative system for the java command.
This is specified by providing a hiera value for the parameter `java::java_default_version`;
in that case, the alternative system link for the command java is set to manual mode according to specified version.
Otherwise it is left as it is.

In case java 8 installation is required on Ubuntu 12.04 or Ubuntu 14.04 the repository `ppa:openjdk-r/ppa` is added.

The module provides a jce_policy_6 class to be used to override two libraries in the standard java distribution.
Due to import control restrictions, the version of JCE policy files that
are bundled in the JDK(TM) 6 environment allow "strong" but limited
cryptography to be used. This override provides "unlimited strength"
policy files which contain no restrictions on cryptographic strengths.
Notice that at the moment this class supports only openjdk-6 on Debian/Ubuntu systems.

### Setup Requirements

The module requires the following modules:

* puppetlabs/apt

    to manage apt repositories

* dsestero/download_uncompress

    to provide the basic capability to download and unzip Oracle Java distributions
	
### Beginning with java	

The module provides different classes to install Java OpenJDK 6, 7, 8 and 9; furthermore, it is possible to install Oracle JDK 7 and 8.
This is done, for example, by declarations as the following:

```
include java_7
```

## Usage

It is possible to install multiple versions of Java on a single node and to specify via hiera the default java to be set in the alternative system. An example hiera (JSON) declaration for a node could be as follows:

```
{
  "classes" : [
    "java::java_6",
    "java::java_7"
    ],
  "java::java_default_version" : "6"
}
```

## Limitations

At the moment the module targets only OpenJDK 6, 7 and 8 on Debian, Ubuntu, RedHat and CentOS platforms. Specifically, it was tested on Ubuntu 12.04, 14.04, 16.04 and CentOS 6.6 distributions; although probably it will work also on different versions.

## Development

If you need some feature please send me a (pull) request and send me an email at: dsestero 'at' gmail 'dot' com.

