#java

####Table of Contents

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

##Overview

This is the java module. It allows to install Java OpenJDK and configure the default java alternative.

##Module Description

The module provides classes and defines to install Java OpenJDK and configure the java alternative on Ubuntu platforms.
It allows to install multiple Java versions on the same node.

##Setup

###What java affects

The module install the OpenJDK package from the repositories and set up the alternative system for the java command.

If hiera defines a value for the parameter `java::java_default_version` the alternative system link for the command java is set to manual mode according to specified version. Otherwise it is left as it is.

###Setup Requirements

The module has no special requirements.
	
###Beginning with java	

The module provides two classes to install Java OpenJDK 6 and 7 respectively. This is done, for example, by declarations as the following:

```
include java_7
```

##Usage

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

##Reference

###`java::java_6`
Installs OpenJDK-6 from the repositories.

###`java::java_7`
Installs OpenJDK-7 from the repositories.

####Parameters

#####`java::java_default_version`
If present in a JSON hiera file allows to set the default java command in the alternative system.

##Limitations

At the moment the module targets only OpenJDK on Ubuntu platforms. Specifically, it is tested only on Ubuntu 10.04 and 12.04 distributions, although probably it will work also on more recent versions.

##Development

If you need some feature please send me a (pull) request or send me an email at: dsestero 'at' gmail 'dot' com.

